import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/font_size_extension.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/mddlewares/auth_middleware.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/drawer/responsive/drawer_phone.dart';
import 'package:medicos/shared/widgets/wdgt_image_from_web.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/welcome/welcome_controller.dart';
import 'package:medicos/src/modules/welcome/widgets/appbar_welcome_phone.dart';

part 'welcome_bindings.dart';

part 'responsive/welcome_desktop_page.dart';

part 'responsive/welcome_phone_page.dart';

part 'responsive/welcome_tablet_page.dart';

class WelcomePage extends GetResponsiveView<WelcomeController> {
  WelcomePage({super.key});

  static final GetPage page = GetPage(
    name: '/inicio',
    page: WelcomePage.new,
    transition: Transition.rightToLeft,
    customTransition: MenuWebAdaptiveTransition(),
    binding: _WelcomeBindings(),
    middlewares: [AuthGuard()]
  );

  @override
  Widget? phone() => _WelcomePhonePage();

  @override
  Widget? tablet() => MenuWeb(
    breadcrumbs: controller.breadcrumbsInicio,
    child: const _WelcomeTabletPage(),
  );

  @override
  Widget? desktop() => MenuWeb(
    breadcrumbs: controller.breadcrumbsInicio,
    child: _WelcomeDesktopPage(),
  );
}
