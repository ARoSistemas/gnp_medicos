part of 'welcome_page.dart';

class _WelcomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(WelcomeController.new);
  }
}
