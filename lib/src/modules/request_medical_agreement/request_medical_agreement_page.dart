import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/shared/mddlewares/auth_middleware.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/incoming/solicitudes_model.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/appbar_phone.dart';
import 'package:medicos/shared/widgets/appbar_web.dart';
import 'package:medicos/shared/widgets/banner_medico.dart';
import 'package:medicos/shared/widgets/custom_alert.dart';
import 'package:medicos/shared/widgets/section_title.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/shared/widgets/wdgt_table_web.dart';
import 'package:medicos/src/modules/formats/domain/remote/formats_repository.dart';
import 'package:medicos/src/modules/request_medical_agreement/children/upload_documents/upload_documents_page.dart';
import 'package:medicos/src/modules/request_medical_agreement/request_medical_agreement_controller.dart';
import 'package:medicos/src/modules/request_medical_agreement/widgets/card_solicitud.dart';

part 'request_medical_agreement_bindings.dart';
part 'responsive/request_medical_agreement_desktop_page.dart';
part 'responsive/request_medical_agreement_phone_page.dart';
part 'responsive/request_medical_agreement_tablet_page.dart';

class RequestMedicalAgreementPage
    extends GetResponsiveView<RequestMedicalAgreementController> {
  RequestMedicalAgreementPage({super.key});

  static final GetPage page = GetPage(
    name: '/solicitar-convenio',
    page: RequestMedicalAgreementPage.new,
    transition: Transition.rightToLeft,
    customTransition: MenuWebAdaptiveTransition(),
    binding: _RequestMedicalAgreementBindings(),
    middlewares: [AuthGuard()]
  );

  @override
  Widget? phone() => _RequestMedicalAgreementPhonePage();

  @override
  Widget? tablet() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: const _RequestMedicalAgreementTabletPage(),
  );

  @override
  Widget? desktop() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: _RequestMedicalAgreementDesktopPage(),
  );
}
