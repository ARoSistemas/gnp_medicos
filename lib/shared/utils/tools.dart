import 'package:intl/intl.dart';

class Tools {
  static bool isAgreedByString(String? vigencia) {
    if (vigencia == null) {
      return false;
    }
    final List<String> partes = vigencia.split(' - ');
    if (partes.length != 2) {
      return false;
    }

    final String inicioStr = partes[0].trim();
    final String finStr = partes[1].trim();
    final formato = DateFormat('dd MMMM yyyy', 'es_ES');

    try {
      final DateTime inicio = formato.parse(inicioStr);
      final DateTime fin = formato.parse(finStr);
      final hoy = DateTime.now();
      return hoy.isAfter(inicio) && hoy.isBefore(fin) ||
          hoy.isAtSameMomentAs(inicio) ||
          hoy.isAtSameMomentAs(fin);
    } on FormatException {
      return false;
    }
  }

  static bool isAgreedByDates(String? inicioStr, String? finStr) {
    if (inicioStr == null || finStr == null) {
      return false;
    }
    try {
      final DateTime inicio = DateTime.parse(inicioStr);
      final DateTime fin = DateTime.parse(finStr);
      final hoy = DateTime.now();
      return (hoy.isAfter(inicio) && hoy.isBefore(fin)) ||
          hoy.isAtSameMomentAs(inicio) ||
          hoy.isAtSameMomentAs(fin);
    } on FormatException {
      return false;
    }
  }

  String removeDiacritics(String? str) {
    if (str == null) {
      return '';
    }

    const withDiacritics = 'áàäâãéèëêíìïîóòöôõúùüûñÁÀÄÂÃÉÈËÊÍÌÏÎÓÒÖÔÕÚÙÜÛÑ';
    const withoutDiacritics = 'aaaaaeeeeiiiiooooouuuunAAAAAEEEEIIIIOOOOOUUUUN';

    return str
      .split('')
      .map((char) {
        final int index = withDiacritics.indexOf(char);
        return index == -1
            ? char.toLowerCase()
            : withoutDiacritics[index].toLowerCase();
      })
      .join();
  }
}
