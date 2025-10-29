part of 'datos_personales_controller.dart';

final class _DatosPersonalesModel {
  const _DatosPersonalesModel({
    this.name = 'DatosPersonales',
  });

  _DatosPersonalesModel copyWith({
    String? name,
  }) => _DatosPersonalesModel(
    name: name ?? this.name,
  );

  final String name;
}
