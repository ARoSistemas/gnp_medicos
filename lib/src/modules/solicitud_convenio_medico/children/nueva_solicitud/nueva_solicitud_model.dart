part of 'nueva_solicitud_controller.dart';

final class _NuevaSolicitudModel {
  const _NuevaSolicitudModel({
    this.name = 'NuevaSolicitud',
    this.specialties = const [],
  });

  /* factory _NuevaSolicitudModel.empty() => const _NuevaSolicitudModel(
    specialties: [],
  );
 */
  _NuevaSolicitudModel copyWith({
    String? name,
    List<Especialidad>? specialties,
  }) => _NuevaSolicitudModel(
    name: name ?? this.name,
    specialties: specialties ?? this.specialties,
  );

  final String name;
  final List<Especialidad> specialties;
}
