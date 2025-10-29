part of 'formats_controller.dart';

final class _FormatsModel {
  const _FormatsModel({
    this.name = 'Formatos',
  });

  _FormatsModel copyWith({
    String? name,
  }) => _FormatsModel(
    name: name ?? this.name,
  );
  
  final String name;
}
