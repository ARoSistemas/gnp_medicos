import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/services/alerts/notification_service.dart';
import 'package:medicos/shared/widgets/custom_notification.dart';
import 'package:medicos/src/modules/convenio_medico/children/view_pdf/domain/remote/view_pdf_repository.dart';

part 'view_pdf_model.dart';

class ViewPdfController extends GetxController with StateMixin<_ViewPdfModel> {
  final ViewPdfRepository viewPdfRepository = Get.put(ViewPdfRepository());
  final AppStateController stateController = Get.find<AppStateController>();
  final NotificationServiceImpl _notification = AppService.i.notifications;
  RxBool isLoading = false.obs;
  Uint8List? documentLineamiento;

  @override
  Future<void> onInit() async {
    super.onInit();
    const _ViewPdfModel viewPdfModel = _ViewPdfModel();
    change(viewPdfModel, status: RxStatus.success());
    await getDocument();
  }

  Future<void> getDocument() async {
    try {
      isLoading.value = true;
      final Uint8List? response = await viewPdfRepository.downloadLineamiento();
      isLoading.value = false;
      if (response != null) {
        documentLineamiento = response;
      } else {
        _notification.show(
          title: 'Error',
          message: 'No se logró obtener el documento',
          type: AlertType.error,
        );
        Get.back();
      }
    } on Exception catch (e) {
      isLoading.value = false;
      _notification.show(
        title: 'Error',
        message: 'Ocurrió el detalle $e',
        type: AlertType.error,
      );
      Get.back();
    }
  }

  Future<void> downloadDevice() async {
    if (documentLineamiento != null) {
      final fileName = 'lineamientos_${stateController.user.rfc}.pdf';
      await appService.fileStorage.downloadAndShareFile(
        data: documentLineamiento!,
        fileName: fileName
      );
    } else {
      _notification.show(
        title: 'Error',
        message: 'Documento no disponible',
        type: AlertType.error,
      );
    }
  }
}
