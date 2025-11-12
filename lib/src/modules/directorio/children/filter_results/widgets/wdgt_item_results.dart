import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/domain/entities/models/item_results_mdl.dart';

class CardItemsResults extends StatelessWidget {
  const CardItemsResults({
    required this.item,
    super.key,
  });

  final ItemResultsMdl item;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: SizedBox(
      height: context.pHeight(16),
      width: context.pWidth(85),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5,
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
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ItemResultsMdl>('item', item));
  }
}
