import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

class ButtonPerfil extends StatelessWidget {
  const ButtonPerfil({
    required this.label,
    required this.icon,
    this.color,
    this.onPressed,
    super.key,
  });

  final String label;
  final Widget icon;
  final Color? color;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.only(left: 14),
    alignment: Alignment.topLeft,
    child: TextButton.icon(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all<Size>(Size.zero),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 4),
        ),
        visualDensity: VisualDensity.compact,
      ),
      icon: icon,
      label: Text(
        label,
        style: Get.textTheme.titleSmall?.copyWith(
          color: color ?? ColorPalette.textPrimary,
        ),
      ),
      onPressed: onPressed,
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('label', label))
      ..add(ObjectFlagProperty<Function()?>.has('onPressed', onPressed))
      ..add(ColorProperty('color', color));
  }
}
