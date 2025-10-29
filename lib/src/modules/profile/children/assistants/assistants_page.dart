import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/navigation/route_params.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/appbar_phone.dart';
import 'package:medicos/shared/widgets/banner_medico.dart';
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
  );

  @override
  Widget? phone() => _AssistantsPhonePage();

  @override
  Widget? tablet() => _AssistantsTabletPage();

  @override
  Widget? desktop() => _AssistantsDesktopPage();
}
