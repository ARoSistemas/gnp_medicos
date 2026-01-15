part of 'new_request_controller.dart';

final class _NewRequestModel {
  _NewRequestModel({
    this.name = 'NewRequest',
    this.specialties = const [],
    this.subSpecialties = const [],
    this.states = const [],
    this.hospitalAttention = const [],
  });

  factory _NewRequestModel.empty() => _NewRequestModel(
    specialties: [],
    subSpecialties: [],
    states: [],
    hospitalAttention: [],
  );

  _NewRequestModel copyWith({
    String? name,
    List<CatalogConvenioModel>? specialties,
    List<CatalogConvenioModel>? subSpecialties,
    List<CatalogConvenioModel>? states,
    List<CatalogConvenioModel>? hospitalAttention,
  }) => _NewRequestModel(
    name: name ?? this.name,
    specialties: specialties ?? this.specialties,
    subSpecialties: subSpecialties ?? this.subSpecialties,
    states: states ?? this.states,
    hospitalAttention: hospitalAttention ?? this.hospitalAttention,
  );

  final String name;
  final List<CatalogConvenioModel> specialties;
  final List<CatalogConvenioModel> subSpecialties;
  final List<CatalogConvenioModel> states;
  final List<CatalogConvenioModel> hospitalAttention;
}
