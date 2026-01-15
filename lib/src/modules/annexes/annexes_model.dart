part of 'annexes_controller.dart';

final class AnnexesModel {
  AnnexesModel({
    this.name = 'Anexos',
    this.items = const [],
  });

  factory AnnexesModel.empty() => AnnexesModel();

  AnnexesModel copyWith({
    String? name,
    List<AnnexesDto>? items,
  }) => AnnexesModel(
    name: name ?? this.name,
    items: items ?? this.items,
  );

  final String name;
  List<AnnexesDto> items = [];
}
