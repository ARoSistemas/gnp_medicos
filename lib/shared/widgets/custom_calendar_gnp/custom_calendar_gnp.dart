import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicos/shared/widgets/custom_calendar_gnp/calendar_desktop_layout.dart';
import 'package:medicos/shared/widgets/custom_calendar_gnp/calendar_gnp_controller.dart';
import 'package:medicos/shared/widgets/custom_calendar_gnp/calendar_mobile_layout.dart';

class CustomCalendarGNP extends StatefulWidget {
  const CustomCalendarGNP({required this.bgChips, super.key});

  final Color bgChips;

  static Future<String> open(
    BuildContext context, {
    required Color bgChips,
  }) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 900;

    if (isDesktop) {
      return _openDesktop(context, bgChips: bgChips);
    } else {
      return _openMobile(context, bgChips: bgChips);
    }
  }

  static Future<String> _openDesktop(
    BuildContext context, {
    required Color bgChips,
  }) async {
    final String? result = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.all(24),
        child: SizedBox(
          width: 600,
          height: 500,
          child: CustomCalendarGNP(bgChips: bgChips),
        ),
      ),
    );
    return result ?? '';
  }

  static Future<String> _openMobile(
    BuildContext context, {
    required Color bgChips,
  }) async {
    final String? result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => CustomCalendarGNP(bgChips: bgChips),
      ),
    );

    return result ?? '';
  }

  @override
  State<CustomCalendarGNP> createState() => _CustomCalendarGNPState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('bgChips', bgChips));
  }
}

class _CustomCalendarGNPState extends State<CustomCalendarGNP> {
  final controller = CalendarGNPController();
  final DateFormat _fmt = DateFormat('yyyy-MM-dd');

  bool get _isDesktop => MediaQuery.of(context).size.width >= 900;

  void _backWithResults() {
    final result =
        '${_fmt.format(controller.range.first!)},'
        '${_fmt.format(controller.range.last!)}';
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) => PopScope(
    canPop: false,
    onPopInvokedWithResult: (didPop, result) {
      if (!didPop) {
        Navigator.pop(context, '');
      }
    },
    child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !_isDesktop,
        leading: _isDesktop
            ? null
            : IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context, ''),
              ),
        title: Row(
          mainAxisAlignment: _isDesktop
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: const [Text('Periodo')],
        ),
      ),
      body: _isDesktop
          ? CalendarDesktopLayout(
              controller: controller,
              onApply: _backWithResults,
              onCancelar: () => Navigator.pop(context, ''),
            )
          : CalendarMobileLayout(
              controller: controller,
              bgChips: widget.bgChips,
              onApply: _backWithResults,
              onCancelar: () => Navigator.pop(context, ''),
            ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<CalendarGNPController>('controller', controller),
    );
  }
}
