import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/src/modules/directory/children/filter_results/domain/entities/models/item_results_mdl.dart';

class CardItemsResults extends StatelessWidget {
  const CardItemsResults({
    required this.item,
    this.isWeb = false,
    super.key,
  });

  final ItemResultsMdl item;
  final bool isWeb;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: SizedBox(
      height: context.pHeight(isWeb ? 16 : 15),
      width: context.pWidth(isWeb ? 90 : 85),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Get.theme.cardTheme.color,
          border: const Border(
            top: BorderSide(color: ColorPalette.primary),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Title
            Text(
              item.title,
              style: Get.textTheme.titleMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            /// SubTitle
            Text(
              item.subtitle,
              style: Get.textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            /// Description
            Text(
              item.desc,
              style: Get.textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
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
      ..add(DiagnosticsProperty<ItemResultsMdl>('item', item))
      ..add(DiagnosticsProperty<bool>('isWeb', isWeb));
  }
}
