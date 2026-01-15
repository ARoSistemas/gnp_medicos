import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/shared/mddlewares/auth_middleware.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/appbar_phone.dart';
import 'package:medicos/shared/widgets/appbar_web.dart';
import 'package:medicos/shared/widgets/upload_photo_modal.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/login/domain/repositories/auth_repository.dart';
import 'package:medicos/src/modules/profile/children/academic_data/academic_data_controller.dart';
import 'package:medicos/src/modules/profile/children/academic_data/academic_data_page.dart';
import 'package:medicos/src/modules/profile/children/assistants/assistants_page.dart';
import 'package:medicos/src/modules/profile/children/fiscal_data/fiscal_data_controller.dart';
import 'package:medicos/src/modules/profile/children/fiscal_data/fiscal_data_page.dart';
import 'package:medicos/src/modules/profile/children/personal_data/personal_data_controller.dart';
import 'package:medicos/src/modules/profile/children/personal_data/personal_data_page.dart';
import 'package:medicos/src/modules/profile/domain/repository/profile_repository.dart';
import 'package:medicos/src/modules/profile/profile_controller.dart';
import 'package:medicos/src/modules/profile/widgets/banner_user.dart';
import 'package:medicos/src/modules/profile/widgets/button_perfil.dart';
import 'package:medicos/src/modules/profile/widgets/card_section_profile.dart';

part 'profile_bindings.dart';
part 'profile_middleware.dart';
part 'responsive/profile_desktop_page.dart';
part 'responsive/profile_phone_page.dart';
part 'responsive/profile_tablet_page.dart';

class ProfilePage extends GetResponsiveView<ProfileController> {
  ProfilePage({super.key});

  static final GetPage page = GetPage(
    name: '/mi-perfil',
    page: ProfilePage.new,
    transition: Transition.rightToLeft,
    customTransition: MenuWebAdaptiveTransition(),
    binding: _ProfileBindings(),
    middlewares: [_ProfileMiddleware(), AuthGuard()],
  );

  @override
  Widget? phone() => _ProfilePhonePage();

  @override
  Widget? tablet() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: const _ProfileTabletPage()
  );

  @override
  Widget? desktop() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: _ProfileDesktopPage(0)
  );
}
