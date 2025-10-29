import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/navigation/route_params.dart';
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
    binding: _PaymentsBindings(),
    middlewares: [_PaymentsMiddleware()]
  );

  @override
  Widget? phone() => _PaymentsPhonePage();

  @override
  Widget? tablet() => _PaymentsTabletPage();

  @override
  Widget? desktop() => _PaymentsDesktopPage();
}
