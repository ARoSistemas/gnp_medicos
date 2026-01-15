import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/mddlewares/auth_middleware.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/utils/tools.dart';
import 'package:medicos/shared/utils/validators.dart';
import 'package:medicos/shared/widgets/appbar_web.dart';
import 'package:medicos/shared/widgets/wdgt_appbar_phone.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/tabulators/repository/tabulators_repository.dart';
import 'package:medicos/src/modules/tabulators/tabulators_controller.dart';

part 'tabulators_bindings.dart';

part 'tabulators_middleware.dart';

part 'responsive/tabuladores_desktop_page.dart';

part 'responsive/tabuladores_phone_page.dart';

part 'responsive/tabuladores_tablet_page.dart';

class TabuladoresPage extends GetResponsiveView<TabulatorsController> {
  TabuladoresPage({super.key});

  static final GetPage page = GetPage(
    name: '/tabuladores',
    page: TabuladoresPage.new,
    transition: Transition.rightToLeft,
    customTransition: MenuWebAdaptiveTransition(),
    binding: _TabuladoresBindings(),
    middlewares: [_TabuladoresMiddleware(), AuthGuard()],
  );

  @override
  Widget? phone() => _TabuladoresPhonePage();

  @override
  Widget? tablet() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: const _TabuladoresTabletPage(),
  );

  @override
  Widget? desktop() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: _TabuladoresDesktopPage(),
  );
}
