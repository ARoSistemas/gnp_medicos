import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/appbar_phone.dart';
import 'package:medicos/shared/widgets/banner_medico.dart';
import 'package:medicos/shared/widgets/wdgt_image_from_web.dart';
import 'package:medicos/src/modules/contacto/contacto_controller.dart';

part 'contacto_bindings.dart';

part 'contacto_middleware.dart';

part 'responsive/contacto_desktop_page.dart';

part 'responsive/contacto_phone_page.dart';

part 'responsive/contacto_tablet_page.dart';

class ContactoPage extends GetResponsiveView<ContactoController> {
  ContactoPage({super.key});

  static final GetPage page = GetPage(
    name: '/contacto',
    page: ContactoPage.new,
    binding: _ContactoBindings(),
    middlewares: [_ContactoMiddleware()],
  );

  @override
  Widget? phone() => _ContactoPhonePage();

  @override
  Widget? tablet() => _ContactoTabletPage();

  @override
  Widget? desktop() => _ContactoDesktopPage();
}
