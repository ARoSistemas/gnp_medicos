import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioMapModule/DirectorioMapController.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioResultsModule/DirectorioResultsController.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioResultsModule/SearchResult.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioSearchModule/DirectorioSearchContract.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioSearchModule/DirectorioSearchController.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Parametros.dart';
import 'package:flutter/material.dart';

class DirectorioSearchRouter implements DirectorioSearchWireFrame {

  DirectorioSearchControllerState? view;

  DirectorioSearchRouter(DirectorioSearchControllerState view){
    this.view = view;
  }

  @override
  void backToHome() {
    Navigator.pop(view!.context);
  }

  @override
  void showSearch(String servicio,String servicioSelect, String catalogo, String catalogodos, String estado, String municipio, Parametros claves, String poliza) {
    Navigator.of(view!.context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return DirectorioResultsController(servicio: servicio,servicioSelect: servicioSelect, catalogo: catalogo, catalogodos: catalogodos, estado: estado, municipio: municipio, parametros: claves, poliza: poliza);
        }));
  }

  @override
  void openMap(String title, SearchResult searchResult) {
    Navigator.of(view!.context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return DirectorioMapController(title: title, searchResult: searchResult);
        }));
  }
}