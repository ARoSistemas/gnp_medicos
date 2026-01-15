import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
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
    this.isWeb = false,
    this.width = 250,
    this.isSelected = false,
    this.isHovered = false,
    super.key,
  });

  /// The title text to be displayed next to the image.
  final String title;

  /// The name or path of the image file to be displayed.
  /// **Note:** This parameter is currently not being used.
  final String img;

  /// The JSON Web Token required for authenticating the image request.
  final String jwt;

  /// Indicates whether the widget is being displayed in a web context.
  final bool isWeb;

  /// The width of the widget.
  final double width;

  /// Indicates whether the item is currently selected.
  final bool isSelected;

  /// Indicates whether the item is currently being hovered over.
  final bool isHovered;

  @override
  Widget build(BuildContext context) {
    final Color borderColor = isSelected
        ? ColorPalette.primary
        : isHovered
        ? ColorPalette.primary.withValues(alpha: 0.6)
        : ColorPalette.borderCardUser;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        height: isWeb ? 60 : 95,
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ImageFromWeb(
                height: isWeb ? 35 : 50,
                width: isWeb ? 35 : 50,
                imageName: img,
                jwt: jwt,
              ),

              Padding(
                padding: EdgeInsets.only(left: isWeb ? 5 : 20),
                child: width < 170
                    ? const SizedBox.shrink()
                    : SizedBox(
                        width: isWeb ? (width - 60) : width,
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: isWeb
                              ? Get.textTheme.titleMedium
                              : Get.textTheme.titleLarge,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('title', title))
      ..add(StringProperty('jwt', jwt))
      ..add(StringProperty('img', img))
      ..add(DiagnosticsProperty<bool>('isWeb', isWeb))
      ..add(DoubleProperty('width', width))
      ..add(DiagnosticsProperty<bool>('isSelected', isSelected))
      ..add(DiagnosticsProperty<bool>('isHovered', isHovered));
  }
}
