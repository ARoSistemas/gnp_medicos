import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DropdownSearchField extends StatelessWidget {
  const DropdownSearchField({
    required this.title,
    required this.hintText,
    required this.items,
    required this.labelKey,
    required this.onChanged,
    super.key,
    this.initialValue,
    this.prefixIcon,
    this.border,
  });
  final String title;
  final String hintText;
  final List<Map<String, dynamic>> items;
  final String labelKey;
  final Map<String, dynamic>? initialValue;
  final void Function(Map<String, dynamic>?) onChanged;

  final Icon? prefixIcon;
  final InputBorder? border;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? selectedItem = initialValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Título
        if (title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),

        /// Campo
        InputDecorator(
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            hintText: hintText,
            border: border,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<Map<String, dynamic>>(
              isExpanded: true,
              value: selectedItem,
              hint: Text(hintText),
              items: items
                  .map(
                    (item) => DropdownMenuItem<Map<String, dynamic>>(
                      value: item,
                      child: Text(item[labelKey] ?? ''),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('title', title))
      ..add(StringProperty('hintText', hintText))
      ..add(IterableProperty<Map<String, dynamic>>('items', items))
      ..add(StringProperty('labelKey', labelKey))
      ..add(
        DiagnosticsProperty<Map<String, dynamic>?>(
          'initialValue',
          initialValue,
        ),
      )
      ..add(
        ObjectFlagProperty<void Function(Map<String, dynamic>? p1)>.has(
          'onChanged',
          onChanged,
        ),
      )
      ..add(DiagnosticsProperty<InputBorder?>('border', border));
  }
}
