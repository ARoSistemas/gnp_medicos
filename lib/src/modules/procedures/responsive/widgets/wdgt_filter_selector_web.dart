import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';

class FilterSelectorWeb extends StatefulWidget {
  const FilterSelectorWeb({
    required this.options,
    required this.onSelected,
    required this.isOpen,
    super.key,
    this.onClear,
  });
  
  final List<String> options;
  final ValueChanged<String> onSelected;
  final VoidCallback? onClear;
  final bool isOpen;

  @override
  State<FilterSelectorWeb> createState() => _FilterSelectorWebState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<String>('options', options))
      ..add(
        ObjectFlagProperty<ValueChanged<String>>.has('onSelected', onSelected),
      )
      ..add(ObjectFlagProperty<VoidCallback?>.has('onClear', onClear))
      ..add(DiagnosticsProperty<bool>('isOpen', isOpen));
  }
}

class _FilterSelectorWebState extends State<FilterSelectorWeb> {
  String? _selectedOption;

  void _selectOption(String value) {
    setState(() {
      _selectedOption = value;
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedOption = null;
    });
    widget.onClear?.call();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _selectedOption = null;
      });
    });
  }

  @override
  void didUpdateWidget(FilterSelectorWeb oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen && !oldWidget.isOpen) {
      setState(() {
        _selectedOption = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double targetHeight = context.pHeight(64);
    final double targetWidth = context.pWidth(25);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      curve: Curves.easeInOut,
      clipBehavior: Clip.hardEdge,
      height: widget.isOpen ? targetHeight : 0,
      width: widget.isOpen ? targetWidth : 0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: widget.isOpen
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ]
            : [],
        // borderRadius: BorderRadius.circular(12),
      ),
      child: widget.isOpen
          ? Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  width: targetWidth,
                  height: targetHeight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 16),
                        Expanded(
                          child: SingleChildScrollView(
                            child: _FilterList(
                              options: widget.options,
                              selectedOption: _selectedOption,
                              onTap: _selectOption,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _ApplyButton(
                          enabled: _selectedOption != null,
                          onPressed: () {
                            widget.onSelected(_selectedOption!);
                          },
                        ),
                        const SizedBox(height: 12),
                        _ClearButton(
                          onPressed: _clearSelection,
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}

class _FilterList extends StatelessWidget {
  const _FilterList({
    required this.options,
    required this.selectedOption,
    required this.onTap,
  });
  final List<String> options;
  final String? selectedOption;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) => Column(
    children: options.map((option) {
      final isSelected = option == selectedOption;
      return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: isSelected ? Colors.orange : Colors.black54,
        ),
        title: Text(
          option,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        onTap: () => onTap(option),
      );
    }).toList(),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<String>('options', options))
      ..add(StringProperty('selectedOption', selectedOption))
      ..add(
        ObjectFlagProperty<ValueChanged<String>>.has('onTap', onTap),
      );
  }
}

class _ApplyButton extends StatelessWidget {
  const _ApplyButton({
    required this.enabled,
    required this.onPressed,
  });
  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.orange,
      disabledBackgroundColor: Colors.orange.withValues(alpha: 0.4),
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    onPressed: enabled ? onPressed : null,
    child: const Text(
      'Aplicar',
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<bool>('enabled', enabled))
      ..add(
        ObjectFlagProperty<VoidCallback>.has('onPressed', onPressed),
      );
  }
}

class _ClearButton extends StatelessWidget {
  const _ClearButton({required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: onPressed,
    child: const Text(
      'Quitar filtros',
      style: TextStyle(
        fontSize: 14,
        color: Colors.orange,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      ObjectFlagProperty<VoidCallback>.has('onPressed', onPressed),
    );
  }
}
