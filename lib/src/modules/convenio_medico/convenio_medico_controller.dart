import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/services/alerts/notification_service.dart';
import 'package:medicos/shared/widgets/custom_notification.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/convenio_medico/children/view_pdf/view_pdf_page.dart';
import 'package:medicos/src/modules/convenio_medico/domain/remote/convenio_medico_repository.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';
import 'package:medicos/src/modules/welcome/widgets/modal_informative.dart';
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

  List<BreadcrumbWeb> breadcrumbs = [
    BreadcrumbWeb('Inicio', route: WelcomePage.page.name),
    const BreadcrumbWeb('Convenio Médico'),
  ];

  @override
  void onInit() {
    super.onInit();
    const _ConvenioMedicoModel convenioMedicoModel = _ConvenioMedicoModel();
    loadDataConvenio();
    change(convenioMedicoModel, status: RxStatus.success());
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await _showBottomShetUpdated();
    await _showBottomSheetVigencia();
  }

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
          message: 'No se logró obtener el convenio.',
          type: AlertType.error,
        );
      }
    } on Exception catch (e) {
      isLoadingDownload.value = false;
      _notification.show(
        title: 'Error',
        message: 'Ocurrió el detalle $e.',
        type: AlertType.error,
      );
    }
  }

  Future<void> launcLowAgreement() async {
    final Uri url = Uri.parse(
      'https://docs.google.com/forms/d/1EdrJrM8--nRJX3lKorw9O_DKyiZwqhMRzlMBYeHapEQ/edit?pli=1',
    );
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> updateAgreement() async {
    final Uri url = Uri.parse(
      'https://docs.google.com/forms/d/1imC0j2XNygW0nv5rdxieNOlrc02Im4UkhhHheL5pfMg/edit?pli=1',
    );
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _downloadDevice(Uint8List dataDoc) async {
    final fileName = 'convenio_${appState.user.rfc}.pdf';
    await appService.fileStorage.downloadAndShareFile(
      data: dataDoc,
      fileName: fileName,
    );
  }

  Future<void> onView(String type) async {
    await Get.toNamed(ViewPdfPage.page.name, arguments: type);
  }

  Future<void> _showBottomSheetVigencia() async {
    if (!appState.user.banConvenioVigenteFecha) {
      if (!kIsWeb) {
        await showModalBottomSheet(
          context: Get.context!,
          builder: (context) => const ModalInformative(
            message: 'El convenio no se encuentra vigente.',
          ),
          isScrollControlled: true,
          isDismissible: false,
        );
      } else {
        await showDialog(
          barrierDismissible: false,
          context: Get.context!,
          builder: (context) => const Dialog(
            child: ModalInformative(
              message: 'El convenio no se encuentra vigente.',
            ),
          ),
        );
      }
    }
  }

  Future<void> _showBottomShetUpdated() async {
    if (appState.user.banConvenioActualizado) {
      if (!kIsWeb) {
        await showModalBottomSheet(
          context: Get.context!,
          builder: (context) => const ModalInformative(
            message: 'El convenio ha sido actualizado.',
          ),
          isScrollControlled: true,
          isDismissible: false,
        );
      } else {
        await showDialog(
          barrierDismissible: false,
          context: Get.context!,
          builder: (context) => const Dialog(
            child: ModalInformative(
              message: 'El convenio ha sido actualizado.',
            ),
          ),
        );
      }
    }
  }
}
