import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/navigation/route_params.dart';
import 'package:medicos/src/modules/procedures/procedures_controller.dart';

part 'procedures_bindings.dart';

part 'procedures_middleware.dart';

part 'procedures_route_params.dart';

part 'responsive/procedures_desktop_page.dart';

part 'responsive/procedures_phone_page.dart';

part 'responsive/procedures_tablet_page.dart';

class ProceduresPage extends GetResponsiveView<ProceduresController> {
  ProceduresPage({super.key});

  static final GetPage page = GetPage(
    name: '/mis-tramites',
    page: ProceduresPage.new,
    binding: _ProceduresBindings(),
    middlewares: [_ProceduresMiddleware()]
  );

  @override
  Widget? phone() => _ProceduresPhonePage();

  @override
  Widget? tablet() => _ProceduresTabletPage();

  @override
  Widget? desktop() => _ProceduresDesktopPage();
}
