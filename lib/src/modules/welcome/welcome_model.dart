part of 'welcome_controller.dart';

final class _WelcomeModel {
  const _WelcomeModel({
    this.name = 'Welcome',
  });

  _WelcomeModel copyWith({
    String? name,
  }) => _WelcomeModel(
    name: name ?? this.name,
  );

  final String name;
}
