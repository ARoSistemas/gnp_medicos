import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/navigation/route_params.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/payments/payments_controller.dart';

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
    middlewares: [_PaymentsMiddleware()],
  );

  @override
  Widget? phone() => _PaymentsPhonePage();

  @override
  Widget? tablet() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: _PaymentsTabletPage(),
  );

  @override
  Widget? desktop() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: _PaymentsDesktopPage(),
  );
}
