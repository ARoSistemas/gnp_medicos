import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/services/alerts/notification_service.dart';
import 'package:medicos/shared/widgets/custom_notification.dart';
import 'package:medicos/src/modules/formats/domain/remote/formats_repository.dart';

part 'upload_documents_model.dart';

class UploadDocumentsController extends GetxController
  with StateMixin<_UploadDocumentsModel> {
    final NotificationServiceImpl _notification = appService.notifications;
    final AppStateController appState = Get.find<AppStateController>();
    final FormatsRepository apiConn = Get.find();
    UserModel get user => appState.user;

  final RxInt selectedIndex = 0.obs;
  final Rx<String?> selectedItem = Rx<String?>(null);
  final RxBool loading = false.obs;

  final List<String> items = ['Carta de adhesión', 'Opción 2', 'Opción 3'];

  List<Map<String, String>> documentCardsWithoutOnTap = [
    {
      'title': 'Cédula CURP vigente',
      'description': 'Descripción del documento',
    },
    {
      'title': 'Cédula de la especialidad',
      'description': 'ambos lados',
    },
    {
      'title': 'Cédula profesinal',
      'description': 'ambos lados',
    },
    {
      'title': 'Cédula RFC',
      'description': 'ambos lados',
    },
    {
      'title': 'Certificación recertificación vigente o ...',
      'description': 'ambos lados',
    },
    {
      'title': 'Estado de Cuenta Bancario Actualizado',
      'description': 'Descripción del documento',
    },
    {
      'title': 'Identificación Oficial vigente por ambos ...',
      'description': 'Descripción del documento',
    },
    {
      'title': 'Póliza de responsabilidad profesional vi...',
      'description': 'Descripción del documento',
    },
    {
      'title': 'Título Profesional',
      'description': 'Descripción del documento',
    },
    {
      'title': 'Título especialidad(Opcional)',
      'description': 'Descripción del documento',
    },
    {
      'title': 'Título subespecialidad(Opcional)',
      'description': 'Descripción del documento',
    },
    {
      'title': 'Cédula subespecialidad(Opcional)',
      'description': 'Descripción del documento',
    },
  ];

  void updateSelectedValue(String? newValue) {
    if (newValue != null) {
      selectedItem.value = newValue;
    }
  }

  Future<void> downloadFormato(String filename) async {
    try {
      loading.value = true;
      final Uint8List? response = await apiConn
      .downloadFormat(filename);
     loading.value = false;
      if (response != null) {
        await appService.fileStorage.downloadAndShareFile(
          data: response, 
          fileName: filename
        );
      } else {
        _notification.show(
          title: 'Error',
          message: 'No se logró obtener el formato.',
          type: AlertType.error,
        );
      }
    } on Exception catch (e) {
      loading.value = false;
      _notification.show(
        title: 'Error',
        message: 'Ocurrió el detalle $e.',
        type: AlertType.error,
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    const _UploadDocumentsModel solicitudDocumentacionModel =
        _UploadDocumentsModel();
    change(solicitudDocumentacionModel, status: RxStatus.success());
  }
}
