import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/core/services/navigation/route_params.dart';
import 'package:medicos/shared/mddlewares/auth_middleware.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/section_title.dart';
import 'package:medicos/shared/widgets/wdgt_appbar_phone.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';
import 'package:medicos/src/modules/profile/children/assistants/assistants_controller.dart';
import 'package:medicos/src/modules/profile/children/assistants/domain/remote/add_assistants_repository.dart';
import 'package:medicos/src/modules/profile/children/assistants/domain/remote/assistants_repository.dart';
import 'package:medicos/src/modules/profile/children/assistants/widgets/card_assistant.dart';

part 'assistants_bindings.dart';
part 'assistants_route_params.dart';
part 'responsive/assistants_desktop_page.dart';
part 'responsive/assistants_phone_page.dart';
part 'responsive/assistants_tablet_page.dart';

class AssistantsPage extends GetResponsiveView<AssistantsController> {
  AssistantsPage({super.key});

  static final GetPage page = GetPage(
    name: '/asistentes',
    page: AssistantsPage.new,
    binding: _AssistantsBindings(),
    middlewares: [AuthGuard()]
  );

  @override
  Widget? phone() => _AssistantsPhonePage();

  @override
  Widget? tablet() => const _AssistantsTabletPage();

  @override
  Widget? desktop() => _AssistantsDesktopPage();
}
/// Widget público para reutilizar la vista desktop del perfil en otros módulos
class AssistantsDesktopView extends StatelessWidget {
  const AssistantsDesktopView({
    super.key,
  });

  @override
  Widget build(BuildContext context){
    Get
    ..lazyPut<AssistantsController>(
        AssistantsController.new,
    )
    ..put(AssistantsRepository())
    ..put(AddAssistantsRepository());
    return _AssistantsDesktopPage();
  }
}
