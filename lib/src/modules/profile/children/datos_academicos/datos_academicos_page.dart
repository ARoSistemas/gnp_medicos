import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/core/services/navigation/route_params.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/widgets/appbar_phone.dart';
import 'package:medicos/shared/widgets/banner_medico.dart';
import 'package:medicos/shared/widgets/section_title.dart';
import 'package:medicos/src/modules/profile/children/datos_academicos/datos_academicos_controller.dart';

part 'datos_academicos_bindings.dart';

part 'datos_academicos_middleware.dart';

part 'datos_academicos_route_params.dart';

part 'responsive/datos_academicos_desktop_page.dart';

part 'responsive/datos_academicos_phone_page.dart';

part 'responsive/datos_academicos_tablet_page.dart';

class DatosAcademicosPage extends GetResponsiveView<DatosAcademicosController> {
  DatosAcademicosPage({super.key});

  static final GetPage page = GetPage(
    name: '/datos-academicos',
    page: DatosAcademicosPage.new,
    binding: _DatosAcademicosBindings(),
    middlewares: [_DatosAcademicosMiddleware()],
  );

  @override
  Widget? phone() => _DatosAcademicosPhonePage();

  @override
  Widget? tablet() => _DatosAcademicosTabletPage();

  @override
  Widget? desktop() => _DatosAcademicosDesktopPage();
}
