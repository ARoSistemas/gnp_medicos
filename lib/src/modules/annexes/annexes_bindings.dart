part of 'annexes_page.dart';

class _AnnexesBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<AnnexesController>(AnnexesController.new)
      ..put<AnnexesRepository>(AnnexesRepository());
  }
}
