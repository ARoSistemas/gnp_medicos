import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/wdgt_image_from_web.dart';

class ItemDrawer extends StatelessWidget {
  const ItemDrawer({
    required this.icon,
    required this.title,
    required this.jwt,
    required this.onTap,
    super.key,
  });

  final String icon;
  final String title;
  final String jwt;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) => ListTile(
    onTap: onTap,
    leading: ImageFromWeb(
      imageName: icon,
      jwt: jwt,
    ),
    title: Text(
      title,
      style: const TextStyle(
        color: ColorPalette.textPrimary,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('icon', icon))
      ..add(StringProperty('title', title))
      ..add(StringProperty('jwt', jwt))
      ..add(ObjectFlagProperty<Function()?>.has('onTap', onTap));
  }
}
