import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/core/services/navigation/route_params.dart';
import 'package:medicos/shared/mddlewares/auth_middleware.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/utils/enums.dart';
import 'package:medicos/shared/widgets/appbar_web.dart';
import 'package:medicos/shared/widgets/wdgt_appbar_phone.dart';
import 'package:medicos/shared/widgets/wdgt_custom_search_bar.dart';
import 'package:medicos/shared/widgets/wdgt_image_from_web.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/shared/widgets/wdgt_table_web.dart';
import 'package:medicos/src/modules/procedures/domain/entities/folio_mdl.dart';
import 'package:medicos/src/modules/procedures/domain/repository/procedures_repository.dart';
import 'package:medicos/src/modules/procedures/procedures_controller.dart';
import 'package:medicos/src/modules/procedures/responsive/widgets/wdgt_filter_chip.dart';
import 'package:medicos/src/modules/procedures/responsive/widgets/wdgt_filter_selector_web.dart';
import 'package:medicos/src/modules/procedures/responsive/widgets/wdgt_folio.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';

part 'procedures_bindings.dart';

part 'procedures_middleware.dart';

part 'procedures_route_params.dart';

part 'responsive/procedures_desktop_page.dart';

part 'responsive/procedures_phone_page.dart';

// part 'responsive/procedures_tablet_page.dart';

class ProceduresPage extends GetResponsiveView<ProceduresController> {
  ProceduresPage({super.key});

  static final GetPage page = GetPage(
    name: '/mis-tramites',
    page: ProceduresPage.new,
    transition: Transition.rightToLeft,
    customTransition: MenuWebAdaptiveTransition(),
    binding: _ProceduresBindings(),
    middlewares: [_ProceduresMiddleware(), AuthGuard()],
  );

  @override
  Widget? phone() => _ProceduresPhonePage();

  @override
  Widget? tablet() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: _ProceduresDesktopPage(),
  );

  @override
  Widget? desktop() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: _ProceduresDesktopPage(),
  );
}
