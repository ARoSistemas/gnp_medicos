part of 'filter_results_controller.dart';

final class _FilterResultsModel {
  _FilterResultsModel({
    this.name = 'Resultados de Búsqueda',
  });

  factory _FilterResultsModel.empty() => _FilterResultsModel();

  _FilterResultsModel copyWith({
    String? name,
  }) => _FilterResultsModel(
    name: name ?? this.name,
  );

  final String name;
}
