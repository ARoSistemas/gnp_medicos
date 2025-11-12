import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/wdgt_appbar_phone.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';
import 'package:medicos/src/modules/directorio/children/filter_page/filterpage_page.dart';
import 'package:medicos/src/modules/directorio/directorio_controller.dart';
import 'package:medicos/src/modules/directorio/domain/entities/items_directory_mdl.dart';
import 'package:medicos/src/modules/directorio/domain/repository/directory_repository.dart';
import 'package:medicos/src/modules/directorio/widgets/wdgt_item_menu_directory.dart';

part 'directorio_bindings.dart';

part 'directorio_middleware.dart';

part 'responsive/directorio_desktop_page.dart';

part 'responsive/directorio_phone_page.dart';

part 'responsive/directorio_tablet_page.dart';

class DirectorioPage extends GetResponsiveView<DirectorioController> {
  DirectorioPage({super.key});

  static final GetPage page = GetPage(
    name: '/directorio-medico',
    page: DirectorioPage.new,
    binding: _DirectorioBindings(),
    middlewares: [_DirectorioMiddleware()],
  );

  @override
  Widget? phone() => _DirectorioPhonePage();

  @override
  Widget? tablet() => _DirectorioTabletPage();

  @override
  Widget? desktop() => _DirectorioDesktopPage();
}
