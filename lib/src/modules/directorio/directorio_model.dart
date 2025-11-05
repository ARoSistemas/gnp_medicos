part of 'directorio_controller.dart';

final class _DirectorioModel {
  const _DirectorioModel({
    this.name = 'Directorio',
  });

  _DirectorioModel copyWith({
    String? name,
  }) => _DirectorioModel(
    name: name ?? this.name,
  );

  final String name;
}
