part of 'nueva_solicitud_controller.dart';

final class _NuevaSolicitudModel {
  _NuevaSolicitudModel({
    this.name = 'NuevaSolicitud',
    this.specialties = const [],
    this.subSpecialties = const [],
    this.states = const [],
    this.hospitalAttention = const [],
  });

  factory _NuevaSolicitudModel.empty() => _NuevaSolicitudModel(
    specialties: [],
    subSpecialties: [],
    states: [],
    hospitalAttention: [],
  );

  _NuevaSolicitudModel copyWith({
    String? name,
    List<CatalogConvenioModel>? specialties,
    List<CatalogConvenioModel>? subSpecialties,
    List<CatalogConvenioModel>? states,
    List<CatalogConvenioModel>? hospitalAttention,
  }) => _NuevaSolicitudModel(
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
