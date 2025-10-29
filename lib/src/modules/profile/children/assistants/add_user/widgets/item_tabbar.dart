import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

class ItemTabBarView extends StatelessWidget {
  const ItemTabBarView({
    required this.isSelected,
    required this.title,
    required this.iconName,
    super.key,
  });

  final bool isSelected;
  final String title;
  final IconData iconName;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 15),
    width: isSelected ? context.scale(260) : context.scale(60),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: isSelected ? ColorPalette.primary : ColorPalette.textPrimary,
          width: context.scale(2),
        ),
      ),
    ),
    alignment: Alignment.center,
    child: Row(
      mainAxisAlignment: isSelected
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      children: [
        Icon(
          iconName,
          size: 20,
          color: ColorPalette.primary,
        ),

        SizedBox(
          width: isSelected ? context.scale(10) : context.scale(0),
        ),
        if (isSelected)
          Flexible(
            child: Text(
              title,
              style: Get.textTheme.labelLarge,
            ),
          )
        else
          const SizedBox(),
      ],
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('isSelected', isSelected))
      ..add(StringProperty('title', title))
      ..add(DiagnosticsProperty<IconData>('iconName', iconName));
  }
}
