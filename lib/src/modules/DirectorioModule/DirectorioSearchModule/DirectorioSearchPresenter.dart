
import 'package:agentesgnp/SolicitudMovimientos/Models/BusquedaNombre/Personas.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioResultsModule/SearchResult.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioSearchModule/DirectorioSearchContract.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioSearchModule/DirectorioSearchController.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioSearchModule/DirectorioSearchInteractor.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioSearchModule/DirectorioSearchRouter.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Catalogos.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Clinicas.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Hospitales.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/OtrosServiciosMedicos.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Parametros.dart';
import 'package:flutter/src/material/dropdown.dart';

class DirectorioSearchPresenter implements DirectorioSearchPresentation, DirectorioSearchInteractorOutput {

  DirectorioSearchControllerState? view;
  DirectorioSearchInteractor? interactor;
  DirectorioSearchRouter? router;

  DirectorioSearchPresenter(DirectorioSearchControllerState view) {
    this.view = view;
    this.interactor = new DirectorioSearchInteractor(this, view);
    this.router = new DirectorioSearchRouter(view);
  }

  @override
  void backToHome() {
    router?.backToHome();
  }

  @override
  Future<List<Planes>> getPlanes() async{
    return await interactor!.getPlanes();
  }

  @override
  List<DropdownMenuItem<String>> getPolizas() {
    return interactor!.getPolizas();
  }

  @override
  Future<List<CirculoMedico>> getCirculosM() async{
    return await interactor!.getCirculosM();
  }

  @override
  Future<List<Especialidad>> getEspecialidades() async{
    return await interactor!.getEspecialidades();
  }

  @override
  Future<List<TipoClinica>> getClinicas() async{
    return await interactor!.getClinicas();
  }

  @override
  Future<List<TipoServicios>> getTipoServicio() async{
    return await interactor!.getTipoServicio();
  }

  @override
  List<DropdownMenuItem<String>> getServicios() {
    return interactor!.getServicios();
  }

  @override
  Future<List<Estados>> getEstados() async{
    return await interactor!.getEstados();
  }

  @override
  Future<List<Municipios>> getMunicipios(String cvEstado) async{
    return await interactor!.getMunicipios(cvEstado);
  }

  @override
  void showSearch(String servicio,String servicioSelect, String catalogo, String catalogodos, String estado, String municipio, Parametros claves, String poliza) {
    router?.showSearch(servicio, servicioSelect, catalogo, catalogodos, estado, municipio, claves, poliza);
  }

  @override
  void openMap(String title, SearchResult searchResult) {
    router?.openMap(title, searchResult);
  }

  @override
  Future<List<NivelHospitalario>> getNivelHospitalario(bool contratado, String plan, String clavePlan, String productoTecnico, String productoComercial) async{
    return interactor!.getNivelHospitalario(contratado, plan, clavePlan, productoTecnico, productoComercial);
  }

  @override
  Future<List<Especialidad>> getEspecialidadesService() async{
    return await interactor!.getEspecialidades();
  }

  @override
  Future<List<Hospitales>> getHospitalesList() async{
    return  interactor!.getHospitalesList();
  }

  @override
  Future<List<Clinicas>> getClinicasList() async{
    return await interactor!.getClinicasList();
  }

   @override
  Future<List<OtServiciosM>> getOtrosServiciosMedicosList() async{
    return await interactor!.getOtrosServiciosMedicosList();
  }

   @override
  Future<List<Personas>> getPersonasPoliza(String name) async{
    return await interactor!.getPersonasPoliza(name);
  }


   @override
  Future<List<PolizasUsuario>> getPolizaSearch(String poliza) async{
    return await interactor!.getPolizaSearch(poliza);
  }

  @override
  Future<List<PolizasUsuario>> getPolizasClienteSearch(String cliente) async{
    return await interactor!.getPolizasClienteSearch(cliente);
  }

  @override
  Future sendAnalytics(String seccion, String opcion1, String opcion2, String estado, String municipio, String poliza) async {
    return await interactor!.sendAnalytics(seccion, opcion1, opcion2, estado, municipio, poliza);
  }
}