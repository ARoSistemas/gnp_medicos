
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioResultsModule/DirectorioResultsContract.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioResultsModule/DirectorioResultsController.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioResultsModule/DirectorioResultsInteractor.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioResultsModule/DirectorioResultsRouter.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioResultsModule/SearchResult.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Parametros.dart';
import 'package:flutter/material.dart';

class DirectorioResultsPresenter
    implements
        DirectorioResultsPresentation,
        DirectorioResultsInteractorOutput {
  DirectorioResultsControllerState? view;
  DirectorioResultsInteractor? interactor;
  DirectorioResultsRouter? router;

  DirectorioResultsPresenter(DirectorioResultsControllerState view) {
    this.view = view;
    this.interactor = new DirectorioResultsInteractor(this, view);
    this.router = new DirectorioResultsRouter(view);
  }

  @override
  void backToHome() {
    router!.backToHome();
  }

  @override
  void openMap(String? title, SearchResult searchResult, String catalogo) {
    router?.openMap(title, searchResult, catalogo);
  }

  @override
  List<DropdownMenuItem<String>>? getPolizas() {
    return router?.getPolizas();
  }

  @override
  void openFilters(String? servicio, Parametros? parametros, String? catalogo,
      String? poliza, String? especialidad) {
    router?.openFilters(servicio, parametros, catalogo, poliza, especialidad);
  }

  @override
  void showAlert(String icon, String title, String message) {
    router?.showAlert(icon, title, message);
  }

  @override
  void mostrarAlertaCallBackCustom(String titulo, String mensaje,
      BuildContext context, String buttonText, Function positive) {
    router?.mostrarAlertaCallBackCustom(
        titulo, mensaje, context, buttonText, positive);
  }

  @override
  Future<List<SearchResultList>>? getHospitalBusqueda(
      String? idHospital,
      String? nombreComercial,
      String? claveEstado,
      String? claveMunicipio,
      String? rfc,
      String? razonSocial,
      String? codigoFiliacion,
      String? clavePlan,
      String? claveLineaComercial,
      bool? banPlanContratado,
      String? claveNivelHospitalario,
      String? productoTecnico,
      String? productoComercial,
      String? origen,
      bool? filtros,
      int? pagina,
      DateTime? dateTime) async {
    return await interactor!.getHospitalBusqueda(
        idHospital,
        nombreComercial,
        claveEstado,
        claveMunicipio,
        rfc,
        razonSocial,
        codigoFiliacion,
        clavePlan,
        claveLineaComercial,
        banPlanContratado,
        claveNivelHospitalario,
        productoTecnico,
        productoComercial,
        origen,
        filtros,
        pagina,
        dateTime);
  }

  @override
  Future<List<SearchResultList>> getMedicoBusqueda(
      int? claveConvenio,
      String? claveCirculoMedico,
      bool? banCirculoMedicoContratado,
      String? claveEstado,
      String? claveMunicipio,
      int? claveEspecialidad,
      String? nombreMedico,
      String? origen,
      String? especialidad,
      int? pagina,
      DateTime? dateTime) async {
    return await interactor!.getMedicoBusqueda(
        claveConvenio,
        claveCirculoMedico,
        banCirculoMedicoContratado,
        claveEstado,
        claveMunicipio,
        claveEspecialidad,
        nombreMedico,
        origen,
        especialidad,
        pagina,
        dateTime);
  }

  @override
  Future<List<SearchResultList>> getClinicasBusqueda(
      String? claveGestion,
      String? nombreProveedor,
      String? claveTipoClinica,
      String? claveEstado,
      String? claveMunicipio,
      int? pagina,
      DateTime? dateTime,
      String? tipoClinica) async {
    return await interactor!.getClinicasBusqueda(
      claveGestion, 
      nombreProveedor,
      claveTipoClinica, 
      claveEstado, 
      claveMunicipio, 
      pagina, 
      dateTime,
      tipoClinica
    );
  }

  @override
  Future<List<SearchResultList>> getOtrosServiciosMedicosBusqueda(
      String claveGestion,
      String nombreProveedor,
      String claveTipoServicio,
      String claveEstado,
      String claveMunicipio,
      int pagina,
      DateTime dateTime) async {
    return await interactor!.getOtrosServiciosMedicosBusqueda(
        claveGestion,
        nombreProveedor,
        claveTipoServicio,
        claveEstado,
        claveMunicipio,
        pagina,
        dateTime);
  }

  @override
  Future<List<SearchResultList>> getModulosBusqueda(
      String claveEstado, DateTime dateTime) async {
    return await interactor!.getModulosBusqueda(claveEstado, dateTime);
  }
}
