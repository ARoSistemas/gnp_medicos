import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

/// A widget that displays a loading indicator with
/// optional text and a custom icon.
///
/// This widget is used to indicate a loading or processing state. It centers
/// a [CircularProgressIndicator] by default, but can display a custom [icon]
/// if one is provided. It also shows a customizable [title] and [subtitle]
/// below the indicator.
///
/// ### Example Usage:
///
/// ```dart
/// // Default usage with default texts
/// LoadingGnp()
///
/// // Custom usage
/// LoadingGnp(
///   title: 'Fetching Data...',
///   subtitle: 'This will only take a moment.',
///   icon: Icon(Icons.downloading),
/// )
/// ```
///
/// **Note:** If [title] or [subtitle] are not provided, this widget falls back
/// to default text messages from `esMessages`, which are in Spanish.
class LoadingGnp extends StatelessWidget {
  /// Creates a loading indicator widget.
  const LoadingGnp({
    this.title,
    this.subtitle,
    this.icon,
    this.isPositionUp = true,
    super.key,
  });

  /// The main text displayed below the indicator.
  final String? title;

  /// The secondary text displayed below the title.
  final String? subtitle;

  /// An optional widget to display instead of the
  /// default [CircularProgressIndicator].
  final Widget? icon;

  /// Determines the position of the loading indicator.
  final bool isPositionUp;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (icon == null)
        const CircularProgressIndicator(color: ColorPalette.primary),

      if (isPositionUp)
        if (icon != null) icon!,
      Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          title == null ? esMessages.mx.loadingData.value : title!,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          subtitle == null ? esMessages.mx.pleaseWait.value : subtitle!,
          style: const TextStyle(fontSize: 20),
        ),
      ),

      if (!isPositionUp)
        if (icon != null) icon!,
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('title', title))
      ..add(StringProperty('subtitle', subtitle))
      ..add(DiagnosticsProperty<bool>('isPositionUp', isPositionUp));
  }
}
