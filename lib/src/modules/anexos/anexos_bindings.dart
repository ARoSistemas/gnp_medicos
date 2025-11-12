part of 'anexos_page.dart';

class _AnexosBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<AnexosController>(AnexosController.new)
      ..put<AnnexesRepository>(AnnexesRepository());
  }
}
