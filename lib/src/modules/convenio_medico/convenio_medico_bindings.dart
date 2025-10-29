part of 'convenio_medico_page.dart';

class _ConvenioMedicoBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConvenioMedicoController>(
        ConvenioMedicoController.new,
    );
  }
}
