import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/mddlewares/auth_middleware.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/appbar_web.dart';
import 'package:medicos/shared/widgets/wdgt_appbar_phone.dart';
import 'package:medicos/shared/widgets/wdgt_image_from_web.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/directory/directory_controller.dart';
import 'package:medicos/src/modules/directory/domain/repository/directory_repository.dart';
import 'package:medicos/src/modules/directory/widgets/wdgt_item_menu_directory.dart';

part 'directory_bindings.dart';

part 'directory_middleware.dart';

part 'responsive/directory_desktop_page.dart';

part 'responsive/directory_phone_page.dart';

part 'responsive/directory_tablet_page.dart';

class DirectoryPage extends GetResponsiveView<DirectoryController> {
  DirectoryPage({super.key});

  static final GetPage page = GetPage(
    name: '/directorio-medico',
    page: DirectoryPage.new,
    transition: Transition.rightToLeft,
    customTransition: MenuWebAdaptiveTransition(),
    binding: _DirectoryBindings(),
    middlewares: [_DirectoryMiddleware(), AuthGuard()],
  );

  @override
  Widget? phone() => _DirectoryPhonePage();

  @override
  Widget? tablet() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: _DirectoryTabletPage(),
  );

  @override
  Widget? desktop() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: _DirectoryDesktopPage(),
  );
}
