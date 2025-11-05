import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/avatar_user.dart';

class ItemAssitants extends StatelessWidget {
  const ItemAssitants({
    required this.name,
    required this.subTitle,
    required this.onTap,
    this.urlPhoto,
    super.key,
  });
  final String name;
  final String subTitle;
  final String? urlPhoto;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) => Card(
    color: ColorPalette.white,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
      side: const BorderSide(
        color: ColorPalette.borderCardUser,
      ),
    ),
    child: GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AvatarUser(
                  name: name,
                  urlPhoto: urlPhoto,
                  isPerfil: false,
                  radius: 40,
                  onTap: onTap,
                ),
                SizedBox(width: context.scale(16)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: Get.textTheme.titleMedium),
                    SizedBox(height: context.scale(3, axis: ScaleAxis.height)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        subTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Get.textTheme.labelMedium?.copyWith(
                          color: ColorPalette.textTertiary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Icon(
              Icons.chevron_right,
              color: ColorPalette.primary,
              size: 30,
            ),
          ],
        ),
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('urlPhoto', urlPhoto))
      ..add(StringProperty('name', name))
      ..add(StringProperty('subTitle', subTitle))
      ..add(ObjectFlagProperty<void Function()?>.has('onTap', onTap));
  }
}
