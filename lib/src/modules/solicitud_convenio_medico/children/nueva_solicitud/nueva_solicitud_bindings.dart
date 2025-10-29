part of 'nueva_solicitud_page.dart';

class _NuevaSolicitudBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NuevaSolicitudController>(
        NuevaSolicitudController.new,
    );
  }
}
