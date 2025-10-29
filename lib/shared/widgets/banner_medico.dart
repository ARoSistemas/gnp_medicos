import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/avatar_user.dart';

class BannerMedico extends StatelessWidget {
  const BannerMedico({
    this.photo = '',
    this.name = '',
    this.medicalIdentifier = '',
    super.key,
  });

  final String name;
  final String medicalIdentifier;
  final String photo;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.only(top: 7, bottom: 7),
    decoration: const BoxDecoration(color: ColorPalette.backgroundCardBanner),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: context.scale(16)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nombre:', style: Get.textTheme.bodySmall),
                SizedBox(height: context.scale(4, axis: ScaleAxis.height)),
                Text('Filiación:', style: Get.textTheme.bodySmall),
              ],
            ),
            SizedBox(width: context.scale(10)),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Get.textTheme.bodySmall?.copyWith(
                    color: ColorPalette.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: context.scale(4, axis: ScaleAxis.height)),
                // medicalIdentifier ?? stateControllers.user.codigoFiliacion,
                Text(
                  medicalIdentifier,
                  style: Get.textTheme.bodySmall?.copyWith(
                    color: ColorPalette.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AvatarUser(
              name: name,
              urlPhoto: photo,
              isPerfil: false,
              radius: 20,
              onTap: () {},
            ),
            SizedBox(width: context.scale(16)),
          ],
        ),
      ],
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('name', name))
      ..add(StringProperty('medicalIdentifier', medicalIdentifier))
      ..add(StringProperty('photo', photo));
  }
}
