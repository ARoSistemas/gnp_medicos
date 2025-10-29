part of 'registro_page.dart';

class _RegistroBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<RegistroController>(
        RegistroController.new,
      )
      ..put(RegistroRepository());
  }
}
