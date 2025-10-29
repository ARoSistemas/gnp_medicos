
import 'dart:convert';

import 'package:agentesgnp/CommonsV2/Widgets/CustomAlerts.dart';
import 'package:agentesgnp/EnvironmentVariablesSetup/app_config.dart';
import 'package:agentesgnp/Modelos/LoginModels.dart';
import 'package:agentesgnp/RequestHandler/MyRequest.dart';
import 'package:agentesgnp/RequestHandler/MyResponse.dart';
import 'package:agentesgnp/RequestHandler/RequestHandler.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioContract.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioController.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Catalogos.dart';
import 'package:agentesgnp/Utils/ConnectionManager.dart';
import 'package:firebase_performance/firebase_performance.dart';
import '../DirectorioModule/Utils/constants.dart' as Constants;
import 'DirectorioSearchModule/DirectorioSearchInteractor.dart';
import 'Utils/Utils.dart';

class DirectorioInteractor implements DirectorioUseCase {

  DirectorioInteractorOutput? output;
  late DirectorioControllerState view;

  DirectorioInteractor(DirectorioInteractorOutput output, DirectorioControllerState view) {
    this.output = output;
    this.view = view;
  }

  @override
  Future<List<Planes>> getPlanes() async {
    if (!await ConnectionManager.isConnected()) {
      customAlert(AlertDialogType.errorConexion, view.context, "", "");
    }
    final Trace data = FirebasePerformance.instance.newTrace("RedesMedicas_getPlanes");
    data.start();
    

    var config = AppConfig.of(view.context)!;
    Map<String, String>? headers = {
      "apiKey": config.apiKeyServices!
    };
    var request = MyRequest(
        baseUrl: config.baseOSCP!,
        path: Constants.getPlanes,
        method: Method.GET,
        body: null,
        headers: headers);

    MyResponse response = await RequestHandler.httpRequest(request);

    List<Planes> planes = List.empty(growable: true);

    if(Utils.listPlanes.isEmpty){
      if(response.success){
        try{
          var list = response.response;
          Utils.LogPrint("PLANES: " + list.toString());

          Map<String,dynamic> newp = {
            "clavePlan" : "",
            "plan" : "Todos",
          };
          var newplan = Planes.fromJson(newp);
          planes.add(newplan);

          for(var n in list){
            var plan =  Planes.fromJson(n);
            planes.add(plan);
          }

          if(Utils.listPlanes != null){
            Utils.listPlanes.clear();
          }
          Utils.listPlanes.addAll(planes);
          return planes;

        }catch(json){
          data.stop();
          return new List.empty(growable: true);
        }
      }else{
        data.stop();
        return new List.empty(growable: true);
      }
    }else{
      planes.addAll(Utils.listPlanes);
      return planes;
    }
  }

  @override
  Future<List<CirculoMedico>> getCirculosM() async {
    if (!await ConnectionManager.isConnected()) {
      customAlert(AlertDialogType.errorConexion, view.context, "", "");
    }

    return await DirectorioSearchInteractor.getCirculosMedicos(
      view.context,
      Utils.listCirculos,
    );
  }

  @override
  Future<List<Especialidad>> getEspecialidades() async {
    if (!await ConnectionManager.isConnected()) {
      customAlert(AlertDialogType.errorConexion, view.context, "", "");
    }
    final Trace data = FirebasePerformance.instance.newTrace("RedesMedicas_getEspecialidades");
    data.start();
    

    var config = AppConfig.of(view.context)!;
    Map<String, String>? headers = {
      "apiKey": config.apiKeyServices!
    };
    var request = MyRequest(
        baseUrl: config.baseOSCP!,
        path: Constants.getEspecialidad,
        method: Method.GET,
        body: null,
        headers: headers);

    MyResponse response = await RequestHandler.httpRequest(request);

    List<Especialidad> especialidades = List.empty(growable: true);

    if (Utils.listEspecialidades.isEmpty) {
      if(response.success){
        try{
          data.stop();
          List<Especialidad> especialidades = List.empty(growable: true);

          var list = response.response;
          Utils.LogPrint("ESPECIALIDADES Directorio: " + list.toString());


          Map<String,dynamic> newes = {
            "claveEspecialidad": "0",
            "especialidad" : "Todos"

          };
          var newesp = Especialidad.fromJson(newes);
          especialidades.add(newesp);

          for(var n in list){
            var especialidad = Especialidad.fromJson(n);
            especialidades.add(especialidad);
          }
          if(Utils.listEspecialidades != null){
            Utils.listEspecialidades.clear();
          }
          Utils.listEspecialidades.addAll(especialidades);
          return especialidades;

        }catch(json){
          data.stop();
          return new List.empty(growable: true);
        }
      }else{
        data.stop();
        return new List.empty(growable: true);
      }
    }else{
      especialidades.addAll(Utils.listEspecialidades);
      return especialidades;
    }
  }

