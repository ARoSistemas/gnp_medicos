import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';

class ChangePasswordSuccessDialog extends StatelessWidget {
  const ChangePasswordSuccessDialog({
    required this.onContinue,
    super.key,
  });

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    constraints: const BoxConstraints(
      maxWidth: 300,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          msg.successfulChange.tr(),
          style: Get.textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        Text(
          msg.dPasswordUpdated.tr(),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: onContinue,
          child: Text(msg.continueB.tr()),
        ),
      ],
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      ObjectFlagProperty<VoidCallback>.has('onContinue', onContinue),
    );
  }
}
