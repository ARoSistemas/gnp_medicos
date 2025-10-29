import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/item_assistants.dart';
import 'package:medicos/shared/widgets/section_title.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';
import 'package:medicos/src/modules/home/domain/entities/dtos/asisstant_dto.dart';
import 'package:medicos/src/modules/home/domain/repositories/home_repository.dart';

import 'package:medicos/src/modules/home/home_controller.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';

part 'home_bindings.dart';
part 'responsive/home_desktop_page.dart';
part 'responsive/home_phone_page.dart';
part 'responsive/home_tablet_page.dart';

class HomePage extends GetResponsiveView<HomeController> {
  HomePage({super.key});

  static final GetPage page = GetPage(
    name: '/home',
    page: HomePage.new,
    transition: Transition.rightToLeft,
    binding: _HomeBindings(),
  );

  @override
  Widget? phone() => _HomePhonePage();

  @override
  Widget? tablet() => _HomeTabletPage();

  @override
  Widget? desktop() => _HomeDesktopPage();
}
