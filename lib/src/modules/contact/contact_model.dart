part of 'contact_controller.dart';

final class _ContactModel {
  const _ContactModel({
    this.name = 'Contacto',
  });

  _ContactModel copyWith({
    String? name,
  }) => _ContactModel(
    name: name ?? this.name,
  );

  final String name;
}
