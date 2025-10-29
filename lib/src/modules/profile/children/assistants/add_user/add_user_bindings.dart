part of 'add_user_page.dart';

class _AddUserBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(AddUserController.new)
      ..put(AddUserRepository());
  }
}
