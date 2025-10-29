import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/appbar_phone.dart';
import 'package:medicos/shared/widgets/banner_medico.dart';
import 'package:medicos/src/modules/beneficios/beneficios_controller.dart';

part 'beneficios_bindings.dart';

part 'beneficios_middleware.dart';

part 'responsive/beneficios_desktop_page.dart';

part 'responsive/beneficios_phone_page.dart';

part 'responsive/beneficios_tablet_page.dart';

class BeneficiosPage extends GetResponsiveView<BeneficiosController> {
  BeneficiosPage({super.key});

  static final GetPage page = GetPage(
    name: '/beneficios',
    page: BeneficiosPage.new,
    binding: _BeneficiosBindings(),
    middlewares: [_BeneficiosMiddleware()],
  );

  @override
  Widget? phone() => _BeneficiosPhonePage();

  @override
  Widget? tablet() => _BeneficiosTabletPage();

  @override
  Widget? desktop() => _BeneficiosDesktopPage();
}
