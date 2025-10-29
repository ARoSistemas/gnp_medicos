import 'package:flutter/material.dart';

enum AlertDialogType {
  errorConexion,
  errorBuscarPorCliente,
  sinResultados,
}

void customAlert(
  AlertDialogType type,
  BuildContext context,
  String title,
  String message,
) {
  // Implementación vacía para satisfacer el compilador.
  // print('Mostrando alerta (stub): $type, $title, $message');
}
