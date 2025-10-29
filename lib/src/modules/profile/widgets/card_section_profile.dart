import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

class CardSectionProfile extends StatelessWidget {
  const CardSectionProfile({
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.icon,
    super.key,
  });

  final String title;
  final String subtitle;
  final Function()? onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.textTheme.titleMedium,
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: onTap,
              color: ColorPalette.primary,
            ),
          ],
        ),
      ),
    ),
  );

  /* Padding(
    padding: EdgeInsets.only(bottom: context.scale(20, axis: ScaleAxis.height)),
    child: GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 5,
        color: Colors.white,
        shadowColor: const Color.fromRGBO(0, 45, 113, 0.239),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(
            color: ColorPalette.backgroundCard
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    if (icon != null)
                      Padding(
                        padding: EdgeInsets.only(right: context.scale(10)),
                        child: Icon(
                          icon,
                          size: 50,
                          color: ColorPalette.textPrimary
                        ),
                      ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: Get.textTheme.titleMedium),
                          Text(
                            subtitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Get.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.deepOrange,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    ),
  ); */

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('title', title))
      ..add(StringProperty('subtitle', subtitle))
      ..add(ObjectFlagProperty<Function()?>.has('onTap', onTap))
      ..add(DiagnosticsProperty<IconData?>('icon', icon));
  }
}
