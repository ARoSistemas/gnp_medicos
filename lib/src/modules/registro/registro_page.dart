import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/core/services/navigation/route_params.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/src/modules/registro/domain/remote/registro_repository.dart';
import 'package:medicos/src/modules/registro/registro_controller.dart';
import 'package:medicos/src/modules/registro/widgets/form_contacto_phone.dart';

part 'registro_bindings.dart';
part 'registro_middleware.dart';
part 'registro_route_params.dart';
part 'responsive/registro_desktop_page.dart';
part 'responsive/registro_phone_page.dart';
part 'responsive/registro_tablet_page.dart';

class RegistroPage extends GetResponsiveView<RegistroController> {
  RegistroPage({super.key});

  static final GetPage page = GetPage(
    name: '/registro',
    page: RegistroPage.new,
    binding: _RegistroBindings(),
    middlewares: [_RegistroMiddleware()],
  );

  @override
  Widget? phone() => _RegistroPhonePage();

  @override
  Widget? tablet() => _RegistroTabletPage();

  @override
  Widget? desktop() => _RegistroDesktopPage();
}
