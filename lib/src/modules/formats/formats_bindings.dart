part of 'formats_page.dart';

class _FormatsBindings extends Bindings {
  @override
  void dependencies() {
    Get..lazyPut(FormatsController.new)
    ..put(FormatsRepository());
  }
}
