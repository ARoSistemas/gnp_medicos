import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

class ModalAceptTerms extends StatelessWidget {
  const ModalAceptTerms({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(
      bottom: MediaQuery.of(context).viewInsets.bottom,
    ),
    child: DecoratedBox(
      decoration: const BoxDecoration(
        color: ColorPalette.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Title
            Text(
              msg.homeTerms.value,
              style: context.textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: Get.back,
              child: const Text('Entendido'),
            ),
          ],
        ),
      ),
    ),
  );
}
