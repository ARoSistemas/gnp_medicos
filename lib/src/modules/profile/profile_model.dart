part of 'profile_controller.dart';

final class ProfileModel {
  const ProfileModel({
    this.name = 'Mi Perfil',
  });

  ProfileModel copyWith({
    String? name,
  }) => ProfileModel(
    name: name ?? this.name,
  );

  final String name;
}
