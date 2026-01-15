import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/mddlewares/auth_middleware.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/appbar_phone.dart';
import 'package:medicos/shared/widgets/appbar_web.dart';
import 'package:medicos/shared/widgets/banner_medico.dart';
import 'package:medicos/shared/widgets/wdgt_image_from_web.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/contact/contact_controller.dart';

part 'contact_bindings.dart';

part 'contact_middleware.dart';

part 'responsive/contact_desktop_page.dart';

part 'responsive/contact_phone_page.dart';

part 'responsive/contact_tablet_page.dart';

class ContactPage extends GetResponsiveView<ContactController> {
  ContactPage({super.key});

  static final GetPage page = GetPage(
    name: '/contacto',
    page: ContactPage.new,
    transition: Transition.rightToLeft,
    customTransition: MenuWebAdaptiveTransition(),
    binding: _ContactBindings(),
    middlewares: [_ContactMiddleware(), AuthGuard()],
  );

  @override
  Widget? phone() => _ContactPhonePage();
  @override
  Widget? tablet() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: const _ContactTabletPage(),
  );

  @override
  Widget? desktop() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: _ContactDesktopPage(),
  );
}
