import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/services/alerts/notification_service.dart';
import 'package:medicos/shared/widgets/custom_notification.dart';
import 'package:medicos/src/modules/convenio_medico/domain/remote/convenio_medico_repository.dart';
import 'package:url_launcher/url_launcher.dart';

part 'convenio_medico_model.dart';

class ConvenioMedicoController extends GetxController
    with StateMixin<_ConvenioMedicoModel> {
  final ConvenioMedicoRepository convenioMedicoRepository = Get.put(
    ConvenioMedicoRepository(),
  );
  RxBool isLoadingDownload = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController rfcController = TextEditingController();
  final TextEditingController doctorsNameController = TextEditingController();
  final TextEditingController specialtyController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController medicalCircleController = TextEditingController();
  final TextEditingController medicalChartController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController validityAgreementController =
      TextEditingController();

  final AppStateController appState = Get.find<AppStateController>();
  final NotificationServiceImpl _notification = AppService.i.notifications;
  UserModel get user => appState.user;

  @override
  void onInit() {
    super.onInit();
    const _ConvenioMedicoModel convenioMedicoModel = _ConvenioMedicoModel();
    loadDataConvenio();
    change(convenioMedicoModel, status: RxStatus.success());
  }

  /*   @override
  void onReady() {
    super.onReady();
  } */

  @override
  void onClose() {
    codeController.dispose();
    rfcController.dispose();
    doctorsNameController.dispose();
    specialtyController.dispose();
    stateController.dispose();
    medicalCircleController.dispose();
    medicalChartController.dispose();
    statusController.dispose();
    validityAgreementController.dispose();
    super.onClose();
  }

  void loadDataConvenio() {
    emailController.text = appState.user.email;
    rfcController.text = appState.user.rfc;
    doctorsNameController.text = appState.user.nombreCompleto;
    specialtyController.text = appState.user.especialidad;
    stateController.text = appState.user.estado;
    medicalCircleController.text = appState.user.circulo;
    medicalChartController.text = appState.user.tabulador;
    statusController.text = appState.user.estatus;
  }

  Future<void> downMoloadMedicalAgreement() async {
    final String affiliationCode = appState.user.codigoFiliacion;
    try {
      isLoadingDownload.value = true;
      final Uint8List? response = await convenioMedicoRepository
          .donwMoloadMedicalAgreement(affiliationCode);
      isLoadingDownload.value = false;
      if (response != null) {
        await _downloadDevice(response);
      } else {
        _notification.show(
          title: 'Error',
          message: 'No se logró obtener el convenio',
          type: AlertType.error,
        );
      }
    } on Exception catch (e) {
      isLoadingDownload.value = false;
      _notification.show(
        title: 'Error',
        message: 'Ocurrió el detalle $e',
        type: AlertType.error,
      );
    }
  }

  Future<void> launcLowAgreement() async {
    final Uri url = Uri.parse(
      'https://docs.google.com/forms/d/1U1QykaK1UcKesLEia9wxHlr7GdzTT1l2p7xNcRon8so/edit',
    );
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> updateAgreement() async {
    final Uri url = Uri.parse(
      'https://docs.google.com/forms/d/1pOtikMLaUS-GsWBmvss4CQBd-u9IywvhymvbSOTUNKc/edit',
    );
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _downloadDevice(Uint8List dataDoc) async {
    final fileName = 'convenio_${appState.user.rfc}.pdf';
    await appService.fileStorage.downloadAndShareFile(
      data: dataDoc, 
      fileName: fileName
    );
  }
}
