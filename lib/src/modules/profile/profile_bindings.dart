part of 'profile_page.dart';

class _ProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(ProfileController.new)
      ..lazyPut<DatosAcademicosController>(DatosAcademicosController.new)
      ..lazyPut<DatosFiscalesController>(DatosFiscalesController.new)
      ..put(ProfileRepository())
      ..put(AuthRepository())
      ..put(DatosPersonalesController());
  }
}
