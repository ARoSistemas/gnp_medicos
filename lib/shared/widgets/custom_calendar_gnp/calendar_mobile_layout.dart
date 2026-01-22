import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicos/shared/widgets/custom_calendar_gnp/calendar_gnp_controller.dart';

class CalendarMobileLayout extends StatelessWidget {
  CalendarMobileLayout({
    required this.controller,
    required this.onApply,
    required this.onCancelar,
    required this.bgChips,
    super.key,
  });

  final CalendarGNPController controller;
  final VoidCallback onApply;
  final VoidCallback onCancelar;
  final Color bgChips;

  final DateFormat _monthFmt = DateFormat.MMMM('es');

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: controller,
    builder: (_, _) => Column(
      children: [
        _chips(),
        _header(context),
        const SizedBox(height: 8),
        _calendar(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: controller.isValidRange ? onApply : null,
            child: const Text('Aplicar'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextButton(
            onPressed: onCancelar,
            child: const Text('Cancelar'),
          ),
        ),
      ],
    ),
  );

  /// Header Chips
  Widget _chips() => Padding(
    padding: const EdgeInsets.all(12),
    child: Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _chip('Hoy', 'today', controller.selectToday),
        _chip('Esta semana', 'week', controller.selectWeek),
        _chip('Este mes', 'month', controller.selectMonth),
        _chip('Este año', 'year', controller.selectYear),
        _chip('Personalizado', 'custom', controller.selectCustom),
      ],
    ),
  );

  /// Chips
  Widget _chip(String label, String key, VoidCallback onTap) => ChoiceChip(
    label: Text(
      label,
      style: TextStyle(
        color: controller.activeChip == key ? Colors.white : bgChips,
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
      side:   BorderSide(color: bgChips.withValues(alpha: 0.15)),
      // side: const BorderSide(color: Color(0xFFD4E1F7)),
    ),
    selectedColor: bgChips,
    selected: controller.activeChip == key,
    showCheckmark: false,
    onSelected: (_) => onTap(),
  );

  /// Header
  Widget _header(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: IgnorePointer(
      ignoring: !controller.customEnabled,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _monthSelector(context),
          _yearSelector(context),
        ],
      ),
    ),
  );

  /// Month selector (dropdown + arrows)
  Widget _monthSelector(BuildContext context) {
    final int currentMonthIndex = controller.visibleMonth.month - 1;

    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => controller.setVisibleMonth(
            DateTime(
              controller.visibleMonth.year,
              controller.visibleMonth.month - 1,
            ),
          ),
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            value: currentMonthIndex,
            icon: const Icon(Icons.keyboard_arrow_down),
            onChanged: (value) {
              if (value == null) {
                return;
              }
              controller.changeMonth(value);
            },
            items: List.generate(12, (index) {
              final String month = _capitalize(
                _monthFmt.format(DateTime(2020, index + 1)),
              );
              return DropdownMenuItem(
                value: index,
                child: Text(
                  month,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              );
            }),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () => controller.setVisibleMonth(
            DateTime(
              controller.visibleMonth.year,
              controller.visibleMonth.month + 1,
            ),
          ),
        ),
      ],
    );
  }

  /// Year selector (dropdown + arrows)
  Widget _yearSelector(BuildContext context) {
    final int currentYear = controller.visibleMonth.year;
    final int nowYear = DateTime.now().year;

    final List<int> years = List.generate(
      6,
      (i) => nowYear - i,
    );

    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: controller.canGoBackYear(maxYearsBack: 5)
              ? () => controller.previousYear(maxYearsBack: 5)
              : null,
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            value: currentYear,
            icon: const Icon(Icons.keyboard_arrow_down),
            onChanged: (value) {
              if (value == null) {
                return;
              }
              controller.setVisibleMonth(
                DateTime(
                  value,
                  controller.visibleMonth.month,
                ),
              );
            },
            items: years
                .map(
                  (year) => DropdownMenuItem(
                    value: year,
                    child: Text(
                      year.toString(),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: controller.canGoForwardYear() ? controller.nextYear : null,
        ),
      ],
    );
  }

  /// Calendar
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

  String _capitalize(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }

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
      )
      ..add(ColorProperty('bgChips', bgChips));
  }
}

// import 'package:calendar_date_picker2/calendar_date_picker2.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:medicos/shared/widgets/custom_calendar_gnp/calendar_gnp_controller.dart';

