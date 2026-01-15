import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({
    required this.onOptionSelected,
    required this.options,
    super.key,
  });
  final Function(String selectedOption) onOptionSelected;
  final List<String> options;

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(
      ObjectFlagProperty<Function(String selectedOption)>.has(
        'onOptionSelected',
        onOptionSelected,
      ),
    )
    ..add(IterableProperty<String>('options', options));
  }
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? _selectedOption;

  Future<void> _onApply() async {
    if (_selectedOption == null) {
      return;
    }
    Navigator.pop(context);
    widget.onOptionSelected(_selectedOption!);
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Close button
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: const Icon(
                Icons.close,
                color: ColorPalette.primary,
              ),
              color: const Color(0xFF1F2A44),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),

        /// Título
        const Center(
          child: Text(
            'Filtrar trámites por:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1F2A44),
            ),
          ),
        ),
        const SizedBox(height: 20),

        /// Filtros (opciones)
        RadioGroup<String>(
          groupValue: _selectedOption,
          onChanged: (value) {
            setState(() {
              _selectedOption = value;
            });
          },
          child: Column(
            children: widget.options
                .map(
                  (opt) => RadioListTile<String>(
                    value: opt,
                    title: Text(
                      opt,
                      style: const TextStyle(
                        color: Color(0xFF1F2A44),
                        fontSize: 16,
                      ),
                    ),
                    activeColor: const Color(0xFFF3791A),
                    contentPadding: EdgeInsets.zero,
                  ),
                )
                .toList(),
          ),
        ),

        const SizedBox(height: 24),

        /// Botón aplicar
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _onApply,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorPalette.primary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Aplicar',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 25),
      ],
    ),
  );
}
