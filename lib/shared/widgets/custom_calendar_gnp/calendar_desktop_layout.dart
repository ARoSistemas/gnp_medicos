import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicos/shared/widgets/custom_calendar_gnp/calendar_gnp_controller.dart';

class CalendarDesktopLayout extends StatelessWidget {
  const CalendarDesktopLayout({
    required this.controller,
    required this.onApply,
    required this.onCancelar,
    super.key,
  });

  final CalendarGNPController controller;
  final VoidCallback onApply;
  final VoidCallback onCancelar;

  String _capitalizeMonth(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: controller,
    builder: (_, _) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Title
        const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Text(
            'Selecciona una opción o fecha',
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),

        /// Content
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _leftPanel(),
            const VerticalDivider(width: 1, color: Colors.transparent),
            Expanded(child: _calendarPanel()),
          ],
        ),

        /// Actions
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: controller.isValidRange ? onApply : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(94, 40),
                  fixedSize: const Size(94, 40),
                  padding: EdgeInsets.zero,
                ),
                child: const Text('Aplicar'),
              ),
              TextButton(
                onPressed: onCancelar,
                style: TextButton.styleFrom(
                  minimumSize: const Size(94, 40),
                  fixedSize: const Size(94, 40),
                  padding: EdgeInsets.zero,
                ),
                child: const Text('Cancelar'),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  /// Left panel
  Widget _leftPanel() => SizedBox(
    width: 260,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: RadioGroup<String>(
        groupValue: controller.activeChip,
        onChanged: (value) {
          if (value == null) {
            return;
          }
          _handleSelection(value);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _radio('Hoy', 'today'),
            _radio('Esta semana', 'week'),
            _radio('Este mes', 'month'),
            _radio('Este año', 'year'),
            _radio('Personalizado', 'custom'),
          ],
        ),
      ),
    ),
  );

  /// Options radio buttons
  Widget _radio(String label, String value) => RadioListTile<String>(
    value: value,
    title: Text(label),
    dense: true,
    contentPadding: EdgeInsets.zero,
  );

  void _handleSelection(String value) {
    switch (value) {
      case 'today':
        controller.selectToday();
      case 'week':
        controller.selectWeek();
      case 'month':
        controller.selectMonth();
      case 'year':
        controller.selectYear();
      case 'custom':
        controller.selectCustom();
    }
  }

  /// Rigth panel
  Widget _calendarPanel() => Column(
    children: [
      _header(),
      const SizedBox(height: 16),
      _calendar(),
    ],
  );

  /// Header panel
  Widget _header() => IgnorePointer(
    ignoring: !controller.customEnabled,
    child: Row(
      children: [
        _monthDropdown(),
        const SizedBox(width: 8),
        _yearSelector(),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: controller.canGoBackYear()
              ? controller.previousYear
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: controller.canGoForwardYear() ? controller.nextYear : null,
        ),
      ],
    ),
  );

  /// Month selector
  Widget _monthDropdown() {
    final int currentMonthIndex = controller.visibleMonth.month - 1;
    return DropdownButtonHideUnderline(
      child: DropdownButton<int>(
        dropdownColor: Colors.white,
        value: currentMonthIndex,
        underline: const SizedBox(),
        icon: const Icon(Icons.keyboard_arrow_down),
        onChanged: (value) {
          if (value == null) {
            return;
          }
          controller.changeMonth(value);
        },
        items: List.generate(12, (index) {
          final String month = DateFormat.MMMM(
            'es',
          ).format(DateTime(2020, index + 1));
          return DropdownMenuItem(
            value: index,
            child: Text(
              _capitalizeMonth(month),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          );
        }),
      ),
    );
  }

  /// Year selector
  Widget _yearSelector() => Text(
    controller.visibleMonth.year.toString(),
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  );

  /// Calendar panel
  Widget _calendar() => IgnorePointer(
    ignoring: !controller.customEnabled,
    child: ClipRect(
      child: Align(
        alignment: Alignment.bottomCenter,
        heightFactor: 0.83,
        child: CalendarDatePicker2(
          displayedMonthDate: controller.visibleMonth,
          value: controller.range,
          onValueChanged: controller.updateRange,
          config: CalendarDatePicker2Config(
            calendarType: CalendarDatePicker2Type.range,
            firstDayOfWeek: 1,
            selectedDayHighlightColor: Colors.orange,
          ),
        ),
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<CalendarGNPController>('controller', controller),
      )
      ..add(ObjectFlagProperty<VoidCallback>.has('onApply', onApply))
      ..add(
        ObjectFlagProperty<VoidCallback>.has('onCancelar', onCancelar),
      );
  }
}
