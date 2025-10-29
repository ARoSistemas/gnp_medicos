part of 'procedures_controller.dart';

final class _ProceduresModel {
  const _ProceduresModel({
    this.name = 'Procedures',
  });

  _ProceduresModel copyWith({
    String? name,
  }) => _ProceduresModel(
    name: name ?? this.name,
  );

  final String name;
}
