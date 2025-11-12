part of 'benefits_page.dart';

class _BeneficiosBindings extends Bindings {
  @override
  void dependencies() {
    Get
    ..lazyPut(BeneficiosController.new)
    ..put(BeneficiosRepository());
  }
}
