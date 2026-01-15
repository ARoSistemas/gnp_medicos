part of 'directory_controller.dart';

final class _DirectoryModel {
  const _DirectoryModel({
    this.name = 'Directorio',
  });

  _DirectoryModel copyWith({
    String? name,
  }) => _DirectoryModel(
    name: name ?? this.name,
  );

  final String name;
}
