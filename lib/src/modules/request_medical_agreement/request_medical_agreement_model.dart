part of 'request_medical_agreement_controller.dart';

final class _RequestMedicalAgreementModel {
  const _RequestMedicalAgreementModel({
    this.name = 'NewRequest',
  });

  _RequestMedicalAgreementModel copyWith({
    String? name,
  }) => _RequestMedicalAgreementModel(
    name: name ?? this.name,
  );

  final String name;
}
