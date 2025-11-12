part of 'formats_controller.dart';

final class _FormatsModel {
  const _FormatsModel({
    this.name = 'Formatos',
    this.formatsList = const []
  });

  factory _FormatsModel.empty() => const _FormatsModel();

  _FormatsModel copyWith({
    String? name,
    List<FormatDto>? formatsList,
  }) => _FormatsModel(
    name: name ?? this.name,
    formatsList: formatsList ?? this.formatsList,
  );
  
  final String name;
  final List<FormatDto> formatsList;
}
