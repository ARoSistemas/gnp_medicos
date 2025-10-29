import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medicos/core/extensions/font_size_extension.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

class MedicosDropdown extends StatelessWidget {
  const MedicosDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    super.key
  });

  final String label;
  final String? value;
  final List<DropdownMenuItem<String>>? items;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Documentos',
        style: TextStyle(
          fontSize: context.fontSize(12),
          fontWeight: FontWeight.w500,
          color: ColorPalette.textPrimary
        ),
      ),
      DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ColorPalette.textField,
            ),
          ),
        ),
        child: DropdownButton(
          isExpanded: true,
          underline: const SizedBox(),
          style: TextStyle(
            color: ColorPalette.textSecondary,
            fontWeight: FontWeight.w400,
            fontSize: context.fontSize(16)
          ),
          value: value,
          items: items,
          onChanged: onChanged
        ),
      ),
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(StringProperty('label', label))
    ..add(StringProperty('value', value))
    ..add(ObjectFlagProperty<Function(String p1)?>.has('onChaned', onChanged));
  }
}
