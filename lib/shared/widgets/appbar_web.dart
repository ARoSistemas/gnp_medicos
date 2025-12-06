import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

class AppBarWeb extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWeb({this.title, this.onBack, this.elevation = 0, super.key});

  final String? title;
  final Function()? onBack;
  final double elevation;

  @override
  Widget build(BuildContext context) => AppBar(
    shape: const Border(
      bottom: BorderSide(
        color: ColorPalette.primary,
      ),
    ),
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    elevation: elevation,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: ColorPalette.primary),
      onPressed: onBack ?? Get.back,
    ),
    title: Text(
      title ?? '',
      style: Get.textTheme.titleLarge?.copyWith(
        fontSize: 32,
        color: ColorPalette.textPrimary,
        fontWeight: FontWeight.w500,
      ),
    ),
    centerTitle: false,
  );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('title', title))
      ..add(DiagnosticsProperty<Function?>('onBack', onBack))
      ..add(DoubleProperty('elevation', elevation));
  }
}
