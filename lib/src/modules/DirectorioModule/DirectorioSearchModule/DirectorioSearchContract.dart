import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioResultsModule/SearchResult.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Catalogos.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Parametros.dart';
import 'package:flutter/material.dart';

abstract class DirectorioSearchView {

}

abstract class DirectorioSearchPresentation {
  void backToHome();
  void showSearch(String servicio,String servicioSelect, String catalogo, String catalogodos,String estado, String municipio, Parametros claves, String poliza);
  Future<List<NivelHospitalario>> getNivelHospitalario(bool contratado, String plan, String clavePlan, String productoTecnico, String productoComercial);
  Future<List<Planes>> getPlanes();
  List<DropdownMenuItem<String>> getPolizas();
  Future<List<CirculoMedico>> getCirculosM();
  Future<List<Especialidad>> getEspecialidades();
  Future<List<TipoClinica>> getClinicas();
  Future<List<TipoServicios>> getTipoServicio();
  List<DropdownMenuItem<String>> getServicios();
  Future<List<Estados>> getEstados();
  Future<List<Municipios>> getMunicipios(String cvEstado);
  void openMap(String title, SearchResult searchResult);
  Future sendAnalytics(String seccion, String opcion1, String opcion2, String estado, String municipio, String poliza);
}

abstract class DirectorioSearchUseCase {
  Future<List<NivelHospitalario>> getNivelHospitalario(bool contratado, String plan, String clavePlan, String productoTecnico, String productoComercial);
  Future<List<Planes>> getPlanes();
  List<DropdownMenuItem<String>> getPolizas();
  Future<List<CirculoMedico>> getCirculosM();
  Future<List<Especialidad>> getEspecialidades();
  Future<List<TipoClinica>> getClinicas();
  Future<List<TipoServicios>> getTipoServicio();
  List<DropdownMenuItem<String>> getServicios();
  Future<List<Estados>> getEstados();
  Future<List<Municipios>> getMunicipios(String cvEstado);
  Future sendAnalytics(String seccion, String opcion1, String opcion2, String estado, String municipio, String poliza);
}

abstract class DirectorioSearchInteractorOutput {

}

abstract class DirectorioSearchWireFrame {
  void backToHome();
  void showSearch(String servicio,String servicioSelect, String catalogo, String catalogodos,String estado, String municipio, Parametros claves, String poliza);
  void openMap(String title, SearchResult searchResult);
}