import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioFiltrosModule/DirectorioFiltrosContract.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioFiltrosModule/DirectorioFiltrosController.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioResultsModule/DirectorioResultsController.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Parametros.dart';
import 'package:flutter/material.dart';

class DirectorioFiltrosRouter implements DirectorioFiltrosWireFrame{

  DirectorioFiltrosControllerState? view;

  DirectorioFiltrosRouter(DirectorioFiltrosControllerState view){
    this.view = view;
  }

  @override
  void backToHome() {
    Navigator.pop(view!.context);
  }

  @override
  void showSearch(String servicio,String servicioSelect, String catalogo, String catalogodos, String estado, String municipio, Parametros claves, String poliza, bool filtros) {
    Navigator.of(view!.context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return DirectorioResultsController(servicio: servicio, servicioSelect: servicioSelect, catalogo: catalogo, catalogodos: catalogodos, estado: estado, municipio: municipio, parametros: claves, poliza: poliza, filtros: filtros);
        }));
  }
}