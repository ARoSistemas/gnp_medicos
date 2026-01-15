part of 'tabulators_controller.dart';

final class _TabulatorsModel {
  const _TabulatorsModel({
    this.name = 'Tabuladores',
    this.estadosCat = const [],
    this.circulosCat = const [],
  });

  factory _TabulatorsModel.empty() => const _TabulatorsModel();

  _TabulatorsModel copyWith({
    String? name,
    List<EstadoDto>? estadosCat,
    List<CirculoDto>? circulosCat,
  }) => _TabulatorsModel(
    name: name ?? this.name,
    estadosCat: estadosCat ?? this.estadosCat,
    circulosCat: circulosCat ?? this.circulosCat,
  );

  final String name;
  final List<EstadoDto> estadosCat;
  final List<CirculoDto> circulosCat;
}
