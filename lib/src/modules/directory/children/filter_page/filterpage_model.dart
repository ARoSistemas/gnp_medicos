part of 'filterpage_controller.dart';

final class _FilterPageModel {
  _FilterPageModel({
    required this.name,
    required this.itemSelected,
  });

  _FilterPageModel copyWith({
    String? name,
    String? itemSelected,
  }) => _FilterPageModel(
    name: name ?? this.name,
    itemSelected: itemSelected ?? this.itemSelected,
  );

  final String name;
  final String itemSelected;
}
