import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/widgets/custom_alert.dart';

abstract class AlertAbstract {
  /// Method to show a custom Alert as an overlay
  ///
  /// * [type] Type of alert (success, error, warning, info)
  /// * [message] Message to show in the Alert
  /// * [hasShadow] Whether the Alert has a shadow or not
  /// * [title] Optional title for the Alert
  /// * [showCloseButton] Whether to show a close button or not
  /// * [onAction] Optional callback for action button
  /// * [actionLabel] Optional label for action button
  /// * [duration] Duration before auto-closing the Alert
  /// (if no close button) Defaults to 3 seconds
  void show({
    required AlertType type,
    required String message,
    bool hasShadow = true,
    String? title,
    bool showCloseButton = false,
    VoidCallback? onAction,
    String? actionLabel,
    Duration duration = const Duration(seconds: 3),
  });

  void removeCurrent();

  void showAlert({required Widget child});
}

class AlertServiceImpl extends GetxService implements AlertAbstract {
  /// Current active overlay entry
  OverlayEntry? _currentOverlay;

  /// Method to show a custom Alert as an overlay
  ///
  /// * [ type ] Type of alert (success, error, warning, info)
  /// * [ message ] Message to show in the Alert
  /// * [ hasShadow ] Whether the Alert has a shadow or not
  /// * [ title ] Optional title for the Alert
  /// * [ showCloseButton ] Whether to show a close button or not
  /// * [ onAction ] Optional callback for action button
  /// * [ actionLabel ] Optional label for action button
  /// * [ duration ] Duration before auto-closing the Alert
  ///   (if no close button) Defaults to 3 seconds
  @override
  void show({
    required AlertType type,
    required String message,
    bool hasShadow = true,
    String? title,
    bool showCloseButton = false,
    VoidCallback? onAction,
    String? actionLabel,
    Duration duration = const Duration(seconds: 3),
  }) {
    /// Close previous Alert if exists
    removeCurrent();

    /// Create new overlay entry
    final overlay = OverlayEntry(
      builder: (context) => _AnimatedAlert(
        type: type,
        message: message,
        hasShadow: hasShadow,
        showCloseButton: showCloseButton,
        duration: duration,
        onRemove: removeCurrent,
        title: title,
        onAction: onAction,
        actionLabel: actionLabel,
      ),
    );

    /// Store the current overlay
    _currentOverlay = overlay;

    /// Check that the overlay context is available
    final BuildContext? overlayContext = Get.overlayContext;

    /// If yes, use it to insert the overlay
    if (overlayContext != null) {
      Overlay.of(overlayContext, rootOverlay: true).insert(overlay);
    } else {
      /// if not, try with the main context
      final BuildContext? context = Get.context;
      if (context != null) {
        Overlay.of(context, rootOverlay: true).insert(overlay);
      } else {
        /// If no contexts are available, do not show the Alert
        _currentOverlay = null;
        return;
      }
    }
  }

  /// Method to remove the current overlay if exists
  @override
  void removeCurrent() {
    _currentOverlay?.remove();
    _currentOverlay = null;
  }

  @override
  Future<void> showAlert({
    required Widget child,
    bool isDismissible = false,
  }) async {
    if (!kIsWeb) {
      await showModalBottomSheet(
        context: Get.context!,
        builder: (context) => child,
        isScrollControlled: true,
        isDismissible: isDismissible,
      );
    } else {
      await showDialog(
        barrierDismissible: isDismissible,
        context: Get.context!,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: child,
          ),
        ),
      );
    }
  }
}

class _AnimatedAlert extends StatefulWidget {
  const _AnimatedAlert({
    required this.type,
    required this.message,
    required this.hasShadow,
    required this.showCloseButton,
    required this.duration,
    required this.onRemove,
    this.title,
    this.onAction,
    this.actionLabel,
  });

  final AlertType type;
  final String message;
  final bool hasShadow;
  final String? title;
  final bool showCloseButton;
  final VoidCallback? onAction;
  final String? actionLabel;
  final Duration duration;
  final VoidCallback onRemove;

  @override
  State<_AnimatedAlert> createState() => _AnimatedAlertState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<AlertType>('type', type))
      ..add(StringProperty('message', message))
      ..add(DiagnosticsProperty<bool>('hasShadow', hasShadow))
      ..add(StringProperty('title', title))
      ..add(
        DiagnosticsProperty<bool>('showCloseButton', showCloseButton),
      )
      ..add(ObjectFlagProperty<VoidCallback?>.has('onAction', onAction))
      ..add(StringProperty('actionLabel', actionLabel))
      ..add(DiagnosticsProperty<Duration>('duration', duration))
      ..add(ObjectFlagProperty<VoidCallback>.has('onRemove', onRemove));
  }
}

class _AnimatedAlertState extends State<_AnimatedAlert>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation =
        Tween<Offset>(
          begin: const Offset(0, -1.5),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
          ),
        );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        widget.onRemove();
      }
    });

    unawaited(_controller.forward());

    if (!widget.showCloseButton) {
      Future.delayed(widget.duration, () {
        if (mounted) {
          _dismiss();
        }
      });
    }
  }

  void _dismiss() {
    unawaited(_controller.reverse());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;

    final Widget alertContent = GestureDetector(
      onVerticalDragUpdate: (details) {
        if (details.primaryDelta! < -1) {
          _dismiss();
        }
      },
      child: SlideTransition(
        position: _offsetAnimation,
        child: Material(
          color: Colors.transparent,
          child: CustomAlert(
            type: widget.type,
            hasShadow: widget.hasShadow,
            title: widget.title?.toUpperCase(),
            message: widget.message,
            showCloseButton: widget.showCloseButton,
            onAction: widget.onAction,
            actionLabel: widget.actionLabel,
            onClose: _dismiss,
          ),
        ),
      ),
    );

    if (kIsWeb) {
      final double alertWidth = screenWidth / 2;
      return Positioned(
        top: mediaQuery.padding.top + 10,
        left: (screenWidth - alertWidth) / 2,
        width: alertWidth,
        child: alertContent,
      );
    }
    return Positioned(
      top: mediaQuery.padding.top + 10,
      left: 16,
      right: 16,
      child: alertContent,
    );
  }
}
