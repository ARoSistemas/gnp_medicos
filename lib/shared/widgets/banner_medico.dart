import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/avatar_user.dart';

class BannerMedico extends StatelessWidget {
  const BannerMedico({
    required this.rfc,
    required this.jwt,
    this.name = '',
    this.lastname = '',
    this.medicalIdentifier = '',
    super.key,
  });

  final String name;
  final String lastname;
  final String rfc;
  final String jwt;
  final String medicalIdentifier;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.only(top: 7, bottom: 7),
    decoration: const BoxDecoration(color: ColorPalette.backgroundCardBanner),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 8,
      children: [
        Expanded(
          child: Row(
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
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Get.textTheme.bodySmall?.copyWith(
                        color: ColorPalette.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.scale(4, axis: ScaleAxis.height)),
                    Text(
                      medicalIdentifier,
                      style: Get.textTheme.bodySmall?.copyWith(
                        color: ColorPalette.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AvatarUser(
              name: name,
              lastname: lastname,
              rfc: rfc,
              jwt: jwt,
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
      ..add(StringProperty('lastname', lastname))
      ..add(StringProperty('medicalIdentifier', medicalIdentifier))
      ..add(StringProperty('rfc', rfc))
      ..add(StringProperty('jwt', jwt));
  }
}
