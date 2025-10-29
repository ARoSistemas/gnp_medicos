part of 'tabuladores_controller.dart';

final class _TabuladoresModel {
  const _TabuladoresModel({
    this.name = 'Tabuladores',
  });

  _TabuladoresModel copyWith({
    String? name,
  }) => _TabuladoresModel(
    name: name ?? this.name,
  );

  final String name;
}
