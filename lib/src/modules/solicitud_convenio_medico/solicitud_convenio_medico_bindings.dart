part of 'solicitud_convenio_medico_page.dart';

class _SolicitudConvenioMedicoBindings extends Bindings {
  @override
  void dependencies() {
    Get..lazyPut(SolicitudConvenioMedicoController.new)
    ..put(FormatsRepository());
  }
}
