import 'package:get/get.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    ...esMessages.mx.key,
    //...enMessages.us.key,
  };
}

class LanguageCodes {
  static const String es = 'es';
  static const String en = 'en';
}

class CountryCodes {
  static const String mx = 'MX';
  static const String us = 'US';
}
