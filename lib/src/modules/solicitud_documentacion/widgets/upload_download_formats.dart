import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

class DownloadDocument extends StatelessWidget {
  const DownloadDocument({required this.title, required this.onTap, super.key});

  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      border: Border.all(color: ColorPalette.borderGrey),
    ),
    child: Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: Get.textTheme.titleMedium),
                  const Icon(
                    Icons.download_outlined,
                    color: ColorPalette.primary,
                    size: 22,
                  ),
                ],
              ),
              SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
              Text('Descárgala aquí', style: Get.textTheme.bodySmall),
            ],
          ),
        ),
      ],
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('title', title))
      ..add(ObjectFlagProperty<Function()?>.has('onTap', onTap));
  }
}
