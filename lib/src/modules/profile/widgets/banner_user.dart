import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/font_size_extension.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/avatar_user.dart';
import 'package:medicos/src/modules/home/home_page.dart';

class BannerUser extends StatelessWidget {
  const BannerUser({
    required this.name,
    required this.medicalIdentifier,
    required this.onTapChangePhoto,
    this.canChangeProfile = false,
    this.photo,
    super.key,
  });

  final String name;
  final String medicalIdentifier;
  final String? photo;
  final bool canChangeProfile;
  final Function()? onTapChangePhoto;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.only(top: 10, bottom: 10),
    decoration: const BoxDecoration(color: ColorPalette.backgroundCardBanner),
    child: Row(
      children: [
        SizedBox(width: context.scale(20)),
        AvatarUser(
          name: name,
          radius: 40,
          isPerfil: true,
          urlPhoto: photo,
          onTap: onTapChangePhoto,
        ),
        SizedBox(width: context.scale(20)),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 14),
                      alignment: Alignment.topLeft,
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: ColorPalette.textSecondary,
                          fontSize: context.fontSize(18),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: context.scale(6, axis: ScaleAxis.height)),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        medicalIdentifier,
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: ColorPalette.textSecondary,
                        ),
                      ),
                    ),
                    SizedBox(height: context.scale(6, axis: ScaleAxis.height)),
                    Visibility(
                      visible: canChangeProfile,
                      child: TextButton.icon(
                        label: Text(esMessages.mx.changeUser.value),
                        icon: const Icon(Icons.supervised_user_circle_outlined),
                        onPressed: () => Get.offAndToNamed(HomePage.page.name),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
      ..add(StringProperty('photo', photo))
      ..add(
        ObjectFlagProperty<Function()?>.has(
          'onTapChangePhoto',
          onTapChangePhoto,
        ),
      )
      ..add(DiagnosticsProperty<bool>('canChangeProfile', canChangeProfile));
  }
}
