import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/add_user_page.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/domain/dtos/assistant_dto.dart';
import 'package:medicos/src/modules/welcome/widgets/modal_informative.dart';

class CardAsistente extends StatelessWidget {
  const CardAsistente({
    required this.assistant,
    required this.onPressed,
    required this.onRefresh,
    super.key,
  });

  final AssistantDto assistant;
  final void Function() onPressed;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    Future<void> showModal() async {
       await appService.alert.showAlert(
        child: ModalInformative(
          title: assistant.activo ? msg.disableUser.tr() 
          : msg.enableUser.tr(),
          message:  assistant.activo
          ? '''${msg.disableAssistant.tr()} ${assistant.nombre}'''
          : '''${msg.enableAssistant.tr()} ${assistant.nombre}''',
          onOk: onPressed,
          onCancel: Get.back,
        )
       );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 15, right: 5),
          onTap: assistant.activo
              ? () =>
                    Get.toNamed(
                      AddUserPage.page.name,
                      arguments: {'actualiza': true, 'assistant': assistant},
                    )!.then((_) {
                      /// Refresh list
                      onRefresh();
                    })
              : null,
          leading: Icon(
            size: 40,
            Icons.account_box_outlined,
            color: assistant.activo
                ? ColorPalette.textPrimary
                : ColorPalette.labelText,
          ),
          title: Text(
            assistant.nombre,
            style: context.textTheme.titleMedium?.copyWith(
              color: assistant.activo
                  ? ColorPalette.textPrimary
                  : ColorPalette.labelText,
            ),
          ),
          subtitle: Text(
            assistant.nombreTipoAsistente,
            style: context.textTheme.bodySmall?.copyWith(
              color: assistant.activo
                  ? ColorPalette.textPrimary
                  : ColorPalette.labelText,
            ),
          ),
          trailing: IconButton(
            onPressed: showModal,
            icon: Icon(
              Icons.power_settings_new,
              color: assistant.activo
                  ? ColorPalette.success
                  : ColorPalette.errorText,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AssistantDto>('assistant', assistant))
      ..add(
        ObjectFlagProperty<void Function()>.has('onPressed', onPressed),
      )
      ..add(
        ObjectFlagProperty<VoidCallback>.has('onRefresh', onRefresh),
      );
  }
}
