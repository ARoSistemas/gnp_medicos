import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/mddlewares/auth_middleware.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/appbar_web.dart';
import 'package:medicos/shared/widgets/card_benefit.dart';
import 'package:medicos/shared/widgets/wdgt_appbar_phone.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/benefits/benefits_controller.dart';
import 'package:medicos/src/modules/benefits/domain/remote/benefits_repository.dart';

part 'benefits_bindings.dart';

part 'benefits_middleware.dart';

part 'responsive/benefits_desktop_page.dart';

part 'responsive/benefits_phone_page.dart';

part 'responsive/benefits_tablet_page.dart';

class BeneficiosPage extends GetResponsiveView<BeneficiosController> {
  BeneficiosPage({super.key});

  static final GetPage page = GetPage(
    name: '/beneficios',
    page: BeneficiosPage.new,
    transition: Transition.rightToLeft,
    customTransition: MenuWebAdaptiveTransition(),
    binding: _BeneficiosBindings(),
    middlewares: [_BeneficiosMiddleware(), AuthGuard()],
  );

  @override
  Widget? phone() => _BeneficiosPhonePage();

  @override
  Widget? tablet() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: const _BeneficiosTabletPage(),
  );

  @override
  Widget? desktop() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: _BeneficiosDesktopPage(),
  );
}
