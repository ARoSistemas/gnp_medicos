part of 'profile_page.dart';

class _ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(ProfileController.new)
      ..put(ProfileRepository());
  }
}
