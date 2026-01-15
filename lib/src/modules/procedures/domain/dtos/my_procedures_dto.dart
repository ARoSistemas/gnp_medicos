import 'dart:convert';

import 'package:medicos/shared/messages/i_app_messages.dart';

class MyProceduresDto {
  MyProceduresDto({
    required this.success,
    required this.entidad,
  });

  factory MyProceduresDto.empty() => MyProceduresDto(
    success: false,
    entidad: Entidad.empty(),
  );

  factory MyProceduresDto.fromMap(Map<String, dynamic> json) => MyProceduresDto(
    success: json['success'] ?? false,
    entidad: json['entidad'] == null
        ? Entidad.empty()
        : Entidad.fromMap(json['entidad']),
  );

  factory MyProceduresDto.fromRaw(String str) =>
      MyProceduresDto.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'success': success,
    'entidad': entidad.toMap(),
  };

  bool success;
  Entidad entidad;
}

class Entidad {
  Entidad({
    required this.totalItems,
    required this.totalPages,
    required this.queryPageSize,
    required this.nextPageToken,
    required this.data,
  });

  factory Entidad.empty() => Entidad(
    totalItems: 0,
    totalPages: 0,
    queryPageSize: 0,
    nextPageToken: '',
    data: [],
  );

  factory Entidad.fromRaw(String str) => Entidad.fromMap(json.decode(str));

  factory Entidad.fromMap(Map<String, dynamic> json) => Entidad(
    totalItems: json['totalItems'] ?? 0,
    totalPages: json['totalPages'] ?? 0,
    queryPageSize: json['queryPageSize'] ?? 0,
    nextPageToken: json['nextPageToken'] ?? '',
    data: List<EntidadItem>.from(
      (json['data'] as List).map((x) => EntidadItem.fromMap(x)),
    ),
  );

  Map<String, dynamic> toMap() => {
    'totalItems': totalItems,
    'totalPages': totalPages,
    'queryPageSize': queryPageSize,
    'nextPageToken': nextPageToken,
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
  };

  final int totalItems;
  final int totalPages;
  final int queryPageSize;
  final String nextPageToken;
  final List<EntidadItem> data;
}

class EntidadItem {
  EntidadItem({
    required this.idTramite,
    required this.folioTransaccion,
    required this.nombreAsegurado,
    required this.fechaSiniestro,
    required this.padecimientoIcd,
    required this.hospitalAtencion,
    required this.estatus,
    required this.nroPoliza,
  });

  factory EntidadItem.empty() => EntidadItem(
    idTramite: '',
    folioTransaccion: '',
    nombreAsegurado: '',
    fechaSiniestro: '',
    padecimientoIcd: '',
    hospitalAtencion: '',
    estatus: '',
    nroPoliza: '',
  );

  factory EntidadItem.fromMap(Map<String, dynamic> json) => EntidadItem(
    idTramite: json['idTramite'] ?? '',
    folioTransaccion: json['folioTransaccion'] ?? '',
    nombreAsegurado: json['nombreAsegurado'] ?? '',
    fechaSiniestro: json['fechaSiniestro'] ?? '',
    padecimientoIcd: json['padecimientoIcd'] ?? '',
    hospitalAtencion: json['hospitalAtencion'] ?? '',
    estatus: json['estatus'] ?? '',
    nroPoliza: json['nroPoliza'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'idTramite': idTramite,
    'folioTransaccion': folioTransaccion,
    'nombreAsegurado': nombreAsegurado,
    'fechaSiniestro': fechaSiniestro,
    'padecimientoIcd': padecimientoIcd,
    'hospitalAtencion': hospitalAtencion,
    'estatus': estatus,
    'nroPoliza': nroPoliza,
  };

  final String idTramite;
  final String folioTransaccion;
  final String nombreAsegurado;
  final String fechaSiniestro;
  final String padecimientoIcd;
  final String hospitalAtencion;
  final String estatus;
  final String nroPoliza;

  /// Getter que formatea la fecha de siniestro de 'YYYY-MM-DD' a 'DD Mon YYYY'.
  /// Ejemplo: '2025-05-20' -> '20 May 2025'
  String getFormattedDate() {
    final String dateString = fechaSiniestro;
    if (dateString.isEmpty) {
      return '';
    }
    try {
      final DateTime date = DateTime.parse(dateString);

      /// Accede a las abreviaturas de los meses desde el sistema de mensajes.
      final List<String> monthAbbreviations = msg.monthAbbreviations;
      if (date.month - 1 < monthAbbreviations.length) {
        return '${date.day} ${monthAbbreviations[date.month - 1]} ${date.year}';
      }

      /// Fallback por si algo sale mal
      return dateString;
    } on FormatException catch (_) {
      /// Si el formato de fecha no es el esperado, devuelve el original.
      return dateString;
    }
  }
}
