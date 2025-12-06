import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/services/threads/threads_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/services/alerts/notification_service.dart';
import 'package:medicos/shared/utils/tools.dart';
import 'package:medicos/shared/widgets/custom_notification.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/upload_documents/children/request_documents/domain/dtos/tipye_documents_dto.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/upload_documents/children/request_documents/domain/repositories/request_documents_repository.dart';
import 'package:medicos/src/modules/welcome/widgets/modal_informative.dart';

part 'request_documents_model.dart';

class RequestDocumentsController extends GetxController
    with StateMixin<_RequestDocumentsModel> {
  final ThreadsService threadsService = Get.find();
  final RequestDocumentsRepository apiConn = Get.find();
  final NotificationServiceImpl _notification = Get.find();

  final AppStateController appState = Get.find<AppStateController>();
  UserModel get user => appState.user;

  final Rx<String?> selectedDocumentType = Rx<String?>(null);
  final Rx<PlatformFile?> selectedFile = Rx<PlatformFile?>(null);
  String idSolicitud = '';

  RxBool isLoading = false.obs;
  RxBool areAllDocumentsUploaded = false.obs;

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

  Future<void> pickDocument() async {
    if ((state?.listUploadedDocuments ?? []).any((doc) => 
    doc.tipo == selectedDocumentType.value)) {
      await _showModalReplace();
    } else {
      await _uploadFile();
    }
  }

  Future<void> _uploadFile() async {
    final PlatformFile? file = await appService.fileStorage.pickFile(
      allowedExtensions: ['jpg', 'png', 'pdf', 'xml', 'doc'],
      mbSize: 3
    );
    if (file != null) {
      selectedFile.value = file;
      await uploadSelectedDocument(idSolicitud);
    }
  }

  Future<void> uploadSelectedDocument(String idSolicitud) async {
    if (selectedDocumentType.value == null) {
      _notification.show(
        title: 'Atención',
        message: 'Por favor, selecciona un tipo de documento.',
        type: AlertType.warning,
      );
      return;
    }

    if (selectedFile.value == null) {
      _notification.show(
        title: 'Atención',
        message: 'Por favor, selecciona un archivo para subir.',
        type: AlertType.warning,
      );
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
          await apiConn.uploadDocument(
            jwt: user.token.jwt,
            idSolicitud: idSolicitud,
            nameFile: description,
            typeFile: selectedDocumentType.value.value(),
            fileBytes: selectedFile.value!.bytes!,
          );
        },
      );
      _notification.show(
        title: 'Éxito',
        message: 'El documento se ha subido correctamente.',
        type: AlertType.success,
      );
      await getUploadedDocuments();
    } on Exception catch (_) {
      _notification.show(
        title: 'Error',
        message: 'No se pudo subir el archivo. Inténtalo de nuevo.',
        type: AlertType.error,
      );
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
      _notification.show(
        title: 'Error',
        message: 'No se pudieron cargar los archivos',
        type: AlertType.error,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteDocument(String documentId) async {
    isLoading.value = true;
    if (documentId.isEmpty) {
      _notification.show(
        title: 'Error',
        message: 'El documento no tiene un ID válido para ser eliminado.',
        type: AlertType.error,
      );
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
      _notification.show(
        title: 'Éxito',
        message: 'El documento se ha eliminado correctamente.',
        type: AlertType.success,
      );
      await getUploadedDocuments();
    } on Exception catch (_) {
      _notification.show(
        title: 'Error',
        message: 'No se pudo eliminar el archivo. Inténtalo de nuevo.',
        type: AlertType.error,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendAgreement() async {
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
      _notification.show(
        title: 'Éxito',
        message: 'La solicitud de convenio ha sido enviada correctamente.',
        type: AlertType.success,
      );
      Get
        ..back()
        ..back(result: true);
    } on Exception catch (_) {
      _notification.show(
        title: 'Error',
        message: 'No se pudo enviar la solicitud. Inténtalo de nuevo.',
        type: AlertType.error,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _checkAllDocumentsUploaded() {
    if (state == null) {
      areAllDocumentsUploaded.value = false;
      return;
    }

    final List<TypeDocumentModel> requiredDocs = state!.listTypeDocuments;
    final List<TypeDocumentModel> uploadedDocs = state!.listUploadedDocuments;

    if (requiredDocs.isEmpty) {
      areAllDocumentsUploaded.value = false;
      return;
    }
    areAllDocumentsUploaded.value = uploadedDocs.length >= requiredDocs.length;
  }

  Future<void> _showModalReplace() async {
    if (!kIsWeb) {
          await showModalBottomSheet(
        context: Get.context!,
        builder: (context) => ModalInformative(
          message: 'Estimado usuario, ya se encuentra ese'
          ' tipo de archivo cargado.\n\n'
          ' ¿Está seguro de actualizarlo?',
          okMessage: msg.accept.value,
          onOk: _uploadFile,
          onCancel: Get.back,
        ),
        isScrollControlled: true,
        isDismissible: false,
      );
    }
  }
}
