import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/appbar_phone.dart';
import 'package:medicos/shared/widgets/banner_medico.dart';
import 'package:medicos/src/modules/tabuladores/tabuladores_controller.dart';

part 'tabuladores_bindings.dart';

part 'tabuladores_middleware.dart';

part 'responsive/tabuladores_desktop_page.dart';

part 'responsive/tabuladores_phone_page.dart';

part 'responsive/tabuladores_tablet_page.dart';

class TabuladoresPage extends GetResponsiveView<TabuladoresController> {
  TabuladoresPage({super.key});

  static final GetPage page = GetPage(
    name: '/tabuladores',
    page: TabuladoresPage.new,
    binding: _TabuladoresBindings(),
    middlewares: [_TabuladoresMiddleware()],
  );

  @override
  Widget? phone() => _TabuladoresPhonePage();

  @override
  Widget? tablet() => _TabuladoresTabletPage();

  @override
  Widget? desktop() => _TabuladoresDesktopPage();
}
