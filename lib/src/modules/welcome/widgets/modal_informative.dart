import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

class ModalInformative extends StatelessWidget {
  const ModalInformative({
    required this.message, this.title,
    super.key,
    this.okMessage,
    this.onOk,
    this.onCancel
  });
  final String? title;
  final String message;
  final String? okMessage;
  final Function()? onOk;
  final Function()? onCancel;

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: const BoxConstraints(
      maxWidth: 500,
    ),
    child: Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: ColorPalette.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: context.pHeight(35)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      title.value(),
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                Flexible(
                  child: SingleChildScrollView(
                    child: Text(
                      message,
                      style: context.textTheme.titleMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if(!kIsWeb)
                  btnsMovil(),
                if(kIsWeb)
                  btnsWeb()
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Widget btnsMovil() => Column(
    children: [
      ElevatedButton(
        onPressed: () {
          onOk?.call();
          Get.back();
        },
        child: Text(okMessage ?? msg.accept.tr()),
      ),
      const SizedBox(
        height: 10,
      ),
      Visibility(
        visible: onCancel != null,
        child: TextButton(
          onPressed: Get.back,
          child: Text(msg.cancel.tr()),
        ),
      ),
    ],
  );

  Widget btnsWeb() => Row(
    children: [
      ElevatedButton(
        style: Get.theme.elevatedButtonTheme.style?.copyWith(
          minimumSize: WidgetStateProperty.all(const Size(0, 48)),
        ),
        onPressed: () {
          onOk?.call();
          Get.back();
        },
        child: Text(okMessage ?? msg.accept.tr()),
      ),
      const SizedBox(
        width: 10,
      ),
      Visibility(
        visible: onCancel != null,
        child: TextButton(
          onPressed: Get.back,
          style: Get.theme.textButtonTheme.style?.copyWith(
            minimumSize: WidgetStateProperty.all(const Size(0, 48)),
          ),
          child: Text(msg.cancel.tr()),
        ),
      ),
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(StringProperty('message', message))
    ..add(StringProperty('okMessage', okMessage))
    ..add(DiagnosticsProperty<Function?>('onOk', onOk))
    ..add(DiagnosticsProperty<Function?>('onCancel', onCancel))
    ..add(StringProperty('title', title));
  }
}
