import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/navigation/route_params.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/utils/validators.dart';
import 'package:medicos/shared/widgets/appbar_phone.dart';
import 'package:medicos/shared/widgets/banner_medico.dart';
import 'package:medicos/src/modules/profile/widgets/title_sections.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/nueva_solicitud/nueva_solicitud_controller.dart';

part 'nueva_solicitud_bindings.dart';

part 'nueva_solicitud_middleware.dart';

part 'nueva_solicitud_route_params.dart';

part 'responsive/nueva_solicitud_desktop_page.dart';

part 'responsive/nueva_solicitud_phone_page.dart';

part 'responsive/nueva_solicitud_tablet_page.dart';

class NuevaSolicitudPage extends GetResponsiveView<NuevaSolicitudController> {
  NuevaSolicitudPage({super.key});

  static final GetPage page = GetPage(
    name: '/nueva-solicitud',
    page: NuevaSolicitudPage.new,
    binding: _NuevaSolicitudBindings(),
    middlewares: [_NuevaSolicitudMiddleware()]
  );

  @override
  Widget? phone() => _NuevaSolicitudPhonePage();

  @override
  Widget? tablet() => _NuevaSolicitudTabletPage();

  @override
  Widget? desktop() => _NuevaSolicitudDesktopPage();
}
