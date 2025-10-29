part of 'solicitud_convenio_medico_controller.dart';

final class _SolicitudConvenioMedicoModel {
  const _SolicitudConvenioMedicoModel({
    this.name = 'NuevaSolicitud',
  });

  _SolicitudConvenioMedicoModel copyWith({
    String? name,
  }) => _SolicitudConvenioMedicoModel(
    name: name ?? this.name,
  );

  final String name;
}
