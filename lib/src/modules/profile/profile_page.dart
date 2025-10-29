import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/appbar_phone.dart';
import 'package:medicos/src/modules/login/login_page.dart';
import 'package:medicos/src/modules/profile/children/assistants/assistants_page.dart';
import 'package:medicos/src/modules/profile/children/datos_academicos/datos_academicos_page.dart';
import 'package:medicos/src/modules/profile/children/datos_fiscales/datos_fiscales_page.dart';
import 'package:medicos/src/modules/profile/children/datos_personales/datos_personales_page.dart';
import 'package:medicos/src/modules/profile/profile_controller.dart';
import 'package:medicos/src/modules/profile/widgets/banner_user.dart';
import 'package:medicos/src/modules/profile/widgets/button_perfil.dart';
import 'package:medicos/src/modules/profile/widgets/card_section_profile.dart';

part 'profile_bindings.dart';
part 'profile_middleware.dart';
part 'responsive/profile_desktop_page.dart';
part 'responsive/profile_phone_page.dart';
part 'responsive/profile_tablet_page.dart';

class ProfilePage extends GetResponsiveView<ProfileController> {
  ProfilePage({super.key});

  static final GetPage page = GetPage(
    name: '/mi-perfil',
    page: ProfilePage.new,
    binding: _ProfileBindings(),
    middlewares: [_ProfileMiddleware()],
  );

  @override
  Widget? phone() => _ProfilePhonePage();

  @override
  Widget? tablet() => _ProfileTabletPage();

  @override
  Widget? desktop() => _ProfileDesktopPage();
}
