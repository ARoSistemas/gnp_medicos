import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

class CardFileDownload extends StatelessWidget {
  const CardFileDownload({
    required this.nombre,
    required this.onDownload,
    super.key,
  });

  final String nombre;
  final Function() onDownload;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(
        color: ColorPalette.borderCardFormat
      )
    ),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              nombre,
              style: Get.textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          GestureDetector(
            onTap: onDownload,
            child: const Icon(
              Icons.download_outlined,
              color: ColorPalette.primary
            ),
          )
        ],
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
    ..add(ObjectFlagProperty<Function()>.has('onDownload', onDownload))
    ..add(StringProperty('nombre', nombre));
  }
}