  @override
  Future<List<TipoClinica>> getClinicas() async{
    if (!await ConnectionManager.isConnected()) {
      customAlert(AlertDialogType.errorConexion, view.context, "", "");
    }
    final Trace data = FirebasePerformance.instance.newTrace("RedesMedicas_getClinicas");
    data.start();
    

    var config = AppConfig.of(view.context)!;
    Map<String, String>? headers = {
      "apiKey": config.apiKeyServices!
    };
    var request = MyRequest(
        baseUrl: config.baseIntegracion!,
        path: Constants.getTiposClinicas,
        method: Method.GET,
        body: null,
        headers: headers);

    MyResponse response = await RequestHandler.httpRequest(request);

    List<TipoClinica> tipoclinicas = List.empty(growable: true);

    if (Utils.listTClinicas.isEmpty) {
      if(response.success){
        try{
          data.stop();
          List<TipoClinica> tipoclinicas = List.empty(growable: true);

          var list = response.response;
          Utils.LogPrint("TCLINICAS: " + list.toString());

          for(var n in list){
            var tclinica = TipoClinica.fromJson(n);
            tipoclinicas.add(tclinica);
          }

          if(Utils.listTClinicas != null){
            Utils.listTClinicas.clear();
          }
          Utils.listTClinicas.addAll(tipoclinicas);
          return tipoclinicas;

        }catch(json){
          data.stop();
          return new List.empty(growable: true);
        }
      }else{
        data.stop();
        return new List.empty(growable: true);
      }
    }else{
      tipoclinicas.addAll(Utils.listTClinicas);
      return tipoclinicas;
    }
  }

  @override
  Future<List<TipoServicios>> getTipoServicio() async{
    if (!await ConnectionManager.isConnected()) {
      customAlert(AlertDialogType.errorConexion, view.context, "", "");
    }
    final Trace data = FirebasePerformance.instance.newTrace("RedesMedicas_getTiposServicio");
    data.start();
    

    Map<String, String>? headers = {
      "apiKey": mainConfiguration!.apiKeyServices!
    };
    var request = MyRequest(
        baseUrl: mainConfiguration!.baseOSCP!,
        path: Constants.getTiposServicio,
        method: Method.GET,
        body: null,
        headers: headers);

    MyResponse response = await RequestHandler.httpRequest(request);

    List<TipoServicios> tiposervicios = List.empty(growable: true);

    if (Utils.listTServicios.isEmpty) {
      if(response.success){
        try{
          data.stop();

          var list = response.response;
          Utils.LogPrint("TSERVICIOS: " + list.toString());

          Map<String,dynamic> newts = {
            "claveTipoProveedor" : 0,
            "tipoProveedor" : "Todos"
          };
          var newtserv = TipoServicios.fromJson(newts);
          tiposervicios.add(newtserv);

          for(var i in list){
            var tservicios = TipoServicios.fromJson(i);
            tiposervicios.add(tservicios);
          }

          if(Utils.listTServicios != null){
            Utils.listTServicios.clear();
          }
          Utils.listTServicios.addAll(tiposervicios);
          return tiposervicios;

        }catch(json){
          data.stop();
          return new List.empty(growable: true);
        }
      }else{
        data.stop();
        return new List.empty(growable: true);
      }
    }else{
      tiposervicios.addAll(Utils.listTServicios);
      return tiposervicios;
    }
  }

