import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/widgets/custom_alert.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/formats/domain/remote/formats_repository.dart';
import 'package:medicos/src/modules/request_medical_agreement/request_medical_agreement_page.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';

part 'upload_documents_model.dart';

class UploadDocumentsController extends GetxController
    with StateMixin<_UploadDocumentsModel> {
  final AppStateController appState = Get.find<AppStateController>();
  final FormatsRepository apiConn = Get.find();
  UserModel get user => appState.user;

  final RxInt selectedIndex = 0.obs;
  final Rx<String?> selectedItem = Rx<String?>(null);
  final Rx<String?> downloading = Rx<String?>(null);

  final List<Map<String, String>> files = [
    {'title': msg.accessionLetter.tr(), 'file': 'Carta_de_adhesion.pdf'},
    {'title': msg.generalData.tr(), 'file': 'Formato_de_datos_generales.pdf'},
    {
      'title': msg.paymentByTransfer.tr(),
      'file': 'Formato_de_alta_para_pago_por_transferencia.pdf',
    },
  ];

  List<Map<String, String>> documentCardsWithoutOnTap = [
    {
      'title': 'Cédula CURP vigente',
      'description': 'Descripción del documento',
    },
    {
      'title': 'Cédula de la especialidad',
      'description': '(ambos lados)',
    },
    {
      'title': 'Cédula profesional',
      'description': '(ambos lados)',
    },
    {
      'title': 'Cédula RFC',
      'description': '(ambos lados)',
    },
    {
      'title': 'Certificación recertificación vigente o ...',
      'description': '(ambos lados)',
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

  List<BreadcrumbWeb> breadcrumbs = [
    BreadcrumbWeb(msg.home.tr(), route: WelcomePage.page.name),
    BreadcrumbWeb(
      msg.requestAgreement.tr(),
      route: RequestMedicalAgreementPage.page.name,
    ),
    BreadcrumbWeb(msg.requestDocumentation.tr()),
  ];

  void updateSelectedValue(String? newValue) {
    if (newValue != null) {
      selectedItem.value = newValue;
    }
  }

  Future<void> downloadFormat(String filename) async {
    try {
      if (downloading.value != null) {
        return;
      }
      downloading.value = filename;
      final Uint8List? response = await apiConn.downloadFormat(filename);
      downloading.value = null;
      if (response != null) {
        await appService.fileStorage.downloadAndShareFile(
          data: response,
          fileName: filename,
        );
      } else {
        appService.alert.show(
          title: msg.error.tr(),
          message: msg.errorGettingFormat.tr(),
          type: AlertType.error,
        );
      }
    } on Exception catch (e) {
      downloading.value = null;
      appService.alert.show(
        title: msg.error.tr(),
        message: msg.errorDetail.tr(args: [e.toString()]),
        type: AlertType.error,
      );
    }
  }

  Future<void> downloadFormats() async {
    for (final Map<String, String> file in files) {
      await downloadFormat(file['file'].value());
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
