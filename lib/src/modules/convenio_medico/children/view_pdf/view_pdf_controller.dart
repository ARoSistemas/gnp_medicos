import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/shared/constans/constans.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/services/alerts/notification_service.dart';
import 'package:medicos/shared/widgets/custom_notification.dart';
import 'package:medicos/src/modules/convenio_medico/domain/remote/convenio_medico_repository.dart';

part 'view_pdf_model.dart';

class ViewPdfController extends GetxController with StateMixin<_ViewPdfModel> {
  final ConvenioMedicoRepository convenioMedicoRepository = 
  Get.put(ConvenioMedicoRepository());
  final AppStateController stateController = Get.find<AppStateController>();
  final NotificationServiceImpl _notification = AppService.i.notifications;
  RxBool isLoading = false.obs;
  Uint8List? document;
  late final String type;

  @override
  Future<void> onInit() async {
    super.onInit();
    const _ViewPdfModel viewPdfModel = _ViewPdfModel();
    change(viewPdfModel, status: RxStatus.success());
    type = Get.arguments;
    await getDocument();
  }

  Future<void> getDocument() async {
    try {
      isLoading.value = true;
      final Uint8List? response = (type == FileTypesAgree.agreement) ? 
        await convenioMedicoRepository.donwMoloadMedicalAgreement(
          stateController.user.codigoFiliacion
        ) :
        await convenioMedicoRepository.downloadLineamiento();
      isLoading.value = false;
      if (response != null) {
        document = response;
      } else {
        _notification.show(
          title: 'Error',
          message: 'No se logró obtener el documento.',
          type: AlertType.error,
        );
        Get.back();
      }
    } on Exception catch (e) {
      isLoading.value = false;
      _notification.show(
        title: 'Error',
        message: 'Ocurrió el detalle $e.',
        type: AlertType.error,
      );
      Get.back();
    }
  }

  Future<void> downloadDevice() async {
    if (document != null) {
      final fileName = '${type}_${stateController.user.rfc}.pdf';
      await appService.fileStorage.downloadAndShareFile(
        data: document!,
        fileName: fileName
      );
    } else {
      _notification.show(
        title: 'Error',
        message: 'Documento no disponible.',
        type: AlertType.error,
      );
    }
  }
}
