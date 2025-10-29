part of 'add_user_controller.dart';

final class _AddUserModel {
  _AddUserModel({
    required this.assistanTypeList,
    this.name = 'Agregar Usuario',
  });

  factory _AddUserModel.empty() => _AddUserModel(assistanTypeList: []);

  _AddUserModel copyWith({
    String? name,
    List<TiposAsistentesModel>? assistanTypeList,
  }) => _AddUserModel(
    name: name ?? this.name,
    assistanTypeList: assistanTypeList ?? this.assistanTypeList,
  );

  final String name;
  final List<TiposAsistentesModel> assistanTypeList;
}
