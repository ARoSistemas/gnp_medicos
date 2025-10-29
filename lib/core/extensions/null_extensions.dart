
extension IntNullExtension on int? {
  int value([int defaultValue = 0]) => this ?? defaultValue;
}

extension StringNullExtension on String? {
  String value([String defaultValue = '']) => this ?? defaultValue;

  String valueEmpty(String defaultValue) {
    final str = this;
    if (str == null || str.isEmpty || str.trim() == '-') {
      return defaultValue;
    }
    return str;
  }
}

extension NullExtensions on num? {
  num value([num defaultValue = 0.0]) => this ?? defaultValue;
}

extension DoubleExtension on double? {
  double value([double defaultValue = 0.0]) => this ?? defaultValue;
}

extension BoolNullExtension on bool? {
  bool value({bool defaultValue = false}) => this ?? defaultValue;
}

extension ListExts on List {
  dynamic get firstOrNull {
    if (isEmpty) {
      return null;
    }
    return first;
  }
}
