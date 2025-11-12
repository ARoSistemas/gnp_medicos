part of 'benefits_controller.dart';

final class _BeneficiosModel {
  const _BeneficiosModel({
    this.name = 'Beneficios',
    this.benefitsList = const []
  });

  factory _BeneficiosModel.empty() => const _BeneficiosModel();

  _BeneficiosModel copyWith({
    String? name,
    List<BenefitDto>? benefitsList,
  }) => _BeneficiosModel(
    name: name ?? this.name,
    benefitsList: benefitsList ?? this.benefitsList,
  );

  final String name;
  final List<BenefitDto> benefitsList;
}
