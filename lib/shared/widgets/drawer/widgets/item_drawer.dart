import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/wdgt_image_from_web.dart';

/// A widget that represents a single interactive item within a `Drawer`.
///
/// This widget is designed to be used in a list of items, typically inside a
/// [Drawer]. It displays an icon fetched from the web and a title in a
/// [ListTile] format. The entire item is tappable via the [onTap] callback.
///
/// ### Example Usage:
///
/// ```dart
/// ItemDrawer(
///   icon: 'my_icon.png',
///   title: 'My Profile',
///   jwt: 'your_jwt_token',
///   onTap: () {
///     Get.toNamed('/profile');
///   },
/// )
/// ```
class ItemDrawer extends StatelessWidget {
  /// Creates a drawer item.
  const ItemDrawer({
    required this.icon,
    required this.title,
    required this.jwt,
    required this.onTap,
    super.key,
  });

  /// The name of the image file for the icon, fetched using [ImageFromWeb].
  final String icon;

  /// The text to be displayed as the title of the item.
  final String title;

  /// The JSON Web Token (JWT) required by [ImageFromWeb] to authenticate the
  /// image request.
  final String jwt;

  /// The callback function that is executed when the item is tapped.
  final Function()? onTap;

  @override
  Widget build(BuildContext context) => ListTile(
    onTap: onTap,
    leading: ImageFromWeb(
      imageName: icon,
      jwt: jwt,
    ),
    title: Text(
      title,
      style: const TextStyle(
        color: ColorPalette.textPrimary,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('icon', icon))
      ..add(StringProperty('title', title))
      ..add(StringProperty('jwt', jwt))
      ..add(ObjectFlagProperty<Function()?>.has('onTap', onTap));
  }
}
