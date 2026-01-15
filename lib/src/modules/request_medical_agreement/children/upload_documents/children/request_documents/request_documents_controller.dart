import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/services/threads/threads_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/utils/tools.dart';
import 'package:medicos/shared/widgets/custom_alert.dart';
import 'package:medicos/src/modules/request_medical_agreement/children/upload_documents/children/request_documents/domain/dtos/tipye_documents_dto.dart';
import 'package:medicos/src/modules/request_medical_agreement/children/upload_documents/children/request_documents/domain/repositories/request_documents_repository.dart';
import 'package:medicos/src/modules/view_pdf/view_pdf_page.dart';
import 'package:medicos/src/modules/welcome/widgets/modal_informative.dart';

part 'request_documents_model.dart';

class RequestDocumentsController extends GetxController
    with StateMixin<_RequestDocumentsModel> {
  final ThreadsService threadsService = Get.find();
  final RequestDocumentsRepository apiConn = Get.find();

  final AppStateController appState = Get.find<AppStateController>();
  UserModel get user => appState.user;

  final Rx<String?> selectedDocumentType = Rx<String?>(null);
  final Rx<PlatformFile?> selectedFile = Rx<PlatformFile?>(null);
  String idSolicitud = '';

  RxBool isLoading = true.obs;
  RxBool areAllDocumentsUploaded = false.obs;
  RxBool isDragging = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());
    idSolicitud = Get.arguments;
    await getTypeDocuments();
    await getUploadedDocuments();
  }

  /*  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  } */

  Future<void> getTypeDocuments() async {
    change(state, status: RxStatus.loading());
    await threadsService.execute(
      func: () async {
        final List<TypeDocumentModel> typeDocuments = await apiConn
            .getTypeDocuments(user.token.jwt);
        typeDocuments.sort((a, b) {
          final String nombreA = Tools().removeDiacritics(a.descripcion);
          final String nombreB = Tools().removeDiacritics(b.descripcion);
          return nombreA.compareTo(nombreB);
        });

        change(
          (state ?? _RequestDocumentsModel.empty()).copyWith(
            listTypeDocuments: typeDocuments,
          ),
          status: RxStatus.success(),
        );
      },
    );
  }

  Future<void> onDocumentTypeChanged(String? value) async {
    selectedDocumentType.value = value;
  }

  void onDragEntered() {
    isDragging.value = true;
  }

  void onDragExited() {
    isDragging.value = false;
  }

  Future<void> onDragDone(DropDoneDetails details) async {
    isDragging.value = false;
    if (details.files.isNotEmpty) {
      await handleDroppedFile(details.files.first);
    }
  }

  Future<void> pickDocument() async {
    if ((state?.listUploadedDocuments ?? []).any(
      (doc) => doc.tipo == selectedDocumentType.value,
    )) {
      await _showModalReplace();
    } else {
      await _uploadFile();
    }
  }

  Future<void> handleDroppedFile(XFile file) async {
    // Validar tipo de documento seleccionado
    if (selectedDocumentType.value == null) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (Get.context != null) {
        appService.alert.show(
          title: 'Atención',
          message:
              'Por favor, selecciona un tipo de documento antes de '
              'arrastrar el archivo.',
          type: AlertType.warning,
        );
      }
      return;
    }

    // Validar extensión
    final String extension = file.name.split('.').last.toLowerCase();
    const List<String> allowedExtensions = [
      'jpg',
      'png',
      'pdf',
      'xml',
      'doc',
      'docx',
    ];

    if (!allowedExtensions.contains(extension)) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (Get.context != null) {
        appService.alert.show(
          title: 'Formato no válido',
          message: 'El archivo debe ser: ${allowedExtensions.join(", ")}',
          type: AlertType.warning,
        );
      }
      return;
    }

    // Validar tamaño
    final int fileSize = await file.length();
    const int maxSize = 3 * 1024 * 1024; // 3 MB

    if (fileSize > maxSize) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (Get.context != null) {
        appService.alert.show(
          title: 'Archivo muy grande',
          message: 'El archivo no debe superar los 3 MB.',
          type: AlertType.warning,
        );
      }
      return;
    }

    // Si todas las validaciones pasan, procesar el archivo
    final Uint8List bytes = await file.readAsBytes();
    selectedFile.value = PlatformFile(
      name: file.name,
      size: fileSize,
      bytes: bytes,
    );

    // Esperar un momento antes de mostrar modales
    await Future.delayed(const Duration(milliseconds: 100));

    if (Get.context == null) {
      return;
    }

    if ((state?.listUploadedDocuments ?? []).any(
      (doc) => doc.tipo == selectedDocumentType.value,
    )) {
      await _showModalReplace();
    } else {
      await uploadSelectedDocument(idSolicitud);
    }
  }

  Future<void> _uploadFile() async {
    final PlatformFile? file = await appService.fileStorage.pickFile(
      allowedExtensions: ['jpg', 'png', 'pdf', 'xml', 'docx'],
      mbSize: 3,
    );
    if (file != null) {
      selectedFile.value = file;
      await uploadSelectedDocument(idSolicitud);
    }
  }

  Future<void> uploadSelectedDocument(String idSolicitud) async {
    if (selectedDocumentType.value == null) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (Get.context != null) {
        appService.alert.show(
          title: 'Atención',
          message: 'Por favor, selecciona un tipo de documento.',
          type: AlertType.warning,
        );
      }
      return;
    }

    if (selectedFile.value == null) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (Get.context != null) {
        appService.alert.show(
          title: 'Atención',
          message: 'Por favor, selecciona un archivo para subir.',
          type: AlertType.warning,
        );
      }
      return;
    }

    isLoading.value = true;
    try {
      await threadsService.execute(
        func: () async {
          if (state == null) {
            return;
          }

          final String description = state!.listTypeDocuments
              .firstWhere(
                (doc) => doc.cveTipoDocumento == selectedDocumentType.value,
              )
              .descripcion
              .value();

          final String extension = selectedFile.value!.name.split('.').last;

          final Uint8List fileBytes = await _getFileBytes(selectedFile.value!);

          await apiConn.uploadDocument(
            jwt: user.token.jwt,
            idSolicitud: idSolicitud,
            nameFile: '$description.$extension',
            typeFile: selectedDocumentType.value.value(),
            fileBytes: fileBytes,
          );
        },
      );

      // Esperar antes de mostrar notificación
      await Future.delayed(const Duration(milliseconds: 100));
      if (Get.context != null) {
        appService.alert.show(
          title: 'Éxito',
          message: 'El documento se ha subido correctamente.',
          type: AlertType.success,
        );
      }
      await getUploadedDocuments();
    } on Exception catch (_) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (Get.context != null) {
        appService.alert.show(
          title: 'Error',
          message: 'No se pudo subir el archivo. Inténtalo de nuevo.',
          type: AlertType.error,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getUploadedDocuments() async {
    isLoading.value = true;
    try {
      await threadsService.execute(
        func: () async {
          final List<TypeDocumentModel> response = await apiConn
              .getUploadedDocuments(
                user.token.jwt,
                idSolicitud,
              );
          change(
            (state ?? _RequestDocumentsModel.empty()).copyWith(
              listUploadedDocuments: response,
            ),
            status: RxStatus.success(),
          );
        },
      );
      _checkAllDocumentsUploaded();
    } on Exception catch (_) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (Get.context != null) {
        appService.alert.show(
          title: 'Error',
          message: 'No se pudieron cargar los archivos',
          type: AlertType.error,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteDocument(String documentId) async {
    isLoading.value = true;
    if (documentId.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (Get.context != null) {
        appService.alert.show(
          title: 'Error',
          message: 'El documento no tiene un ID válido para ser eliminado.',
          type: AlertType.error,
        );
      }
      isLoading.value = false;
      return;
    }
    try {
      await threadsService.execute(
        func: () async {
          final Response response = await apiConn.deleteUploadedDocument(
            user.token.jwt,
            documentId,
          );
          if (!response.isOk) {
            throw Exception('Failed to delete document');
          }
        },
      );

      await Future.delayed(const Duration(milliseconds: 100));
      if (Get.context != null) {
        appService.alert.show(
          title: 'Éxito',
          message: 'El documento se ha eliminado correctamente.',
          type: AlertType.success,
        );
      }
      await getUploadedDocuments();
    } on Exception catch (_) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (Get.context != null) {
        appService.alert.show(
          title: 'Error',
          message: 'No se pudo eliminar el archivo. Inténtalo de nuevo.',
          type: AlertType.error,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendAgreement({bool? isWeb}) async {
    isLoading.value = true;
    try {
      await threadsService.execute(
        func: () async {
          await apiConn.sendAgreementRequest(
            jwt: user.token.jwt,
            idSolicitud: idSolicitud,
          );
        },
      );

      await Future.delayed(const Duration(milliseconds: 100));
      if (Get.context != null) {
        appService.alert.show(
          title: 'Éxito',
          message: 'La solicitud de convenio ha sido enviada correctamente.',
          type: AlertType.success,
        );
      }
      if (isWeb ?? false) {
        Get.back(result: true);
      } else {
        Get
          ..back()
          ..back(result: true);
      }
    } on Exception catch (_) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (Get.context != null) {
        appService.alert.show(
          title: 'Error',
          message: 'No se pudo enviar la solicitud. Inténtalo de nuevo.',
          type: AlertType.error,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void _checkAllDocumentsUploaded() {
    if (state == null) {
      areAllDocumentsUploaded.value = false;
      return;
    }

    final List<TypeDocumentModel> allTypes = state!.listTypeDocuments;
    final List<TypeDocumentModel> uploadedDocs = state!.listUploadedDocuments;

    if (allTypes.isEmpty) {
      areAllDocumentsUploaded.value = false;
      return;
    }

    final List<String> optionalKeywords = [
      'subespecialidad',
      'certificacion',
      'recertificacion',
      'certificación',
      'recertificación',
    ];

    final List<TypeDocumentModel> mandatoryTypes = allTypes.where((type) {
      final String description = type.descripcion.value().toLowerCase();
      final String cleanDescription = Tools().removeDiacritics(description);
      return !optionalKeywords.any(
        (keyword) =>
            cleanDescription.contains(keyword) || description.contains(keyword),
      );
    }).toList();

    final bool allMandatoryUploaded = mandatoryTypes.every(
      (mandatory) => uploadedDocs.any(
        (uploaded) => uploaded.tipo == mandatory.cveTipoDocumento,
      ),
    );

    areAllDocumentsUploaded.value = allMandatoryUploaded;
  }

  Future<void> viewDocument(String documentId, String documentName) async {
    isLoading.value = true;
    final Uint8List? documentBytes;

    try {
      documentBytes = await apiConn.getDocument(
        jwt: user.token.jwt,
        idDocument: documentId,
      );

      isLoading.value = false;

      if (documentBytes != null) {
        await Get.toNamed(
          ViewPdfPage.page.name,
          arguments: {
            'file': documentBytes,
            'title': documentName,
            'download': true,
          },
        );
      } else {
        await Future.delayed(const Duration(milliseconds: 100));
        if (Get.context != null) {
          appService.alert.show(
            title: 'Error',
            message: 'No se pudo cargar el documento.',
            type: AlertType.error,
          );
        }
      }
    } on Exception catch (_) {
      isLoading.value = false;
      await Future.delayed(const Duration(milliseconds: 100));
      if (Get.context != null) {
        appService.alert.show(
          title: 'Error',
          message: 'No se pudo cargar el documento. Inténtalo de nuevo.',
          type: AlertType.error,
        );
      }
    }
  }

  Future<void> _replaceDocument() async {
    final PlatformFile? file = await appService.fileStorage.pickFile(
      allowedExtensions: ['jpg', 'png', 'pdf', 'xml', 'docx'],
      mbSize: 3,
    );
    if (file != null) {
      selectedFile.value = file;

      final TypeDocumentModel docToDelete = state!.listUploadedDocuments
          .firstWhere((doc) => doc.tipo == selectedDocumentType.value);

      isLoading.value = true;
      try {
        await threadsService.execute(
          func: () async {
            final Response response = await apiConn.deleteUploadedDocument(
              user.token.jwt,
              docToDelete.id.value(),
            );
            if (!response.isOk) {
              throw Exception('Failed to delete document');
            }

            if (state == null) {
              return;
            }

            final String description = state!.listTypeDocuments
                .firstWhere(
                  (doc) => doc.cveTipoDocumento == selectedDocumentType.value,
                )
                .descripcion
                .value();

            final String extension = selectedFile.value!.name.split('.').last;

            final Uint8List fileBytes = await _getFileBytes(
              selectedFile.value!,
            );

            await apiConn.uploadDocument(
              jwt: user.token.jwt,
              idSolicitud: idSolicitud,
              nameFile: '$description.$extension',
              typeFile: selectedDocumentType.value.value(),
              fileBytes: fileBytes,
            );
          },
        );

        await Future.delayed(const Duration(milliseconds: 100));
        if (Get.context != null) {
          appService.alert.show(
            title: 'Éxito',
            message: 'El documento se ha reemplazado correctamente.',
            type: AlertType.success,
          );
        }
        await getUploadedDocuments();
      } on Exception catch (_) {
        await Future.delayed(const Duration(milliseconds: 100));
        if (Get.context != null) {
          appService.alert.show(
            title: 'Error',
            message: 'No se pudo reemplazar el archivo. Inténtalo de nuevo.',
            type: AlertType.error,
          );
        }
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> _showModalReplace() async {
    await appService.alert.showAlert(
      child: ModalInformative(
        message:
            'Estimado usuario, ya se encuentra ese'
            ' tipo de archivo cargado.\n\n'
            ' ¿Está seguro de actualizarlo?',
        okMessage: msg.accept.tr(),
        onOk: _replaceDocument,
        onCancel: Get.back,
      ),
    );
  }

  Future<Uint8List> _getFileBytes(PlatformFile file) async {
    if (file.bytes != null) {
      return file.bytes!;
    }
    if (file.path != null) {
      return XFile(file.path!).readAsBytes();
    }
    throw Exception('No se pudo leer el archivo: bytes y path son nulos');
  }
}
