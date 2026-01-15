import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/shared/widgets/wdgt_image_from_web.dart';

class CardBenefit extends StatelessWidget {
  const CardBenefit({
    required this.title,
    required this.description,
    required this.image,
    required this.onTap,
    required this.jwt,
    this.web = false,
    super.key,
  });

  final String? title;
  final String? description;
  final String? image;
  final String? jwt;
  final bool web;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: SizedBox(
      width: web ? 350 : null,
      height:  web ? 324 : null,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.value(), 
                    style: Get.textTheme.titleMedium,
                  ),
                    Text(
                    description.value(), 
                    style: Get.textTheme.bodyMedium,
                    maxLines: web ? 3 : null,
                    overflow: web ? TextOverflow.ellipsis : null,
                  ),
                ],
              ),
            ),
            ImageFromWeb(
              height: 200,
              imageName: image.value(),
              jwt: jwt.value(),
              path: '/beneficios/archivos',
              width: double.infinity,
            )
          ],
        ),
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(StringProperty('title', title))
    ..add(StringProperty('description', description))
    ..add(StringProperty('image', image))
    ..add(StringProperty('jwt', jwt))
    ..add(ObjectFlagProperty<Function()?>.has('onTap', onTap))
    ..add(DiagnosticsProperty<bool?>('web', web));
  }
}
