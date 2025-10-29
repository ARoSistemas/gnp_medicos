import 'package:agentesgnp/CommonsV2/Widgets/CustomAlerts.dart';
import 'package:agentesgnp/EnvironmentVariablesSetup/app_config.dart';
import 'package:agentesgnp/RequestHandler/MyRequest.dart';
import 'package:agentesgnp/RequestHandler/MyResponse.dart';
import 'package:agentesgnp/RequestHandler/RequestHandler.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioFiltrosModule/DirectorioFiltrosContract.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioFiltrosModule/DirectorioFiltrosController.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Catalogos.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/Utils.dart';
import 'package:agentesgnp/Utils/ConnectionManager.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/constants.dart' as Constants;

import '../DirectorioSearchModule/DirectorioSearchInteractor.dart';

class DirectorioFiltrosInteractor implements DirectorioFiltrosUseCase{

  DirectorioFiltrosInteractorOutput? output;
  DirectorioFiltrosControllerState? view;

  DirectorioFiltrosInteractor(DirectorioFiltrosInteractorOutput output, DirectorioFiltrosControllerState view) {
    this.output = output;
    this.view = view;
  }

  @override
  Future<List<NivelHospitalario>> getNivelHospitalario(String clavePlan, String? productoTecnico, String? productoComercial) async {
    if (!await ConnectionManager.isConnected()) {
      customAlert(AlertDialogType.errorConexion, view!.context, "", "");
    }
    final Trace data = FirebasePerformance.instance.newTrace("RedesMedicas_getNivelHosp");
    data.start();
   

    try{
      List<NivelHospitalario> niveles = [];

      if(Utils.listNiveles.isEmpty) {

        var config = AppConfig.of(view!.context);
        var headers = {
          "apiKey": config?.apiKeyServices??""
        };
        var parametros = "?";

        var body = {
          "origen": "intermediarios",
          "clavePlan" : clavePlan,
          "productoTecnico" : productoTecnico,
          "productoComercial" : productoComercial
        };
        body.forEach((key,value) =>
        parametros = value != null && value.toString() != "null"
            && value.toString() != "" && value.toString() != "0" || value.toString() == "false" ?
        parametros+key+"="+value.toString()+"&" : parametros);

        parametros = parametros+"?";
        parametros = parametros.replaceAll("&?", "").replaceAll("??", "");
        Utils.LogPrint(parametros);

        var request = MyRequest(
            baseUrl: config!.baseIntegracion!,
            path: Constants.nivelHospitalario + parametros,
            method: Method.GET,
            body: null,
            headers: headers);
        Utils.LogPrint(config.baseIntegracion??"" + Constants.nivelHospitalario + parametros);

        MyResponse response = await RequestHandler.httpRequest(request);

        if(response.success){
          try{
            data.stop();

            var list = response.response;

            for(var n in list){
              var nivel =  NivelHospitalario.fromJson(n);
              niveles.add(nivel);
            }
           // if(niveles.length == 0){
              Map<String,dynamic> newn = {
                "claveNivelHospitalario" : "0",
                "nivelHospitalario" : "Todos",
                "banContratado" : false,
                "relacion" : "",
                "mensaje" : "Mensaje 0",
              };
              var newnivel = NivelHospitalario.fromJson(newn);
              niveles.add(newnivel);
           // }
            if(Utils.listNiveles != null){
              Utils.listNiveles.clear();
            }
            Utils.listNiveles.addAll(niveles);
            return niveles;

          }catch(json){
            data.stop();
            return [];
          }
        }else{
          data.stop();
          if(Utils.listNiveles != null){
            Utils.listNiveles.clear();
          }
          Map<String,dynamic> newn = {
            "claveNivelHospitalario" : "0",
            "nivelHospitalario" : "Todos",
            "banContratado" : false,
            "relacion" : "",
            "mensaje" : "Mensaje 0",
          };
          var newnivel = NivelHospitalario.fromJson(newn);
          niveles.add(newnivel);

          Utils.listNiveles.addAll(niveles);
          return niveles;
        }
      }else {
        data.stop();
        niveles.addAll(Utils.listNiveles);
        return niveles;
      }

    }catch(e){
      data.stop();
      return [];
    }
  }

