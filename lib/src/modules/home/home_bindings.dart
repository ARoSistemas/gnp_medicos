part of 'home_page.dart';

class _HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(HomeController.new)
      ..put(HomeRepository());
  }
}
