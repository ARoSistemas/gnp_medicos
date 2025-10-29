import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/add_user_page.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/domain/dtos/assistant_dto.dart';

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
      await showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Title
              Text(
                assistant.activo
                    ? esMessages.mx.disableUser.value
                    : esMessages.mx.enableUser.value,

                style: context.textTheme.titleMedium,
              ),

              /// SubTitle
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    assistant.activo
                        ? '''${esMessages.mx.disableAssistant.value} ${assistant.nombre}'''
                        : '''${esMessages.mx.enableAssistant.value} ${assistant.nombre}''',

                    textAlign: TextAlign.start,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: ColorPalette.textSecondary,
                    ),
                  ),
                ),
              ),

              /// Button Continuar
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: Text(esMessages.mx.accept.value),
                ),
              ),

              /// Button Cancelar
              TextButton(
                onPressed: Get.back,
                child: Text(esMessages.mx.cancel.value),
              ),

              ///
            ],
          ),
        ),
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
