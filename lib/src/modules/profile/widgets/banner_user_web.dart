import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/font_size_extension.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/avatar_user.dart';
import 'package:medicos/src/modules/profile/profile_page.dart';

class BannerUserWeb extends StatelessWidget {
  const BannerUserWeb({
    required this.name,
    required this.lastname,
    required this.medicalIdentifier,
    required this.rfc,
    required this.jwt,
    this.canChangeProfile = false,
    super.key,
  });

  final String name;
  final String lastname;
  final String medicalIdentifier;
  final String rfc;
  final String jwt;
  final bool canChangeProfile;

  @override
  Widget build(BuildContext context) => InkWell(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: const BoxDecoration(
        color: ColorPalette.backgroundCardBanner,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /// Name
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Buenas tardes, $name $lastname',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: ColorPalette.textSecondary,
                    fontSize: context.fontSize(10),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              /// Medical Identifier
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  '${medicalIdentifier.isNotEmpty ? 'Filiación' : ''} '
                  '$medicalIdentifier',
                  textAlign: TextAlign.right,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    // color: ColorPalette.textSecondary,
                    color: ColorPalette.primary,
                    fontSize: context.fontSize(9),
                  ),
                ),
              ),

              // Visibility(
              //   visible: canChangeProfile,
              //   child: TextButton.icon(
              //     label: Text(msg.changeUser.tr()),
              //     icon: const Icon(Icons.supervised_user_circle_outlined),
              //     onPressed: () => Get.offAndToNamed(HomePage.page.name),
              //   ),
              // ),
            ],
          ),
          const SizedBox(width: 10),
          AvatarUser(
            name: name,
            lastname: lastname,
            radius: 15,
            isPerfil: true,
            rfc: rfc,
            jwt: jwt,
            onTap: () => Get.toNamed(ProfilePage.page.name),
            isMovile: false,
          ),
        ],
      ),
    ),
    onTap: () => Get.toNamed(ProfilePage.page.name),
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
          null,
        ),
      )
      ..add(DiagnosticsProperty<bool>('canChangeProfile', canChangeProfile))
      ..add(StringProperty('rfc', rfc))
      ..add(StringProperty('jwt', jwt));
  }
}
