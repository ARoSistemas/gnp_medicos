import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/navigation/route_params.dart';
import '{{module_name.snakeCase()}}_controller.dart';

part '{{module_name.snakeCase()}}_bindings.dart';

part '{{module_name.snakeCase()}}_middleware.dart';

part '{{module_name.snakeCase()}}_route_params.dart';

part 'responsive/{{module_name.snakeCase()}}_desktop_page.dart';

part 'responsive/{{module_name.snakeCase()}}_phone_page.dart';

part 'responsive/{{module_name.snakeCase()}}_tablet_page.dart';

class {{module_name.pascalCase()}}Page extends GetResponsiveView<{{module_name.pascalCase()}}Controller> {
  {{module_name.pascalCase()}}Page({super.key});

  static final GetPage page = GetPage(
    name: '/{{module_name.paramCase()}}',
    page: {{module_name.pascalCase()}}Page.new,
    binding: _{{module_name.pascalCase()}}Bindings(),
    middlewares: [_{{module_name.pascalCase()}}Middleware()]
  );

  @override
  Widget? phone() => _{{module_name.pascalCase()}}PhonePage();

  @override
  Widget? tablet() => _{{module_name.pascalCase()}}TabletPage();

  @override
  Widget? desktop() => _{{module_name.pascalCase()}}DesktopPage();
}
