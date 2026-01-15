import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/shared/constans/constans.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/widgets/custom_alert.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/convenio_medico/domain/repository/convenio_medico_repository.dart';
import 'package:medicos/src/modules/view_pdf/view_pdf_page.dart';
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
  UserModel get user => appState.user;
  Uint8List? file;
  String? urlDown;
  String? urlUpdateInfo;

  final List<BreadcrumbWeb> breadcrumbs = [
    BreadcrumbWeb(msg.home.tr(), route: WelcomePage.page.name),
    BreadcrumbWeb(msg.agreement.tr()),
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    change(const _ConvenioMedicoModel(), status: RxStatus.loading());
    loadDataConvenio();
    await getDataFb();
    change(const _ConvenioMedicoModel(), status: RxStatus.success());
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

  Future<void> getDataFb() async {
    final Map? dataFbForms = await appService.shared.realtimeService
        .getDataOnce('appConfig/modulos/convenio/formularios');

    if (dataFbForms == null) {
      return;
    }
    urlDown = dataFbForms['baja'];
    urlUpdateInfo = dataFbForms['actualizacion'];
  }

  Future<void> launcLowAgreement() async {
    final Uri url = Uri.parse(urlDown.value());
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> updateAgreement() async {
    final Uri url = Uri.parse(urlUpdateInfo.value());
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<Uint8List?> downloadDocument(String type) async {
    final String affiliationCode = appState.user.codigoFiliacion;
    try {
      isLoadingDownload.value = true;
      final Uint8List? response;
      if (type == FileTypesAgree.guidelines) {
        response = await convenioMedicoRepository.downloadGuidelines();
      } else {
        response = await convenioMedicoRepository.donwMoloadMedicalAgreement(
          affiliationCode,
        );
      }
      isLoadingDownload.value = false;
      if (response != null) {
        return response;
      } else {
        appService.alert.show(
          title: msg.error.tr(),
          message: msg.errorGettingDocument.tr(),
          type: AlertType.error,
        );
        return null;
      }
    } on Exception catch (e) {
      isLoadingDownload.value = false;
     appService.alert.show(
        title: msg.error.tr(),
        message: msg.errorDetail.tr(args: [e.toString()]),
        type: AlertType.error,
      );
      return null;
    }
  }

  Future<void> onView(
    String type,
  ) async {
    final Uint8List? file = await downloadDocument(type);
    if (file != null) {
      await Get.toNamed(
        ViewPdfPage.page.name,
        arguments: {
          'file': file,
          'title': '$type.pdf',
          'download': type == FileTypesAgree.guidelines,
        },
      );
    }
  }

  Future<void> _showBottomSheetVigencia() async {
    if (!appState.user.banConvenioVigenteFecha) {
      await appService.alert.showAlert(
        child: ModalInformative(
          message: msg.agreementNotInEffect.tr(),
        )
      );
    }
  }

  Future<void> _showBottomShetUpdated() async {
    if (appState.user.banConvenioActualizado) {
      await appService.alert.showAlert(
        child: ModalInformative(
          message: msg.agreementUpdated.tr(),
        )
      );
    }
  }
}
