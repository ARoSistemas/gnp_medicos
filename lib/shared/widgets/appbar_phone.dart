import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

class AppBarPhone extends StatelessWidget implements PreferredSizeWidget {
  const AppBarPhone({this.title, super.key});

  final String? title;

  @override
  Widget build(BuildContext context) => AppBar(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: ColorPalette.primary),
      onPressed: Get.back,
    ),
    title: Text(
      title ?? '',
      style: Get.textTheme.titleLarge?.copyWith(
        fontSize: 20,
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
    properties.add(StringProperty('title', title));
  }
}
