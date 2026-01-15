import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

class CardDocumentUpload extends StatelessWidget {
  const CardDocumentUpload({
    required this.title,
    this.downloading = false, 
    this.description,
    this.onTap,
    super.key,
  });

  final String title;
  final String? description;
  final bool downloading;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      border: Border.all(
        color: onTap == null ? Colors.transparent : ColorPalette.borderGrey,
      ),
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
                  if (onTap != null)
                    downloading ?
                    const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        color: ColorPalette.primary,
                      ),
                    ) :
                    const Icon(
                      Icons.download_outlined,
                      color: ColorPalette.primary,
                      size: 22,
                    )
                  else
                    const SizedBox.shrink(),
                ],
              ),
              SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
              Text(
                description ?? 'Descárgala aquí',
                style: Get.textTheme.bodySmall,
              ),
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
      ..add(ObjectFlagProperty<Function()?>.has('onTap', onTap))
      ..add(StringProperty('description', description))
      ..add(DiagnosticsProperty<bool>('downloading', downloading));
  }
}
