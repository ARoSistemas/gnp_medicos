part of 'filterpage_page.dart';

class _FilterPageBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<FilterPageController>(FilterPageController.new)
      ..put<FilterPageRepository>(FilterPageRepository());
  }
}
