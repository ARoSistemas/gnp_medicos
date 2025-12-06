import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/font_size_extension.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/avatar_user.dart';

class BannerUserWeb extends StatelessWidget {
  const BannerUserWeb({
    required this.name,
    required this.medicalIdentifier,
    this.canChangeProfile = false,
    this.photo,
    super.key,
  });

  final String name;
  final String medicalIdentifier;
  final String? photo;
  final bool canChangeProfile;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    decoration: const BoxDecoration(
      color: ColorPalette.backgroundCardBanner,
      borderRadius: BorderRadius.all(Radius.circular(8)),
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
                'Buenas tardes, $name',
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
                medicalIdentifier,
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
            //     label: Text(msg.changeUser.value),
            //     icon: const Icon(Icons.supervised_user_circle_outlined),
            //     onPressed: () => Get.offAndToNamed(HomePage.page.name),
            //   ),
            // ),
          ],
        ),
        const SizedBox(width: 10),
        AvatarUser(
          name: name,
          radius: 25,
          isPerfil: true,
          urlPhoto: photo,
          onTap: () {},
          isMovile: false,
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
          null,
        ),
      )
      ..add(DiagnosticsProperty<bool>('canChangeProfile', canChangeProfile));
  }
}
