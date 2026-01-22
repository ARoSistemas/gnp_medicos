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
import 'package:medicos/shared/utils/tools.dart';
import 'package:medicos/shared/widgets/appbar_web.dart';
import 'package:medicos/shared/widgets/wdgt_appbar_phone.dart';
import 'package:medicos/shared/widgets/wdgt_custom_search_bar.dart';
import 'package:medicos/shared/widgets/wdgt_image_from_web.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/shared/widgets/wdgt_table_web.dart';
import 'package:medicos/src/modules/payments/domain/entities/payment.dart';
import 'package:medicos/src/modules/payments/domain/repository/payments_repository.dart';
import 'package:medicos/src/modules/payments/payments_controller.dart';
import 'package:medicos/src/modules/procedures/responsive/widgets/wdgt_filter_chip.dart';
import 'package:medicos/src/modules/procedures/responsive/widgets/wdgt_filter_selector_web.dart';
import 'package:medicos/src/modules/procedures/responsive/widgets/widget_pago.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';

part 'payments_bindings.dart';
part 'payments_middleware.dart';
part 'payments_route_params.dart';
part 'responsive/payments_desktop_page.dart';
part 'responsive/payments_phone_page.dart';
part 'responsive/payments_tablet_page.dart';

class PaymentsPage extends GetResponsiveView<PaymentsController> {
  PaymentsPage({super.key});

  static final GetPage page = GetPage(
    name: '/mis-pagos',
    page: PaymentsPage.new,
    transition: Transition.rightToLeft,
    customTransition: MenuWebAdaptiveTransition(),
    binding: _PaymentsBindings(),
    middlewares: [_PaymentsMiddleware(), AuthGuard()],
  );

  @override
  Widget? phone() => _PaymentsPhonePage();

  @override
  Widget? tablet() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: const _PaymentsTabletPage(),
  );

  @override
  Widget? desktop() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: _PaymentsDesktopPage(),
  );
}
