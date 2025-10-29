part of 'convenio_medico_controller.dart';

final class _ConvenioMedicoModel {
  const _ConvenioMedicoModel({
    this.name = 'ConvenioMedico',
  });

  _ConvenioMedicoModel copyWith({
    String? name,
  }) => _ConvenioMedicoModel(
    name: name ?? this.name,
  );

  final String name;
}
