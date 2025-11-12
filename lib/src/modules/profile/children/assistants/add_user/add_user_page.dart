import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/navigation/route_params.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/wdgt_appbar_phone.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';

import 'package:medicos/src/modules/profile/children/assistants/add_user/add_user_controller.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/domain/repository/add_user_repository.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/widgets/item_tabbar.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/widgets/user_general_data.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/widgets/user_permissions.dart';
import 'package:medicos/src/modules/profile/children/assistants/domain/remote/add_assistants_repository.dart';

part 'add_user_bindings.dart';
part 'add_user_middleware.dart';
part 'add_user_route_params.dart';
part 'responsive/add_user_desktop_page.dart';
part 'responsive/add_user_phone_page.dart';
part 'responsive/add_user_tablet_page.dart';

class AddUserPage extends GetResponsiveView<AddUserController> {
  AddUserPage({super.key});

  static final GetPage page = GetPage(
    name: '/agregar-usuario',
    page: AddUserPage.new,
    binding: _AddUserBindings(),
    middlewares: [_AddUserMiddleware()],
  );

  @override
  Widget? phone() => _AddUserPhonePage();

  @override
  Widget? tablet() => _AddUserTabletPage();

  @override
  Widget? desktop() => _AddUserDesktopPage();
}
