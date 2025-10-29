import 'package:medicos/core/extensions/null_extensions.dart';

class Validators {
  static String? validateName(String? value) {
    if (value.value().trim().isEmpty) {
      return 'Ingresa tu nombre para continuar.';
    }
    return null;
  }

  static String? validateFirstName(String? value) {
    if (value.value().trim().isEmpty) {
      return 'Ingresa tu apellido para continuar.';
    }
    return null;
  }

  static bool isValidEmail(String email) => RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  ).hasMatch(email);

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Agrega un correo válido';
    }
    if (!isValidEmail(value)) {
      return 'Agrega un correo válido';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password!.isEmpty) {
      return 'Ingresa tu contraseña';
    }
    return null;
  }

  static bool isValidPhone(String phone) {
    // Validar número mexicano de 10 dígitos
    final String cleanPhone = phone.replaceAll(RegExp('[^0-9]'), '');
    return cleanPhone.length == 10 &&
        RegExp(r'^[0-9]{10}$').hasMatch(cleanPhone);
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'El número de celular es requerido';
    }
    if (!isValidPhone(value)) {
      return 'Ingresa los 10 dígitos de tu número';
    }
    return null;
  }

  static String? validateOption(String? value) {
    if (value == null || value.isEmpty) {
      return 'Selecciona una opción valida';
    }
    return null;
  }

  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Selecciona fecha valida';
    }
    return null;
  }

  static String? validateRfc(String? value) {
    if (value == null || value.isEmpty) {
      return 'El RFC es obligatorio.';
    }

    final String rfcLimpio = value
        .trim()
        .toUpperCase()
        .replaceAll('-', '')
        .replaceAll(' ', '');

    if (rfcLimpio.length != 12 && rfcLimpio.length != 13) {
      return 'El RFC debe tener 12 o 13 caracteres.';
    }

    final RegExp rfcRegExp = RegExp(r'^([A-ZÑ&]{3,4})\d{6}([A-Z\d]{3})$');

    if (!rfcRegExp.hasMatch(rfcLimpio)) {
      return 'El formato del RFC no es válido.';
    }

    if (rfcLimpio.startsWith('XAXX')) {
      return 'El RFC genérico no está permitido.';
    }

    return null;
  }

  static String generateRfcBase(
    String name,
    String firstName,
    String lastName,
  ) {
    String cleanName;
    String cleanFirstName;
    String cleanLastName;

    cleanName = _cleanNames(name.trim().toUpperCase());
    cleanFirstName = _cleanNames(firstName.trim().toUpperCase());
    cleanLastName = _cleanNames(lastName.trim().toUpperCase());

    // Primera letra del apellido paterno
    final String l1 = cleanFirstName.isNotEmpty ? cleanFirstName[0] : '';

    // Primera vocal interna del apellido paterno
    String l2 = '';
    for (int i = 1; i < cleanFirstName.length; i++) {
      if ('AEIOU'.contains(cleanFirstName[i])) {
        l2 = cleanFirstName[i];
        break;
      }
    }

    // Primera letra del apellido materno
    final String l3 = cleanLastName.isNotEmpty ? cleanLastName[0] : '';

    // Primera letra del nombre
    final String l4 = cleanName.isNotEmpty ? cleanName[0] : '';

    return l1 + l2 + l3 + l4;
  }

  static String validateRfcName({
    required String name,
    required String firstName,
    required String lastName,
    required String rfc,
  }) {
    final String rfcBase = generateRfcBase(
      name,
      firstName,
      lastName,
    );
    final String rfcClean = rfc.trim().toUpperCase();
    if (!rfcClean.startsWith(rfcBase)) {
      return 'El RFC no coincide con el nombre y apellidos.';
    }
    return '';
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
