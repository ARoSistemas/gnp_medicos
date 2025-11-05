import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/widgets/wdgt_image_from_web.dart';

/// A card widget that displays an image and a title, designed for use as an
/// item in a directory or menu list.
///
/// This widget presents content in a horizontal layout, with an image on the
/// left and a title on the right, all contained within a [Card]. It is
/// sized responsively to fit different screen widths.
///
/// ### Example Usage:
///
/// ```dart
/// ItemsMenuDirectory(
///   title: 'Medical Reports',
///   img: 'reports_icon.png',
///   jwt: 'your_jwt_token_here',
/// )
/// ```
///
/// **Note:** The [img] parameter is received by the constructor but is not
/// currently used to load the image in the `ImageFromWeb` widget.
/// The `imageName` is hardcoded as an empty string.
class ItemsMenuDirectory extends StatelessWidget {
  /// Creates an item for a menu directory.
  const ItemsMenuDirectory({
    required this.img,
    required this.title,
    required this.jwt,
    super.key,
  });

  /// The title text to be displayed next to the image.
  final String title;

  /// The name or path of the image file to be displayed.
  /// **Note:** This parameter is currently not being used.
  final String img;

  /// The JSON Web Token required for authenticating the image request.
  final String jwt;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
    child: SizedBox(
      height: 95,
      width: context.scale(330),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ImageFromWeb(
                imageName: img,
                jwt: jwt,
                height: 85,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  title,
                  style: Get.textTheme.titleLarge,
                ),
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
    properties
      ..add(StringProperty('title', title))
      ..add(StringProperty('jwt', jwt))
      ..add(StringProperty('img', img));
  }
}
