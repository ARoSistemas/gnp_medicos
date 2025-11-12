import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

class CardUploadFormat extends StatelessWidget {
  const CardUploadFormat({
    required this.titleDocument,
    required this.onTapDelete,
    required this.onTapView,
    super.key,
  });

  final String titleDocument;
  final Function()? onTapDelete;
  final Function()? onTapView;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        titleDocument,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: Get.textTheme.titleMedium,
      ),
      SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          color: ColorPalette.white,
          border: Border(
            bottom: BorderSide(
              color: ColorPalette.borderCardFormat,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: context.scale(15)),
                const Icon(
                  Icons.picture_as_pdf_outlined,
                  color: ColorPalette.textPrimary,
                ),
                SizedBox(width: context.scale(15)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: context.scale(250),
                      child: Text(
                        titleDocument,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Get.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ColorPalette.textTertiary,
                        ),
                      ),
                    ),
                    Text(
                      'Completado',
                      style: Get.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ColorPalette.success,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: onTapDelete,
                  child: const Icon(
                    Icons.delete_outline,
                    color: ColorPalette.primary,
                  ),
                ),
                SizedBox(width: context.scale(15)),
              ],
            ),
          ],
        ),
      ),
      SizedBox(height: context.scale(15, axis: ScaleAxis.height)),
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(ObjectFlagProperty<Function()?>.has('onTapDelete', onTapDelete))
      ..add(StringProperty('titleDocument', titleDocument))
      ..add(ObjectFlagProperty<Function()?>.has('onTapView', onTapView));
  }
}
