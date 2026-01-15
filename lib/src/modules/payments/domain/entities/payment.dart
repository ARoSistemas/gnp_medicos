class Payment {
  Payment({
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

  final String numeroPago;
  final dynamic fechaPago;
  final String siniestroAsociado;
  final String desEstadoPago;
  final double montoReclamado;
  final double montoPagado;
  final String numeroCuentaPago;
  final String institucionBancaria;
  final dynamic metodoPago;
}