  @override
  Future<List<CirculoMedico>> getCirculosM() async {
    if (!await ConnectionManager.isConnected()) {
      customAlert(AlertDialogType.errorConexion, view!.context, "", "");
    }
    return DirectorioSearchInteractor.getCirculosMedicos(
      view!.context,
      Utils.listCirculosFiltros,
    );
  }

  @override
  Future <List<Estados>> getEstados() async{
    if (!await ConnectionManager.isConnected()) {
      customAlert(AlertDialogType.errorConexion, view!.context, "", "");
    }
    final Trace data = FirebasePerformance.instance.newTrace("RedesMedicas_getEstados");
    data.start();
    

    try{
      List<Estados> estados = [];

      if(Utils.listEstados.isEmpty){

        var config = AppConfig.of(view!.context);
        var headers = {
          "apiKey": config?.apiKeyServices??""
        };
        var request = MyRequest(
            baseUrl: config?.baseOSCP??"",
            path: Constants.getEstados,
            method: Method.GET,
            body: null,
            headers: headers);
        MyResponse response = await RequestHandler.httpRequest(request);
        if(response.success) {
          data.stop();
          var list = response.response;
          Utils.LogPrint("ESTADOS: " + list.toString());

          Map<String,dynamic> newe = {
            "claveEstado" : "000",
            "estado" : "Todos"
          };
          var newest = Estados.fromJson(newe);
          estados.add(newest);

          for(var i in list){
            var estado = Estados.fromJson(i);
            estados.add(estado);
          }

          if(Utils.listEstados != null){
            Utils.listEstados.clear();
          }
          Utils.listEstados.addAll(estados);
          getMunicipios(estados[0].claveEstado!);
          return estados;
        } else{
          data.stop();
          return [];
        }
      }else{
        estados.addAll(Utils.listEstados);
        return estados;
      }

    } catch(e){
      data.stop();
      return [];
    }
  }

  @override
  Future<List<Municipios>> getMunicipios(String cvEstado) async{
    if (!await ConnectionManager.isConnected()) {
      customAlert(AlertDialogType.errorConexion, view!.context, "", "");
    }
    final Trace data = FirebasePerformance.instance.newTrace("RedesMedicas_getMunicipios");
    data.start();
    

    try{
      List<Municipios> municipios = [];
      if(Utils.listMunicipiosFiltros.isEmpty){
        var config = AppConfig.of(view!.context);
        var headers = {
          "apiKey": config?.apiKeyServices??""
        };
        var path = Constants.getMunicipios + cvEstado;
        var request = MyRequest(
            baseUrl: config?.baseOSCP??"",
            path: path,
            method: Method.GET,
            body: null,
            headers: headers);
        MyResponse response = await RequestHandler.httpRequest(request);
        if (response.success) {
          data.stop();
          var list = response.response;
          Utils.LogPrint("LISTA: " + list.toString());

            Map<String,dynamic> newm = {
              "claveEstado" : "000",
              "claveMunicipio" : "0",
              "municipio" : "Todos",
              "cp" : ""
            };
            var newmun = Municipios.fromJson(newm);
            municipios.add(newmun);

            for(var i in list){
              var municipio = Municipios.fromJson(i);
              municipios.add(municipio);
            }

            if(Utils.listMunicipiosFiltros != null){
              Utils.listMunicipiosFiltros.clear();
            }
            Utils.listMunicipiosFiltros.addAll(municipios);
            return municipios;

        } else{
          data.stop();
          return [];
        }
      }else{
        municipios.addAll(Utils.listMunicipiosFiltros);
        return municipios;
      }

    }catch(e){
      data.stop();
      return [];
    }
  }

}