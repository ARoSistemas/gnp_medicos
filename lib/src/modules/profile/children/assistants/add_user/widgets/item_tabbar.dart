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
    this.isCompleted = false,
    this.isWeb = false,
    super.key,
  });

  final bool isSelected;
  final bool isCompleted;
  final bool isWeb;
  final String title;
  final IconData iconName;

  @override
  Widget build(BuildContext context) {
    final Color activeColor;
    if (isSelected) {
      activeColor = ColorPalette.primary;
    } else if (isCompleted) {
      activeColor = ColorPalette.success;
    } else {
      activeColor = ColorPalette.textPrimary;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: isWeb ? context.scale(260) : isSelected 
        ? context.scale(260) : context.scale(60),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: activeColor,
            width: context.scale(2),
          ),
        ),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: (isSelected || isWeb)
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          Icon(iconName, size: 20, color: activeColor),
          SizedBox(width: (isSelected || isWeb) ? context.scale(10) : 0),
          if (isSelected || isWeb)
            Flexible(
              child: Text(
                title,
                style: Get.textTheme.labelLarge,
              ),
            ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('isSelected', isSelected))
      ..add(DiagnosticsProperty<bool>('isCompleted', isCompleted))
      ..add(StringProperty('title', title))
      ..add(DiagnosticsProperty<IconData>('iconName', iconName))
      ..add(DiagnosticsProperty<bool>('isWeb', isWeb));
  }
}
