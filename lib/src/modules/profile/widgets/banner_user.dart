import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/font_size_extension.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/avatar_user.dart';
import 'package:medicos/src/modules/home/home_page.dart';

class BannerUser extends StatelessWidget {
  const BannerUser({
    required this.name,
    required this.lastname,
    required this.medicalIdentifier,
    required this.rfc,
    required this.jwt,
    this.onTapChangePhoto,
    this.canChangeProfile = false,
    super.key,
  });

  final String name;
  final String lastname;
  final String medicalIdentifier;
  final String rfc;
  final String jwt;
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
          lastname: lastname,
          radius: 40,
          isPerfil: true,
          rfc: rfc,
          jwt: jwt,
          onTap: (){},
          uploadPhoto: onTapChangePhoto,
        ),
        SizedBox(width: context.scale(20)),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: kIsWeb
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.center,
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
                        style: kIsWeb
                            ? Get.theme.textButtonTheme.style?.copyWith(
                                minimumSize: WidgetStateProperty.all(
                                  const Size(0, 48),
                                ),
                              )
                            : null,
                        label: Text(msg.changeUser.tr()),
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
      ..add(StringProperty('lastname', lastname))
      ..add(StringProperty('medicalIdentifier', medicalIdentifier))
      ..add(
        ObjectFlagProperty<Function()?>.has(
          'onTapChangePhoto',
          onTapChangePhoto,
        ),
      )
      ..add(DiagnosticsProperty<bool>('canChangeProfile', canChangeProfile))
      ..add(StringProperty('rfc', rfc))
      ..add(StringProperty('jwt', jwt));
  }
}
