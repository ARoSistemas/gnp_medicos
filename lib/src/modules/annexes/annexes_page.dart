import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/mddlewares/auth_middleware.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/appbar_web.dart';
import 'package:medicos/shared/widgets/card_file_download.dart';
import 'package:medicos/shared/widgets/wdgt_appbar_phone.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/annexes/annexes_controller.dart';
import 'package:medicos/src/modules/annexes/domain/repository/annexes_repository.dart';

part 'annexes_bindings.dart';

part 'annexes_middleware.dart';

part 'responsive/annexes_desktop_page.dart';

part 'responsive/annexes_phone_page.dart';

part 'responsive/annexes_tablet_page.dart';

class AnnexesPage extends GetResponsiveView<AnnexesController> {
  AnnexesPage({super.key});

  static final GetPage page = GetPage(
    name: '/anexos',
    page: AnnexesPage.new,
    transition: Transition.rightToLeft,
    customTransition: MenuWebAdaptiveTransition(),
    binding: _AnnexesBindings(),
    middlewares: [_AnnexesMiddleware(), AuthGuard()],
  );

  @override
  Widget? phone() => _AnnexesPhonePage();

  @override
  Widget? tablet() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: const _AnnexesTabletPage(),
  );

  @override
  Widget? desktop() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: _AnnexesDesktopPage(),
  );
}
