part of 'item_map_controller.dart';

final class _ItemMapModel {
  _ItemMapModel({
    this.name = '',
  });

  factory _ItemMapModel.empty() => _ItemMapModel();

  _ItemMapModel copyWith({
    String? name,
  }) => _ItemMapModel(
    name: name ?? this.name,
  );

  final String name;
}
