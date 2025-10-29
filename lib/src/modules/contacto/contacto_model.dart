part of 'contacto_controller.dart';

final class _ContactoModel {
  const _ContactoModel({
    this.name = 'Contacto',
  });

  _ContactoModel copyWith({
    String? name,
  }) => _ContactoModel(
    name: name ?? this.name,
  );

  final String name;
}
