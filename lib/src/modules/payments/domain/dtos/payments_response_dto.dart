class PaymentsDto {

  PaymentsDto({
    required this.data,
    required this.nextPageToken,
    required this.hasNextPage,
    required this.totalItems,
    required this.totalPages,
    required this.pageSize
  });
  factory PaymentsDto.empty() => PaymentsDto(
    data: [],
    nextPageToken: '',
    hasNextPage: true, 
    totalItems: 0, 
    totalPages: 0, 
    pageSize: 0,
  );

  factory PaymentsDto.fromJson(Map<String, dynamic> json) => PaymentsDto(
    data: json['data'] != null ?
     List<PaymentItem>.from(
      (json['data'] as List).map((x) => PaymentItem.fromJson(x)),
    ) : [],
    nextPageToken: json['nextPageToken'] ?? '',
    hasNextPage: json['hasNextPage'] ?? false, 
    totalItems:json['totalItems'] ?? 0, 
    totalPages: json['totalPages'] ??0, 
    pageSize: json['pageSize'] ?? 0,
  );
  final List<PaymentItem> data;
  final String? nextPageToken;
  final bool? hasNextPage;
  final int totalItems;
  final int totalPages;
  final int pageSize;

  


  Map<String, dynamic> toJson() => {
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
    'nextPageToken': nextPageToken,
    'hasNextPage': hasNextPage,
  };
}

class PaymentItem {
  PaymentItem({
    required this.numeroPago,
    required this.fechaPago,
    required this.siniestroAsociado,
    required this.desEstadoPago,
    required this.montoReclamado,
    required this.montoPagado,
    required this.numeroCuentaPago,
    required this.institucionBancaria,
    required this.metodoPago,
  });

  factory PaymentItem.empty() => PaymentItem(
    numeroPago: '',
    fechaPago: '',
    siniestroAsociado: '',
    desEstadoPago: '',
    montoReclamado: 0,
    montoPagado: 0,
    numeroCuentaPago: '',
    institucionBancaria: '',
    metodoPago: '',
  );

  factory PaymentItem.fromJson(Map<String, dynamic> json) => PaymentItem(
    numeroPago: json['numeroPago'],
    fechaPago: json['fechaPago'] == null ? '' : _formatDate(json['fechaPago']),
    siniestroAsociado: json['siniestroAsociado'],
    desEstadoPago: json['desEstadoPago'],
    montoReclamado: double.tryParse(json['montoReclamado'].toString()),
    montoPagado: double.tryParse(json['montoPagado'].toString()),
    numeroCuentaPago: json['numeroCuentaPago'],
    institucionBancaria: json['institucionBancaria'],
    metodoPago: json['metodoPago'],
  );
  final String? numeroPago;
  final dynamic fechaPago;
  final String? siniestroAsociado;
  final String? desEstadoPago;
  final double? montoReclamado;
  final double? montoPagado;
  final String? numeroCuentaPago;
  final String? institucionBancaria;
  final dynamic metodoPago;

  Map<String, dynamic> toJson() => {
    'numeroPago': numeroPago,
    'fechaPago': fechaPago,
    'siniestroAsociado': siniestroAsociado,
    'desEstadoPago': desEstadoPago,
    'montoReclamado': montoReclamado,
    'montoPagado': montoPagado,
    'numeroCuentaPago': numeroCuentaPago,
    'institucionBancaria': institucionBancaria,
    'metodoPago': metodoPago,
  };



  /// Función estática para formatear la fecha.
  /// Puede ser llamada desde el factory o desde el getter.
  static String _formatDate(String dateString) {
    if (dateString.isEmpty) {
      return '';
    }
    try {
      final DateTime date = DateTime.parse(dateString);
      const List<String> months = [
        'Ene',
        'Feb',
        'Mar',
        'Abr',
        'May',
        'Jun',
        'Jul',
        'Ago',
        'Sep',
        'Oct',
        'Nov',
        'Dic',
      ];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } on FormatException catch (_) {
      // Si el formato de fecha no es el esperado, devuelve el original.
      return dateString;
    }
  }
}
