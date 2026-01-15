import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/shared/constans/constans.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';

class Validators {
  static RegExp validString = RegExp(regexNames, unicode: true);

  static String? _validOnlyAlphabeticCharacters(String? value) {
    if (!validString.hasMatch(value!)) {
      return msg.onlyAlphabeticCharacters.tr();
    }
    return null;
  }

  static String? name(String? value) {
    if (value.value().trim().isEmpty) {
      return msg.enterYourNameContinue.tr();
    }
    return _validOnlyAlphabeticCharacters(value);
  }

  static String? lastName(String? value) {
    if (value.value().trim().isEmpty) {
      return msg.enterYourLastNameContinue.tr();
    }
    return _validOnlyAlphabeticCharacters(value);
  }

  static String? secondLastName(String? value) {
    if (value.value().trim().isEmpty) {
      return msg.enterYourLastNameContinue.tr();
    }
    return _validOnlyAlphabeticCharacters(value);
  }

  static String? inputText(String value) {
    if (value.trim().isEmpty) {
      return msg.fieldRequired.tr();
    }
    return _validOnlyAlphabeticCharacters(value);
  }

  static bool isValidEmail(String email) => RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  ).hasMatch(email);

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return msg.fieldRequired.tr();
    }
    if (!isValidEmail(value)) {
      return msg.enterYourEmail.tr();
    }
    return null;
  }

  static String? password(String? password) {
    if (password!.isEmpty) {
      return msg.enterYourPassword.tr();
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
      return msg.fieldRequired.tr();
    }
    if (!isValidPhone(value)) {
      return msg.enterTenDigits.tr();
    }
    return null;
  }

  static String? cedule(String? value, {bool required = false}) {
  if (required) {
    if (value == null || value.isEmpty) {
      return msg.fieldRequired.tr();
    }
    if (value.length < 6) {
      return msg.enterMinDigits.tr();
    }
    return null;
  }
  if (value != null && value.isNotEmpty && value.length < 6) {
    return msg.enterMinDigits.tr();
  }

  return null;
}

  static String? option(String? value) {
    if (value == null || value.isEmpty) {
      return msg.enterYourOption.tr();
    }
    return null;
  }

  static String? optionObject(dynamic value) {
    if (value == null) {
      return msg.enterYourOption.tr();
    }
    return null;
  }

  static String? date(String? value) {
    if (value == null || value.isEmpty) {
      return msg.enterYourDate.tr();
    }
    return null;
  }

  static String? rfc(String? value) {
    if (value == null || value.isEmpty) {
      return msg.fieldRequired.tr();
    }

    final String rfcLimpio = value
        .trim()
        .toUpperCase()
        .replaceAll('-', '')
        .replaceAll(' ', '');

    if (rfcLimpio.length != 12 && rfcLimpio.length != 13) {
      return msg.rfcDigitsTwelveThirteen.tr();
    }

    final RegExp rfcRegExp = RegExp(r'^([A-ZÑ&]{3,4})\d{6}([A-Z\d]{3})$');

    if (!rfcRegExp.hasMatch(rfcLimpio)) {
      return msg.rfcFormatInvalid.tr();
    }

    if (rfcLimpio.startsWith('XAXX')) {
      return msg.rfcGenericNoAllowed.tr();
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
      return msg.enterYourRfcName.tr();
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
