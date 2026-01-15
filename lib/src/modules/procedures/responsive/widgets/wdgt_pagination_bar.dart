import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PaginationBar extends StatelessWidget {
  const PaginationBar({
    required this.rangeLabel,
    required this.pageLabel,
    required this.onPrevious,
    required this.onNext,
    super.key,
    this.canGoPrevious = true,
    this.canGoNext = true,
  });
  final String rangeLabel;
  final String pageLabel;

  final VoidCallback onPrevious;
  final VoidCallback onNext;

  final bool canGoPrevious;
  final bool canGoNext;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _Navigation(
          rangeLabel: rangeLabel,
          onPrevious: onPrevious,
          onNext: onNext,
          canGoPrevious: canGoPrevious,
          canGoNext: canGoNext,
        ),
      ],
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('rangeLabel', rangeLabel))
      ..add(StringProperty('pageLabel', pageLabel))
      ..add(
        ObjectFlagProperty<VoidCallback>.has('onPrevious', onPrevious),
      )
      ..add(ObjectFlagProperty<VoidCallback>.has('onNext', onNext))
      ..add(DiagnosticsProperty<bool>('canGoPrevious', canGoPrevious))
      ..add(DiagnosticsProperty<bool>('canGoNext', canGoNext));
  }
}

class _RangeText extends StatelessWidget {
  const _RangeText({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      fontSize: 16,
      color: Color(0xFF5E6E8C),
      fontWeight: FontWeight.w500,
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('text', text));
  }
}

class _Navigation extends StatelessWidget {
  const _Navigation({
    required this.rangeLabel,
    required this.onPrevious,
    required this.onNext,
    required this.canGoPrevious,
    required this.canGoNext,
  });
  final String rangeLabel;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final bool canGoPrevious;
  final bool canGoNext;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      /// Previous button
      _NavButton(
        icon: Icons.chevron_left,
        enabled: canGoPrevious,
        onTap: onPrevious,
      ),
      const SizedBox(width: 8),

      /// Page label
      _RangeText(text: rangeLabel),
      const SizedBox(width: 8),

      /// Next button
      _NavButton(
        icon: Icons.chevron_right,
        enabled: canGoNext,
        onTap: onNext,
      ),
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('rangeLabel', rangeLabel))
      ..add(
        ObjectFlagProperty<VoidCallback>.has('onPrevious', onPrevious),
      )
      ..add(ObjectFlagProperty<VoidCallback>.has('onNext', onNext))
      ..add(DiagnosticsProperty<bool>('canGoPrevious', canGoPrevious))
      ..add(DiagnosticsProperty<bool>('canGoNext', canGoNext));
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: enabled ? onTap : null,
    child: Icon(
      icon,
      size: 28,
      color: enabled ? Colors.orange : Colors.grey.shade400,
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<IconData>('icon', icon))
      ..add(DiagnosticsProperty<bool>('enabled', enabled))
      ..add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap));
  }
}
