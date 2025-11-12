part of 'anexos_controller.dart';

final class AnexosModel {
  AnexosModel({
    this.name = 'Anexos',
    this.items = const [],
  });

  factory AnexosModel.empty() => AnexosModel();

  AnexosModel copyWith({
    String? name,
    List<AnnexesDto>? items,
  }) => AnexosModel(
    name: name ?? this.name,
    items: items ?? this.items,
  );

  final String name;
  List<AnnexesDto> items = [];
}
