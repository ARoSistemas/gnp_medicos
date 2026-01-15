import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/wdgt_image_from_web.dart';

class CardDataBank extends StatelessWidget {
  const CardDataBank({
    required this.bank,
    required this.name,
    required this.clabe,
    required this.numberCount,
    required this.jwt,
    super.key,
  });

  final String bank;
  final String name;
  final String clabe;
  final String numberCount;
  final String jwt;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: ColorPalette.borderGrey),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bank,
              style: Get.textTheme.bodySmall?.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: ColorPalette.textPrimary,
              ),
            ),
            SizedBox(height: context.scale(5, axis: ScaleAxis.height)),
            Text(
              name,
              style: Get.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: context.scale(5, axis: ScaleAxis.height)),
            Text(
              '${msg.numberAccount.tr()}: $numberCount',
              style: Get.textTheme.bodyMedium?.copyWith(
                color: ColorPalette.textSecondary,
              ),
            ),
            SizedBox(height: context.scale(5, axis: ScaleAxis.height)),
            Text(
              '${msg.clabe.tr()}: $clabe',
              style: Get.textTheme.bodyMedium?.copyWith(
                color: ColorPalette.textSecondary,
              ),
            ),
          ],
        ),
        Column(
          children: [
            ImageFromWeb(
              width: 60,
              height: 60,
              imageName: 'icono_modulo_fiscales_card.png',
              jwt: jwt,
            ),
          ],
        ),
      ],
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('bank', bank))
      ..add(StringProperty('name', name))
      ..add(StringProperty('clabe', clabe))
      ..add(StringProperty('numberCount', numberCount))
      ..add(StringProperty('jwt', jwt));
  }
}

 // SizedBox(
            //   height: context.scale(38, axis: ScaleAxis.height),
            //   child: CachedNetworkImage(
            //     imageUrl:
            //         'https://admonproveedoressalud-services-qa.gnp.com.mx
            //          /gestor-medico/assets/icono_mis_pagos_visa.png',
            //     httpHeaders: {
            //       'Authorization': 
            //    'Bearer ${stateController.user.token.jwt}',
            //     },
            //     errorWidget: (context, url, error) =>
            //         const Icon(Icons.question_mark_outlined),
            //   ),
            // ),
