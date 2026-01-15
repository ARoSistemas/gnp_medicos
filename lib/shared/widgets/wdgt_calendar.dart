import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

/// Service to handle calendar date range picking
/// If a date range is selected, `pickedRange` will contain the selected dates;
/// otherwise, it will be null.
class CalendarService {
  CalendarService._();

  static final CalendarService instance = CalendarService._();

  Future<DateTimeRange?> pickDateRange({
    required BuildContext context,
  }) {
    final now = DateTime.now();

    return showDateRangePicker(
      context: context,
      locale: const Locale('es', 'MX'),
      firstDate: DateTime(now.year - 50),
      lastDate: now,
      currentDate: now,
      initialDateRange: DateTimeRange(
        start: now,
        end: now,
      ),
      builder: (context, child) {
        final ThemeData base = Theme.of(context);
        final Widget content = Theme(
          data: ThemeData(
            useMaterial3: false,
            colorScheme: base.colorScheme.copyWith(
              primary: ColorPalette.primary,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black87,
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
          ),
          child: child!,
        );

        if (kIsWeb) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              size: const Size(1200, 800),
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                  maxHeight: 520,
                ),
                child: content,
              ),
            ),
          );
        }

        return content;
      },
    );
  }

  ///
}
