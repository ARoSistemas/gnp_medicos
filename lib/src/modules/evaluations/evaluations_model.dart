part of 'evaluations_controller.dart';

final class _EvaluationsModel {
  const _EvaluationsModel({
    this.name = 'Evaluations',
  });

  _EvaluationsModel copyWith({
    String? name,
  }) => _EvaluationsModel(
    name: name ?? this.name,
  );

  final String name;
}
