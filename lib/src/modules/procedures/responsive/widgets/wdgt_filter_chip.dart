import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

class FilterChipTag extends StatelessWidget {
  const FilterChipTag({
    required this.label,
    required this.onRemove,
    super.key,
  });
  final String label;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: ColorPalette.chips,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.10),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),

        if(label.toLowerCase().contains('fecha')) 
          const Icon(
            Icons.arrow_drop_down_outlined,
            size: 20,
            color: Colors.white,
          ),

        const SizedBox(width: 12),

        // Ícono dentro de un círculo blanco
        GestureDetector(
          onTap: onRemove,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.close,
              size: 18,
              color: Color(0xFF2F55A4),
            ),
          ),
        ),
      ],
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('label', label))
      ..add(ObjectFlagProperty<VoidCallback>.has('onRemove', onRemove));
  }
}
