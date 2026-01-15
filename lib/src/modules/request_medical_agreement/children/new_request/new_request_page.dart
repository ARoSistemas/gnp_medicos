import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/core/services/navigation/route_params.dart';
import 'package:medicos/shared/constans/constans.dart';
import 'package:medicos/shared/mddlewares/auth_middleware.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/utils/validators.dart';
import 'package:medicos/shared/widgets/appbar_phone.dart';
import 'package:medicos/shared/widgets/appbar_web.dart';
import 'package:medicos/shared/widgets/banner_medico.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/profile/widgets/title_sections.dart';
import 'package:medicos/src/modules/request_medical_agreement/children/new_request/new_request_controller.dart';

part 'new_request_bindings.dart';

part 'new_request_middleware.dart';

part 'new_request_route_params.dart';

part 'responsive/new_request_desktop_page.dart';

part 'responsive/new_request_phone_page.dart';

part 'responsive/new_request_tablet_page.dart';

class NewRequestPage extends GetResponsiveView<NewRequestController> {
  NewRequestPage({super.key});

  static final GetPage page = GetPage(
    name: '/nueva-solicitud',
    page: NewRequestPage.new,
    transition: Transition.rightToLeft,
    customTransition: MenuWebAdaptiveTransition(),
    binding: _NewRequestBindings(),
    middlewares: [_NewRequestMiddleware(), AuthGuard()],
  );

  @override
  Widget? phone() => _NewRequestPhonePage();

  @override
  Widget? tablet() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: const _NewRequestTabletPage()
  );

  @override
  Widget? desktop() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: _NewRequestDesktopPage()
  );
}
