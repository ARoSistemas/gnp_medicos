import 'dart:ui';

import 'package:get/get.dart';
import 'package:medicos/core/utils/logger.dart';

abstract class IMessages {
  const IMessages();

  abstract final Locale locale;

  String get localeStr => '${locale.languageCode}_${locale.countryCode}';

  Map<String, Map<String, String>> get key => {localeStr: toJson()};

  /// Map of all messages for must be returned in this json.
  /// Example: toJson() => {...property1.msgMap, ...property2.msgMap, ...}
  Map<String, String> toJson();
}

class MsgProperty {
  MsgProperty({
    required this.key,
    required this.value,
    this.pValue,
    this.eValue,
  }) : pKey = '${key}P',
       eKey = '${key}E' {
    _valueMatchesLength = _matches(value).toSet().length;
    _pValueMatchesLength = pValue != null
        ? _matches(pValue!).toSet().length
        : 0;
  }

  // For empty or zero value
  final String eKey;
  final String? eValue;

  // For singular (mandatory)
  final String key;
  final String value;

  // For plural
  final String pKey;
  final String? pValue;

  late final int _valueMatchesLength;
  late final int _pValueMatchesLength;

  static final _regexMsgMatches = RegExp(r'@\d+(?!\d)');
  static const _className = 'MsgProperty';

  MsgProperty copyWith({
    required String value,
    String? pValue,
    String? eValue,
  }) {
    if (this.eValue != null && eValue == null) {
      logger.w('''
Value: $value 
$_className.copyWith: emptyValue must not be null
''');
    }
    return MsgProperty(
      key: key,
      value: value,
      pValue: pValue,
      eValue: eValue,
    );
  }

  Map<String, String> get msgMap {
    final Map<String, String> v = {key: value};
    if (pValue != null) {
      v[pKey] = pValue!;
    }
    if (eValue != null) {
      v[eKey] = eValue!;
    }

    return v;
  }

  Map<String, String> _paramsMap(List<String> args) {
    final map = <String, String>{};
    for (var i = 0; i < args.length; i++) {
      map[i.toString()] = args[i];
    }

    return map;
  }

  String tr({
    int i = 1,
    List<String> args = const [],
    List<String>? eArgs,
  }) {
    if (args.length < _valueMatchesLength) {
      logger.w('$_className.tr: args.length is lower than _valueMatchesLength');
    }
    if (i > 1 && args.length < _pValueMatchesLength) {
      logger.w(
        '$_className.tr: pArgs.length is lower than _pValueMatchesLength',
      );
    }
    final Map<String, String> p = _paramsMap(args);
    final Map<String, String>? eP = eArgs != null ? _paramsMap(eArgs) : null;

    final bool existsEmpty = i == 0 && eValue != null;
    return existsEmpty
        ? eKey.trParams(eP ?? p)
        : key.trPluralParams(pKey, i, p);
  }

  Iterable _matches(String txt) => _regexMsgMatches
      .allMatches(txt)
      .map(
        (m) => m.group(0),
      );
}
