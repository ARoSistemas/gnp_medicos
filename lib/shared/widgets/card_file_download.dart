import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/wdgt_image_from_web.dart';

class CardFileDownload extends StatelessWidget {
  const CardFileDownload({
    required this.nombre,
    required this.image,
    required this.onDownload,
    required this.jwt,
    super.key,
  });

  final String nombre;
  final String image;
  final Function() onDownload;
  final String jwt;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 312,
    width: 324,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: ColorPalette.borderCardFormat
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                nombre,
                style: Get.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),

            ImageFromWeb(
              height: 150,
              width: double.infinity,
              fit: BoxFit.fill,
              imageName: image,
              jwt: jwt
            ),
    
            OutlinedButton(
              onPressed: onDownload,
              style: kIsWeb ? Get.theme.outlinedButtonTheme.style?.copyWith(
                minimumSize: WidgetStateProperty.all(const Size(0, 48)),
              ) : null,
              child: Text(msg.download.tr()),
            )
          ],
        ),
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
    ..add(ObjectFlagProperty<Function()>.has('onDownload', onDownload))
    ..add(StringProperty('nombre', nombre))
    ..add(StringProperty('jwt', jwt))
    ..add(StringProperty('image', image));
  }
}
