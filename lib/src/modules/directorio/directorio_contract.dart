import 'package:medicos/src/modules/directorio/entity/catalogos.dart';

abstract class DirectorioView {}

abstract class DirectorioPresentation {
  void backToHome();
  void showMedicosSearch();
  void showHosptalesSearch();
  void showClinicasSearch();
  void showOtrosServSearch();
  Future<List<CirculoMedico>> getCirculosM();
  Future<List<Especialidad>> getEspecialidades();
  Future<List<SubEspecialidad>> getSubEspecialidades();
  Future<List<Planes>> getPlanes();
  Future<List<TipoClinica>> getClinicas();
  Future<List<TipoServicios>> getTipoServicio();
  Future<List<Estados>> getEstados();
  Future<List<Municipios>> getMunicipios(String cvEstado);
  Future<bool> requestLocationPermission();
  Future sendAnalytics(String opcion);
}

abstract class DirectorioUseCase {
  Future<List<CirculoMedico>> getCirculosM();
  Future<List<Especialidad>> getEspecialidades();
  Future<List<SubEspecialidad>> getSubEspecialidades();
  Future<List<Planes>> getPlanes();
  Future<List<TipoClinica>> getClinicas();
  Future<List<TipoServicios>> getTipoServicio();
  Future<List<Estados>> getEstados();
  Future<List<Municipios>> getMunicipios(String cvEstado);
  Future sendAnalytics(String opcion);
}

abstract class DirectorioInteractorOutput {}

abstract class DirectorioWireFrame {
  void backToHome();
  void showMedicosSearch();
  void showHosptalesSearch();
  void showClinicasSearch();
  void showOtrosServSearch();
  Future<bool> requestLocationPermission();
}
