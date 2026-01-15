import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Enum for different types of custom snackbars
enum AlertType { success, warning, info, error }

class CustomAlert extends StatelessWidget {
  /// Custom Alert widget.
  ///
  /// Displays a customizable Alert message
  /// with optional title, action button, and close button.
  ///
  /// Properties:
  ///
  /// * [ type ] Type of alert (success, error, warning, info)
  /// * [ message ] Message to show in the Alert
  /// * [ hasShadow ] Whether the Alert has a shadow or not
  /// * [ title ] Optional title for the Alert
  /// * [ showCloseButton ] Whether to show a close button or not
  /// * [ onAction ] Optional callback for action button
  /// * [ actionLabel ] Optional label for action button
  /// * [ onClose ] Optional callback for close button
  /// * Returns a [ Widget ] representing the custom Alert
  const CustomAlert({
    required this.type,
    required this.message,
    super.key,
    this.hasShadow = true,
    this.title,
    this.showCloseButton = false,
    this.onAction,
    this.actionLabel,
    this.onClose,
  });

  final AlertType type;
  final bool hasShadow;
  final String message;
  final String? title;
  final bool showCloseButton;
  final VoidCallback? onAction;
  final String? actionLabel;
  final VoidCallback? onClose;

  /// Background color based on the type of Alert
  Color get _backgroundColor {
    switch (type) {
      case AlertType.success:
        return Colors.green.shade50;
      case AlertType.warning:
        return Colors.orange.shade50;
      case AlertType.info:
        return Colors.blue.shade50;
      case AlertType.error:
        return Colors.red.shade50;
    }
  }

  /// Icon color based on the type of Alert
  Color get _iconColor {
    switch (type) {
      case AlertType.success:
        return Colors.green;
      case AlertType.warning:
        return Colors.orange;
      case AlertType.info:
        return Colors.blue;
      case AlertType.error:
        return Colors.red;
    }
  }

  /// Icon data based on the type of Alert
  IconData get _icon {
    switch (type) {
      case AlertType.success:
        return Icons.check_circle_outline_outlined;
      case AlertType.warning:
        return Icons.warning_amber_outlined;
      case AlertType.info:
        return Icons.info_outline;
      case AlertType.error:
        return Icons.error_outline;
    }
  }

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: Container(
      constraints: const BoxConstraints(maxWidth: 500, minHeight: 60),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _iconColor.withValues(alpha: 0.3)),
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(_icon, color: _iconColor),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _iconColor,
                    ),
                  ),
                Text(message),
              ],
            ),
          ),
          if (onAction != null)
            GestureDetector(
              onTap: onAction,
              child: Chip(
                label: Text(
                  actionLabel ?? 'Action',
                  style: const TextStyle(color: Colors.orange),
                ),
              ),
            ),

          if (showCloseButton)
            IconButton(
              icon: const Icon(Icons.close, color: Colors.orange),
              onPressed: onClose,
            ),
        ],
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<AlertType>('type', type))
      ..add(DiagnosticsProperty<bool>('hasShadow', hasShadow))
      ..add(StringProperty('message', message))
      ..add(StringProperty('title', title))
      ..add(
        DiagnosticsProperty<bool?>('showCloseButton', showCloseButton),
      )
      ..add(ObjectFlagProperty<VoidCallback?>.has('onAction', onAction))
      ..add(StringProperty('actionLabel', actionLabel))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onClose', onClose));
  }
}
