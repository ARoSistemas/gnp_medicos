part of 'datos_fiscales_controller.dart';

final class _DatosFiscalesModel {
  const _DatosFiscalesModel({
    this.name = 'DatosFiscales',
  });

  _DatosFiscalesModel copyWith({
    String? name,
  }) => _DatosFiscalesModel(
    name: name ?? this.name,
  );

  final String name;
}
