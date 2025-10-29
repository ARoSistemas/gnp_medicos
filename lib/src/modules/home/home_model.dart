part of 'home_controller.dart';

final class _HomeModel {
  const _HomeModel({
    this.name = 'Home',
    this.asisstantList = const [],
  });

  factory _HomeModel.empty() => const _HomeModel();

  _HomeModel copyWith({
    String? name,
    List<AsisstantDto>? asisstantList,
  }) => _HomeModel(
    name: name ?? this.name,
    asisstantList: asisstantList ?? this.asisstantList,
  );

  final String name;
  final List<AsisstantDto> asisstantList;
}
