import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

/// A widget that displays a card with a title and an arrow icon.
///
/// This widget is designed to be used in profile or menu sections
/// where a visual link to another screen is needed. The card is interactive
/// and executes an [onTap] function when pressed.
///
/// The visibility of the card is controlled by the [showCard] parameter.
/// If it is `false`, the widget will not take up any space in the UI.
///
/// ### Example Usage:
///
/// ```dart
/// CardSectionProfile(
///   title: 'Personal Data',
///   subtitle: 'Basic user information',
///   showCard: true,
///   onTap: () {
///     Get.toNamed('/personal-data');
///   },
/// )
/// ```
///
/// **Note:** The `subtitle` and `icon` parameters are defined in the
/// constructor but are not currently used in the widget's implementation.
class CardSectionProfile extends StatelessWidget {
  /// Creates an item for profile page
  const CardSectionProfile({
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.showCard,
    this.icon,
    super.key,
  });

  /// The main text displayed on the card.
  final String title;

  /// A secondary text for the card. Currently not displayed.
  final String subtitle;

  /// The function that is executed when the user taps the card.
  final Function()? onTap;

  /// An icon for the card. Currently not displayed.
  final IconData? icon;

  /// Controls whether the card should be shown or not.
  ///
  /// If `true`, the card is rendered. If `false`, an empty `SizedBox`
  /// is rendered instead.
  final bool showCard;

  @override
  Widget build(BuildContext context) => showCard
      ? GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 7,
                ),
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
          ),
        )
      : const SizedBox();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('title', title))
      ..add(StringProperty('subtitle', subtitle))
      ..add(ObjectFlagProperty<Function()?>.has('onTap', onTap))
      ..add(DiagnosticsProperty<IconData?>('icon', icon))
      ..add(DiagnosticsProperty<bool>('showCard', showCard));
  }
}
