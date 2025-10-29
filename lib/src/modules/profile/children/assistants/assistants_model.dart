part of 'assistants_controller.dart';

final class _AssistantsModel {
  _AssistantsModel({
    this.name = 'Asistentes',
    this.assistants = const [],
  });

  factory _AssistantsModel.empty() => _AssistantsModel(
    assistants: [],
  );

  _AssistantsModel copyWith({
    String? name,
    List<AssistantDto>? assistants,
  }) => _AssistantsModel(
    name: name ?? this.name,
    assistants: assistants ?? this.assistants,
  );

  final String name;
  final List<AssistantDto> assistants;
}
