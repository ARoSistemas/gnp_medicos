import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/utils/validators.dart';
import 'package:medicos/shared/widgets/logo_gnp.dart';
import 'package:medicos/src/modules/login/domain/repositories/auth_repository.dart';
import 'package:medicos/src/modules/login/login_controller.dart';

part 'login_bindings.dart';

part 'responsive/login_desktop_page.dart';

part 'responsive/login_phone_page.dart';

part 'responsive/login_tablet_page.dart';

class LoginPage extends GetResponsiveView<LoginController> {
  LoginPage({super.key});

  static final GetPage page = GetPage(
    name: '/login',
    page: LoginPage.new,
    transition: Transition.rightToLeft,
    binding: _LoginBindings(),
  );

  @override
  Widget? phone() => _LoginPhonePage();

  @override
  Widget? tablet() => const _LoginTabletPage();

  @override
  Widget? desktop() => _LoginDesktopPage();
}
