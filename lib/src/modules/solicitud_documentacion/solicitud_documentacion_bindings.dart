part of 'solicitud_documentacion_page.dart';

class _SolicitudDocumentacionBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SolicitudDocumentacionController>(
        SolicitudDocumentacionController.new,
    );
  }
}
