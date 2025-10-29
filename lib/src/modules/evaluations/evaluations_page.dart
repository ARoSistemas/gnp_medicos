import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/navigation/route_params.dart';
import 'package:medicos/src/modules/evaluations/evaluations_controller.dart';

part 'evaluations_bindings.dart';

part 'evaluations_middleware.dart';

part 'evaluations_route_params.dart';

part 'responsive/evaluations_desktop_page.dart';

part 'responsive/evaluations_phone_page.dart';

part 'responsive/evaluations_tablet_page.dart';

class EvaluationsPage extends GetResponsiveView<EvaluationsController> {
  EvaluationsPage({super.key});

  static final GetPage page = GetPage(
    name: '/evaluaciones',
    page: EvaluationsPage.new,
    binding: _EvaluationsBindings(),
    middlewares: [_EvaluationsMiddleware()]
  );

  @override
  Widget? phone() => _EvaluationsPhonePage();

  @override
  Widget? tablet() => _EvaluationsTabletPage();

  @override
  Widget? desktop() => _EvaluationsDesktopPage();
}