  @override
  Future <List<Estados>> getEstados() async{
    if (!await ConnectionManager.isConnected()) {
      customAlert(AlertDialogType.errorConexion, view.context, "", "");
    }
    final Trace data = FirebasePerformance.instance.newTrace("RedesMedicas_getEstados");
    data.start();
    

    var config = AppConfig.of(view.context)!;
    Map<String, String>? headers = {
      "apiKey": config.apiKeyServices!
    };
    var request = MyRequest(
        baseUrl: config.baseOSCP!,
        path: Constants.getEstados,
        method: Method.GET,
        body: null,
        headers: headers);

    MyResponse response = await RequestHandler.httpRequest(request);
    List<Estados> estados =  List.empty(growable: true);

    if(Utils.listEstados.isEmpty){
      if(response.success) {
        try {
          data.stop();

          var list = response.response;
          Utils.LogPrint("ESTADOS Directorio: " + list.toString());

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
        } catch (json) {
          data.stop();
          return new  List.empty(growable: true);
        }
      }else{
        data.stop();
        return new  List.empty(growable: true);
      }
    }else{
      estados.addAll(Utils.listEstados);
      return estados;
    }
  }

  @override
  Future<List<Municipios>> getMunicipios(String cvEstado) async{

    final Trace data = FirebasePerformance.instance.newTrace("RedesMedicas_getMunicipios");
    data.start();
    

    var config = AppConfig.of(view.context)!;
    Map<String, String>? headers = {
      "apiKey": config.apiKeyServices!
    };
    var path = Constants.getMunicipios + cvEstado;
    var request = MyRequest(
        baseUrl: config.baseOSCP!,
        path: path,
        method: Method.GET,
        body: null,
        headers: headers);

    MyResponse response = await RequestHandler.httpRequest(request);

    List<Municipios> municipios = List.empty(growable: true);
    if(Utils.listMunicipios.isEmpty){
      if(response.success) {
        try {
          data.stop();
          var list = response.response;
          Utils.LogPrint("MUNICIPIOS directorio: " + list.toString());

          Map<String,dynamic> newm = {
            "claveEstado" : "000",
            "claveMunicipio" : "0",
            "municipio" : "Todos",
            "cp" : "0"
          };
          var newmun = Municipios.fromJson(newm);
          municipios.add(newmun);

          for(var i in list){
            var municipio = Municipios.fromJson(i);
            municipios.add(municipio);
          }

          if(Utils.listMunicipios != null){
            Utils.listMunicipios.clear();
          }
          Utils.listMunicipios.addAll(municipios);
          return municipios;
        } catch (json) {
          data.stop();
          return new List.empty(growable: true);
        }
      }else{
        data.stop();
        return new  List.empty(growable: true);
      }
    }else{
      municipios.addAll(Utils.listMunicipios);
      return municipios;
    }
  }


  Future<List<SubEspecialidad>> getSubEspecialidades() async {
    final Trace data = FirebasePerformance.instance.newTrace("RedesMedicas_getSubEspecialidades");
    data.start();
    

    var config = AppConfig.of(view.context)!;
    Map<String, String>? headers = {
      "apiKey": config.apiKeyServices!
    };
    var request = MyRequest(
        baseUrl: config.baseOSCP!,
        path: Constants.getSubEspecialidad,
        method: Method.GET,
        body: null,
        headers: headers);

    MyResponse response = await RequestHandler.httpRequest(request);

    List<SubEspecialidad> subEspecialidades =  List.empty(growable: true);

    if (Utils.listSubEspecialidades.isEmpty) {
      if(response.success){
        try{
          data.stop();
          List<SubEspecialidad> subEspecialidades = List.empty(growable: true);

          var list = response.response;

          for(var n in list){
            var especialidadData = SubEspecialidad.fromJson(n);
            subEspecialidades.add(especialidadData);
          }
          if(Utils.listSubEspecialidades != null){
            Utils.listSubEspecialidades.clear();
          }
          Utils.listSubEspecialidades.addAll(subEspecialidades);
          return subEspecialidades;

        }catch(json){
          data.stop();
          return new  List.empty(growable: true);
        }
      }else{
        data.stop();
        return new  List.empty(growable: true);
      }
    }else{
      subEspecialidades.addAll(Utils.listSubEspecialidades);
      return subEspecialidades;
    }
  }

  Future sendAnalytics(String opcion) async{

    Map<String, String> headers = {"Content-Type": "application/json"};

    Map<String,dynamic> body = {
      "ec": "App Agentes / $opcion",
      "ea": "Click directorio",
      "el": "visita"
    };

    var config = AppConfig.of(view.context)!;

    var request = MyRequest(
        baseUrl: config.baseIntegracion!,
        path: Constants.apiclient,
        method: Method.POST,
        body: json.encode(body),
        headers: headers);

    MyResponse response = await RequestHandler.httpRequest(request);
    if(response.success) {
      Utils.LogPrint(response.response);
    }else{
      Utils.LogPrint(response.response);
    }
  }
}