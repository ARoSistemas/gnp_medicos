part of 'anexos_controller.dart';

final class _AnexosModel {
  const _AnexosModel({
    this.name = 'Anexos',
  });

  _AnexosModel copyWith({
    String? name,
  }) => _AnexosModel(
    name: name ?? this.name,
  );

  final String name;
}
