part of 'academic_data_controller.dart';

final class _DatosAcademicosModel {
  const _DatosAcademicosModel({
    this.name = 'DatosAcademicos',
  });

  _DatosAcademicosModel copyWith({
    String? name,
  }) => _DatosAcademicosModel(
    name: name ?? this.name,
  );

  final String name;
}
