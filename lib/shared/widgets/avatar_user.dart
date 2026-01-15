import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

class AvatarUser extends StatelessWidget {
  const AvatarUser({
    required this.name,
    required this.radius,
    required this.onTap,
    required this.isPerfil,
    required this.jwt,
    this.customIcon,
    this.uploadPhoto,
    this.lastname = '',
    this.rfc,
    this.isMovile = true,
    super.key,
  });

  final IconData? customIcon;
  final String name;
  final String jwt;
  final String lastname;
  final String? rfc;
  final double radius;
  final Function()? onTap;
  final Function()? uploadPhoto;
  final bool isPerfil;
  final bool isMovile;

  @override
  Widget build(BuildContext context) {
    final String first = name.isNotEmpty ? name.substring(0, 1) : '';
    final String last = lastname.isNotEmpty ? lastname.substring(0, 1) : '';
    final int initialsLength = '$first$last'.length;
    final double fontSize = initialsLength == 1 ? radius * 1.1 : radius * 0.65;

    return Stack(
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
              child: rfc == null || rfc == ''
                  ? Text(
                      '$first$last',
                      style: context.textTheme.headlineSmall!.copyWith(
                        fontSize: fontSize,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(radius),
                      child: Image.network(
                        '${AppConfig.baseUrlMedicos}/gestor-medico/assets/avatar/$rfc/avatar.png?cb=${DateTime.now().millisecondsSinceEpoch}',
                        headers: {'Authorization': 'Bearer $jwt'},
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, exception, stackTrace) => Text(
                          '$first$last',
                          style: context.textTheme.headlineSmall!.copyWith(
                            fontSize: fontSize,
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ),
        if (isPerfil && isMovile && uploadPhoto != null)
          Positioned(
            bottom: -5,
            right: -5,
            child: CircleAvatar(
              radius: isMovile ? 18 : 15,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  customIcon ?? Icons.photo_camera_outlined,
                  color: ColorPalette.primary,
                  size: isMovile ? 25 : 15,
                ),
                onPressed: uploadPhoto,
              ),
            ),
          ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('name', name))
      ..add(StringProperty('rfc', rfc))
      ..add(DoubleProperty('radius', radius))
      ..add(ObjectFlagProperty<Function()?>.has('onTap', onTap))
      ..add(DiagnosticsProperty<bool>('isPerfil', isPerfil))
      ..add(DiagnosticsProperty<bool>('isMovile', isMovile))
      ..add(StringProperty('lastname', lastname))
      ..add(ObjectFlagProperty<Function()?>.has('uploadPhoto', uploadPhoto))
      ..add(DiagnosticsProperty<IconData?>('customIcon', customIcon))
      ..add(StringProperty('jwt', jwt));
  }
}
