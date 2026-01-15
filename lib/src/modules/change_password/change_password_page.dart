import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/navigation/route_params.dart';
import 'package:medicos/src/modules/change_password/change_password_controller.dart';

part 'change_password_bindings.dart';

part 'change_password_middleware.dart';

part 'change_password_route_params.dart';

part 'responsive/change_password_desktop_page.dart';

part 'responsive/change_password_phone_page.dart';

part 'responsive/change_password_tablet_page.dart';

class ChangePasswordPage extends GetResponsiveView<ChangePasswordController>
    with GetResponsiveMixin {
  ChangePasswordPage({super.key});

  static final GetPage page = GetPage(
    name: '/change-password',
    page: ChangePasswordPage.new,
    binding: _ChangePasswordBindings(),
    middlewares: [_ChangePasswordMiddleware()],
  );

  static final GetPage activarPage = GetPage(
    name: '/activar',
    page: ChangePasswordPage.new,
    binding: _ChangePasswordBindings(),
    middlewares: [_ActivarMiddleware()],
  );

  @override
  Widget? phone() => _ChangePasswordPhonePage();

  @override
  Widget? tablet() => _ChangePasswordTabletPage();

  @override
  Widget? desktop() => _ChangePasswordDesktopPage();
}
