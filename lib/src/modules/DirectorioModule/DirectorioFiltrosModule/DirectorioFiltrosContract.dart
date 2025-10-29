import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Catalogos.dart';

abstract class DirectorioFiltrosView {

}

abstract class DirectorioFiltrosPresentation {
  void backToHome();
  Future<List<NivelHospitalario>> getNivelHospitalario(String clavePlan, String productoTecnico, String productoComercial);
  Future<List<CirculoMedico>> getCirculosM();
  Future<List<Estados>> getEstados();
  Future<List<Municipios>> getMunicipios(String cvEstado);
}

abstract class DirectorioFiltrosUseCase {
  Future<List<NivelHospitalario>> getNivelHospitalario(String clavePlan, String productoTecnico, String productoComercial);
  Future<List<CirculoMedico>> getCirculosM();
  Future<List<Estados>> getEstados();
  Future<List<Municipios>> getMunicipios(String cvEstado);
}

abstract class DirectorioFiltrosInteractorOutput {

}

abstract class DirectorioFiltrosWireFrame {
  void backToHome();
}