// class CalendarMobileLayout extends StatelessWidget {
//   CalendarMobileLayout({
//     required this.controller,
//     required this.onApply,
//     required this.onCancelar,
//     super.key,
//   });

//   final CalendarGNPController controller;
//   final VoidCallback onApply;
//   final VoidCallback onCancelar;

//   final DateFormat _monthFmt = DateFormat.MMM('es');

//   @override
//   Widget build(BuildContext context) => AnimatedBuilder(
//     animation: controller,
//     builder: (_, _) => Column(
//       children: [
//         _chips(),
//         _header(),
//         const SizedBox(height: 8),
//         _calendar(),
//         Padding(
//           padding: const EdgeInsets.all(16),
//           child: ElevatedButton(
//             onPressed: controller.isValidRange ? onApply : null,
//             child: const Text('Aplicar'),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: TextButton(
//             onPressed: onCancelar,
//             child: const Text('Cancelar'),
//           ),
//         ),
//       ],
//     ),
//   );

//   Widget _chips() => Padding(
//     padding: const EdgeInsets.all(12),
//     child: Wrap(
//       spacing: 10,
//       runSpacing: 10,
//       children: [
//         _chip('Hoy', 'today', controller.selectToday),
//         _chip('Esta semana', 'week', controller.selectWeek),
//         _chip('Este mes', 'month', controller.selectMonth),
//         _chip('Este año', 'year', controller.selectYear),
//         _chip('Personalizado', 'custom', controller.selectCustom),
//       ],
//     ),
//   );

//   Widget _chip(String label, String key, VoidCallback onTap) => ChoiceChip(
//     label: Text(label),
//     selected: controller.activeChip == key,
//     showCheckmark: false,
//     onSelected: (_) => onTap(),
//   );

//   Widget _header() => Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 16),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         _monthSelector(),
//         _yearSelector(),
//       ],
//     ),
//   );

//   Widget _monthSelector() => Row(
//     children: [
//       IconButton(
//         icon: const Icon(Icons.chevron_left),
//         onPressed: () => controller.setVisibleMonth(
//           DateTime(
//             controller.visibleMonth.year,
//             controller.visibleMonth.month - 1,
//           ),
//         ),
//       ),
//       Text(
//         _monthFmt.format(controller.visibleMonth).toUpperCase(),
//         style: const TextStyle(fontWeight: FontWeight.w600),
//       ),
//       IconButton(
//         icon: const Icon(Icons.chevron_right),
//         onPressed: () => controller.setVisibleMonth(
//           DateTime(
//             controller.visibleMonth.year,
//             controller.visibleMonth.month + 1,
//           ),
//         ),
//       ),
//     ],
//   );

//   Widget _yearSelector() => Row(
//     children: [
//       IconButton(
//         icon: const Icon(Icons.chevron_left),
//         onPressed: () => controller.setVisibleMonth(
//           DateTime(
//             controller.visibleMonth.year - 1,
//             controller.visibleMonth.month,
//           ),
//         ),
//       ),
//       Text(
//         controller.visibleMonth.year.toString(),
//         style: const TextStyle(fontWeight: FontWeight.w600),
//       ),
//       IconButton(
//         icon: const Icon(Icons.chevron_right),
//         onPressed: () => controller.setVisibleMonth(
//           DateTime(
//             controller.visibleMonth.year + 1,
//             controller.visibleMonth.month,
//           ),
//         ),
//       ),
//     ],
//   );

//   Widget _calendar() => IgnorePointer(
//     ignoring: !controller.customEnabled,
//     child: Opacity(
//       opacity: controller.customEnabled ? 1 : 0.5,
//       child: ClipRect(
//         child: Align(
//           alignment: Alignment.bottomCenter,
//           heightFactor: 0.83,
//           child: CalendarDatePicker2(
//             displayedMonthDate: controller.visibleMonth,
//             value: controller.range,
//             onValueChanged: controller.updateRange,
//             config: CalendarDatePicker2Config(
//               calendarType: CalendarDatePicker2Type.range,
//               firstDayOfWeek: 1,
//               selectedDayHighlightColor: Colors.orange,
//             ),
//           ),
//         ),
//       ),
//     ),
//   );

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties
//       ..add(
//         DiagnosticsProperty<CalendarGNPController>('controller', controller),
//       )
//       ..add(ObjectFlagProperty<VoidCallback>.has('onApply', onApply))
//       ..add(
//         ObjectFlagProperty<VoidCallback>.has('onCancelar', onCancelar),
//       );
//   }
// }
