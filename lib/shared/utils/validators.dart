import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/shared/constans/constans.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';

class Validators {
  static RegExp validString = RegExp(regexNames, unicode: true);

  static String? _validOnlyAlphabeticCharacters(String? value) {
    if (!validString.hasMatch(value!)) {
      return esMessages.mx.onlyAlphabeticCharacters.value;
    }
    return null;
  }

  static String? name(String? value) {
    if (value.value().trim().isEmpty) {
      return esMessages.mx.enterYourNameContinue.value;
    }
    return _validOnlyAlphabeticCharacters(value);
  }

  static String? lastName(String? value) {
    if (value.value().trim().isEmpty) {
      return esMessages.mx.enterYourLastNameContinue.value;
    }
    return _validOnlyAlphabeticCharacters(value);
  }

  static String? secondLastName(String? value) {
    if (value.value().trim().isEmpty) {
      return esMessages.mx.enterYourLastNameContinue.value;
    }
    return _validOnlyAlphabeticCharacters(value);
  }

  static bool isValidEmail(String email) => RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  ).hasMatch(email);

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return esMessages.mx.enterYourEmail.value;
    }
    if (!isValidEmail(value)) {
      return esMessages.mx.enterYourEmail.value;
    }
    return null;
  }

  static String? password(String? password) {
    if (password!.isEmpty) {
      return esMessages.mx.enterYourPassword.value;
    }
    return null;
  }

  static bool isValidPhone(String phone) {
    // Validar número mexicano de 10 dígitos
    final String cleanPhone = phone.replaceAll(RegExp('[^0-9]'), '');
    return cleanPhone.length == 10 &&
        RegExp(r'^[0-9]{10}$').hasMatch(cleanPhone);
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return esMessages.mx.enterYourPhoneNumber.value;
    }
    if (!isValidPhone(value)) {
      return esMessages.mx.enterTenDigits.value;
    }
    return null;
  }

  static String? option(String? value) {
    if (value == null || value.isEmpty) {
      return esMessages.mx.enterYourOption.value;
    }
    return null;
  }

  static String? date(String? value) {
    if (value == null || value.isEmpty) {
      return esMessages.mx.enterYourDate.value;
    }
    return null;
  }

  static String? rfc(String? value) {
    if (value == null || value.isEmpty) {
      return esMessages.mx.enterYourRfc.value;
    }

    final String rfcLimpio = value
        .trim()
        .toUpperCase()
        .replaceAll('-', '')
        .replaceAll(' ', '');

    if (rfcLimpio.length != 12 && rfcLimpio.length != 13) {
      return esMessages.mx.rfcDigitsTwelveThirteen.value;
    }

    final RegExp rfcRegExp = RegExp(r'^([A-ZÑ&]{3,4})\d{6}([A-Z\d]{3})$');

    if (!rfcRegExp.hasMatch(rfcLimpio)) {
      return esMessages.mx.rfcFormatInvalid.value;
    }

    if (rfcLimpio.startsWith('XAXX')) {
      return esMessages.mx.rfcGenericNoAllowed.value;
    }

    return null;
  }

  static String generateRfcBase(
    String name,
    String lastName,
    String secondLastName,
  ) {
    String cleanName;
    String cleanLastName;
    String cleanSecondLastName;

    cleanName = _cleanNames(name.trim().toUpperCase());
    cleanLastName = _cleanNames(lastName.trim().toUpperCase());
    cleanSecondLastName = _cleanNames(secondLastName.trim().toUpperCase());

    // Primera letra del apellido paterno
    final String l1 = cleanLastName.isNotEmpty ? cleanLastName[0] : '';

    // Primera vocal interna del apellido paterno
    String l2 = '';
    for (int i = 1; i < cleanLastName.length; i++) {
      if ('AEIOU'.contains(cleanLastName[i])) {
        l2 = cleanLastName[i];
        break;
      }
    }

    // Primera letra del apellido materno
    final String l3 = cleanSecondLastName.isNotEmpty
        ? cleanSecondLastName[0]
        : '';

    // Primera letra del nombre
    final String l4 = cleanName.isNotEmpty ? cleanName[0] : '';

    return l1 + l2 + l3 + l4;
  }

  static String? rfcName({
    required String name,
    required String lastName,
    required String secondLastName,
    required String rfc,
  }) {
    final String rfcBase = generateRfcBase(
      name,
      lastName,
      secondLastName,
    );

    final String rfcClean = rfc.trim().toUpperCase();
    if (!rfcClean.startsWith(rfcBase)) {
      return esMessages.mx.enterYourRfcName.value;
    }
    return null;
  }

  static String _cleanNames(String s) {
    const List<String> articulos = [
      'DE',
      'LA',
      'LAS',
      'LOS',
      'DEL',
      'Y',
      'A',
    ];
    final List<String> parts = s.split(' ');
    if (parts.length > 1 && articulos.contains(parts[0])) {
      return parts.sublist(1).join(' ');
    }
    return s;
  }
}
