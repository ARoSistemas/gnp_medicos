import 'package:flutter/foundation.dart';

/// Central calendar's controller
/// Admin: 
/// - Range selected 
/// - Visible month
/// - Chips (today, week, month, year, custom)
/// - Navigation's rules 
class CalendarGNPController extends ChangeNotifier {
  CalendarGNPController() {
    _init();
  }

  /// Range selected by the user
  List<DateTime?> _range = [];

  /// Month selected by the user
  late DateTime _visibleMonth;

  /// Chip active
  String _activeChip = 'today';

  /// If calendar is in custom mode
  bool _customEnabled = false;

  /// getters
  List<DateTime?> get range => _range;
  DateTime get visibleMonth => _visibleMonth;
  String get activeChip => _activeChip;
  bool get customEnabled => _customEnabled;

  /// Range valid (Start and end defined)
  bool get isValidRange =>
      _range.length == 2 && _range.first != null && _range.last != null;

  /// Init
  void _init() {
    final now = DateTime.now();
    _visibleMonth = DateTime(now.year, now.month);
    selectToday(notify: false);
  }

  /// Range update
  void updateRange(List<DateTime?> value) {
    _range = value;
    notifyListeners();
  }

  /// Month visibility update
  void setVisibleMonth(DateTime date) {
    _visibleMonth = DateTime(date.year, date.month);
    notifyListeners();
  }

  /// Chip selection update
  void _setChip(String chip, {bool custom = false}) {
    _activeChip = chip;
    _customEnabled = custom;
    notifyListeners();
  }

  /// Day navigatons rules
  void selectToday({bool notify = true}) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    _range = [today, today];
    _visibleMonth = DateTime(now.year, now.month);
    _activeChip = 'today';
    _customEnabled = false;

    if (notify) {
      notifyListeners();
    }
  }

  /// Week navigations rules
  void selectWeek() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    /// Monday as a first day of the week
    final DateTime startOfWeek = today.subtract(
      Duration(days: today.weekday - DateTime.monday),
    );

    _range = [startOfWeek, today];
    _visibleMonth = DateTime(today.year, today.month);
    _setChip('week');
  }

  /// Month navigations rules
  void selectMonth() {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month);
     final today = DateTime(now.year, now.month, now.day);
    // final end = DateTime(now.year, now.month + 1, 0);

    _range = [start, today];
    _visibleMonth = DateTime(now.year, now.month);
    _setChip('month');
  }

  /// Year navigations rules
  void selectYear() {
    final now = DateTime.now();
    final start = DateTime(now.year);
    final end = DateTime(now.year, now.month, now.day);

    _range = [start, end];
    _visibleMonth = DateTime(now.year, now.month);
    _setChip('year');
  }

  /// Custom navigations rules
  void selectCustom() {
     selectToday(notify: false);
    _setChip('custom', custom: true);
  }

  /// Year navigations rules
  bool canGoBackYear({int maxYearsBack = 10}) {
    final int minYear = DateTime.now().year - maxYearsBack;
    return _visibleMonth.year > minYear;
  }

  /// Year navigations rules
  bool canGoForwardYear() {
    final now = DateTime.now();
    return _visibleMonth.year < now.year ||
        (_visibleMonth.year == now.year && _visibleMonth.month < now.month);
  }

  /// Year actions (Desktop dropdown)
  void previousYear({int maxYearsBack = 10}) {
    if (!canGoBackYear(maxYearsBack: maxYearsBack)) {
      return;
    }

    setVisibleMonth(
      DateTime(_visibleMonth.year - 1, _visibleMonth.month),
    );
  }

  /// Year actions (Desktop dropdown)
  void nextYear() {
    if (!canGoForwardYear()) {
      return;
    }

    setVisibleMonth(
      DateTime(_visibleMonth.year + 1, _visibleMonth.month),
    );
  }

  /// Month navigations rules
  void changeMonth(int monthIndex) {
    setVisibleMonth(
      DateTime(_visibleMonth.year, monthIndex + 1),
    );
  }

  /// Reset
  void reset() {
    _init();
    notifyListeners();
  }
}
