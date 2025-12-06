import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

class AvatarUser extends StatelessWidget {
  const AvatarUser({
    required this.name,
    required this.radius,
    required this.onTap,
    required this.isPerfil,
    this.urlPhoto,
    this.isMovile = true,
    super.key,
  });

  final String name;
  final String? urlPhoto;
  final double radius;
  final Function()? onTap;
  final bool isPerfil;
  final bool isMovile;

  @override
  Widget build(BuildContext context) => Stack(
    clipBehavior: Clip.none,
    children: [
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(1),
          decoration: const BoxDecoration(
            color: ColorPalette.textPrimary,
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            radius: radius,
            backgroundColor: ColorPalette.backgroundCard,
            child: urlPhoto == null || urlPhoto == ''
                ? Text(
                    name.isNotEmpty ? name.substring(0, 1) : '',
                    style: context.textTheme.headlineSmall,
                  )
                : Container(
                    padding: const EdgeInsets.all(3),
                    child: Image.asset(urlPhoto!),
                  ),
          ),
        ),
      ),
      if (isPerfil && isMovile)
        Positioned(
          bottom: -5,
          right: -5,
          child: CircleAvatar(
            radius: isMovile ? 18 : 15,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.photo_camera_outlined,
              color: ColorPalette.primary,
              size: isMovile ? 25 : 15,
            ),
          ),
        ),
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('name', name))
      ..add(StringProperty('urlPhoto', urlPhoto))
      ..add(DoubleProperty('radius', radius))
      ..add(ObjectFlagProperty<Function()?>.has('onTap', onTap))
      ..add(DiagnosticsProperty<bool>('isPerfil', isPerfil))
      ..add(DiagnosticsProperty<bool>('isMovile', isMovile));
  }
}
