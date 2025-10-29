import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/core/services/navigation/route_params.dart';
import 'package:medicos/shared/widgets/appbar_phone.dart';
import 'package:medicos/shared/widgets/banner_medico.dart';
import 'package:medicos/shared/widgets/section_title.dart';
import 'package:medicos/src/modules/profile/children/datos_personales/datos_personales_controller.dart';

part 'datos_personales_bindings.dart';

part 'datos_personales_middleware.dart';

part 'datos_personales_route_params.dart';

part 'responsive/datos_personales_desktop_page.dart';

part 'responsive/datos_personales_phone_page.dart';

part 'responsive/datos_personales_tablet_page.dart';

class DatosPersonalesPage extends GetResponsiveView<DatosPersonalesController> {
  DatosPersonalesPage({super.key});

  static final GetPage page = GetPage(
    name: '/datos-personales',
    page: DatosPersonalesPage.new,
    binding: _DatosPersonalesBindings(),
    middlewares: [_DatosPersonalesMiddleware()],
  );

  @override
  Widget? phone() => _DatosPersonalesPhonePage();

  @override
  Widget? tablet() => _DatosPersonalesTabletPage();

  @override
  Widget? desktop() => _DatosPersonalesDesktopPage();
}
