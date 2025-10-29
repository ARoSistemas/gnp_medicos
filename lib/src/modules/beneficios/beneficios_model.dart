part of 'beneficios_controller.dart';

final class _BeneficiosModel {
  const _BeneficiosModel({
    this.name = 'Beneficios',
  });

  _BeneficiosModel copyWith({
    String? name,
  }) => _BeneficiosModel(
    name: name ?? this.name,
  );

  final String name;
}
