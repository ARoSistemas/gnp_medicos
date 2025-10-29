part of 'registro_controller.dart';

final class _RegistroModel {
  const _RegistroModel({
    this.name = 'Registro',
  });

  _RegistroModel copyWith({
    String? name,
  }) => _RegistroModel(
    name: name ?? this.name,
  );

  final String name;
}
