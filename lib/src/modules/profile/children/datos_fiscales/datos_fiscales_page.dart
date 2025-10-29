import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/core/services/navigation/route_params.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/appbar_phone.dart';
import 'package:medicos/shared/widgets/banner_medico.dart';
import 'package:medicos/shared/widgets/section_title.dart';
import 'package:medicos/src/modules/profile/children/datos_fiscales/datos_fiscales_controller.dart';

part 'datos_fiscales_bindings.dart';
part 'datos_fiscales_middleware.dart';
part 'datos_fiscales_route_params.dart';
part 'responsive/datos_fiscales_desktop_page.dart';
part 'responsive/datos_fiscales_phone_page.dart';
part 'responsive/datos_fiscales_tablet_page.dart';

class DatosFiscalesPage extends GetResponsiveView<DatosFiscalesController> {
  DatosFiscalesPage({super.key});

  static final GetPage page = GetPage(
    name: '/datos-fiscales',
    page: DatosFiscalesPage.new,
    binding: _DatosFiscalesBindings(),
    middlewares: [_DatosFiscalesMiddleware()],
  );

  @override
  Widget? phone() => _DatosFiscalesPhonePage();

  @override
  Widget? tablet() => _DatosFiscalesTabletPage();

  @override
  Widget? desktop() => _DatosFiscalesDesktopPage();
}
