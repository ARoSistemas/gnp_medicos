import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/widgets/appbar_phone.dart';
import 'package:medicos/shared/widgets/banner_medico.dart';
import 'package:medicos/src/modules/solicitud_documentacion/solicitud_documentacion_controller.dart';
import 'package:medicos/src/modules/solicitud_documentacion/widgets/solicitud_phone.dart/solicitud_upload_phone.dart';
import 'package:medicos/src/modules/solicitud_documentacion/widgets/upload_download_formats.dart';

part 'responsive/solicitud_documentacion_desktop_page.dart';
part 'responsive/solicitud_documentacion_phone_page.dart';
part 'responsive/solicitud_documentacion_tablet_page.dart';
part 'solicitud_documentacion_bindings.dart';

class SolicitudDocumentacionPage
    extends GetResponsiveView<SolicitudDocumentacionController> {
  SolicitudDocumentacionPage({super.key});

  static final GetPage page = GetPage(
    name: '/solicitud-documentacion',
    page: SolicitudDocumentacionPage.new,
    transition: Transition.rightToLeft,
    binding: _SolicitudDocumentacionBindings(),
  );

  @override
  Widget? phone() => _SolicitudDocumentacionPhonePage();

  @override
  Widget? tablet() => _SolicitudDocumentacionTabletPage();

  @override
  Widget? desktop() => _SolicitudDocumentacionDesktopPage();
}
