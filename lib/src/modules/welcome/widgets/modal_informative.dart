import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

class ModalInformative extends StatelessWidget {
  const ModalInformative({
    required this.message,
    super.key,
    this.okMessage,
    this.onOk,
    this.onCancel
  });
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
                Flexible(
                  child: SingleChildScrollView(
                    child: Text(
                      message,
                      style: context.textTheme.titleMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    onOk?.call();
                    Get.back();
                  },
                  child: Text(okMessage ?? msg.accept.value),
                ),
                const SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: onCancel != null,
                  child: OutlinedButton(
                    onPressed: Get.back,
                    child: Text(msg.cancel.value),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(StringProperty('message', message))
    ..add(StringProperty('okMessage', okMessage))
    ..add(DiagnosticsProperty<Function?>('onOk', onOk))
    ..add(DiagnosticsProperty<Function?>('onCancel', onCancel));
  }
}
