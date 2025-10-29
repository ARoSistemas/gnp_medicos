import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/font_size_extension.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/drawer/responsive/drawer_phone.dart';
import 'package:medicos/shared/widgets/wdgt_image_from_web.dart';
import 'package:medicos/src/modules/welcome/welcome_controller.dart';
import 'package:medicos/src/modules/welcome/widgets/appbar_welcome_phone.dart';

part 'welcome_bindings.dart';

part 'responsive/welcome_desktop_page.dart';

part 'responsive/welcome_phone_page.dart';

part 'responsive/welcome_tablet_page.dart';

class WelcomePage extends GetResponsiveView<WelcomeController> {
  WelcomePage({super.key});

  static final GetPage page = GetPage(
    name: '/welcome',
    page: WelcomePage.new,
    transition: Transition.rightToLeft,
    binding: _WelcomeBindings(),
  );

  @override
  Widget? phone() => _WelcomePhonePage();

  @override
  Widget? tablet() => _WelcomeTabletPage();

  @override
  Widget? desktop() => _WelcomeDesktopPage();
}
