import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/models/incoming/solicitudes_model.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/appbar_phone.dart';
import 'package:medicos/shared/widgets/banner_medico.dart';
import 'package:medicos/shared/widgets/section_title.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/formats/domain/remote/formats_repository.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/upload_documents/upload_documents_page.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/solicitud_convenio_medico_controller.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/widgets/card_solicitud.dart';

part 'solicitud_convenio_medico_bindings.dart';
part 'responsive/solicitud_convenio_medico_desktop_page.dart';
part 'responsive/solicitud_convenio_medico_phone_page.dart';
part 'responsive/solicitud_convenio_medico_tablet_page.dart';

class SolicitudConvenioMedicoPage
    extends GetResponsiveView<SolicitudConvenioMedicoController> {
  SolicitudConvenioMedicoPage({super.key});

  static final GetPage page = GetPage(
    name: '/solicitar-convenio',
    page: SolicitudConvenioMedicoPage.new,
    transition: Transition.rightToLeft,
    customTransition: MenuWebAdaptiveTransition(),
    binding: _SolicitudConvenioMedicoBindings(),
  );

  @override
  Widget? phone() => _SolicitudConvenioMedicoPhonePage();

  @override
  Widget? tablet() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: _SolicitudConvenioMedicoTabletPage(),
  );

  @override
  Widget? desktop() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: _SolicitudConvenioMedicoDesktopPage(),
  );
}
