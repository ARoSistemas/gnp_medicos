part of 'tabulators_page.dart';

class _TabuladoresBindings extends Bindings {
  @override
  void dependencies() {
    Get..lazyPut(TabulatorsController.new)
    ..put(TabulatorsRepository());
  }
}
