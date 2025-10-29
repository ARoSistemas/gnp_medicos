
import 'dart:convert';
import 'package:agentesgnp/CommonsV2/Widgets/CustomAlerts.dart';
import 'package:agentesgnp/EnvironmentVariablesSetup/app_config.dart';
import 'package:agentesgnp/Modelos/LoginModels.dart';
import 'package:agentesgnp/RequestHandler/MyRequest.dart';
import 'package:agentesgnp/RequestHandler/MyResponse.dart';
import 'package:agentesgnp/RequestHandler/RequestHandler.dart';
import 'package:agentesgnp/SolicitudMovimientos/Models/BusquedaNombre/Personas.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioSearchModule/DirectorioSearchContract.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioSearchModule/DirectorioSearchController.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Catalogos.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Clinicas.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Hospitales.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/OtrosServiciosMedicos.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/Utils.dart';
import 'package:agentesgnp/Utils/ConnectionManager.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/constants.dart' as Constants;

class DirectorioSearchInteractor implements DirectorioSearchUseCase {

  DirectorioSearchInteractorOutput? output;
  late DirectorioSearchControllerState view;

  DirectorioSearchInteractor(DirectorioSearchInteractorOutput output, DirectorioSearchControllerState view) {
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

    if(Utils.listPlanes.isEmpty) {
      if(response.success){
        try {
          data.stop();
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

        } catch (e) {
          data.stop();
          return List.empty(growable: true);
        }
      }else{
        data.stop();
        return List.empty(growable: true);
      }
    }else{
      planes.addAll(Utils.listPlanes);
      return planes;
    }
  }

  List<DropdownMenuItem<String>> getPolizas() {
    List polizas = ["Sin póliza","00001404824623","00001404927574","00001404927575"];
    List<DropdownMenuItem<String>> items = List<DropdownMenuItem<String>>.empty(growable: true);
    for (String poliza in polizas as Iterable<String>) {
      items.add(new DropdownMenuItem(value: poliza, child: new Text(poliza)));
    }
    return items;
  }

  @override
  Future<List<CirculoMedico>> getCirculosM() async {
    if (!await ConnectionManager.isConnected()) {
      customAlert(AlertDialogType.errorConexion, view.context, "", "");
    }

    return await getCirculosMedicos(
      view.context,
      Utils.listCirculos,
    );
  }

  static Future<List<CirculoMedico>> getCirculosMedicos(
    BuildContext context,
    List<CirculoMedico> list,
  ) async {
    final Trace data =
    FirebasePerformance.instance.newTrace("RedesMedicas_getCirculosMed");
    data.start();

    var config = AppConfig.of(context)!;
    Map<String, String>? headers = {"apiKey": config.apiKeyServices!};
    var request = MyRequest(
      baseUrl: config.baseOSCP!,
      path: Constants.getCirculoM,
      method: Method.GET,
      body: null,
      headers: headers,
    );

    MyResponse response = await RequestHandler.httpRequest(request);
    List<CirculoMedico> circulosM = [];
    if (list.isEmpty) {
      if (response.success) {
        try {
          data.stop();
          List resList = response.response;
          final resListC = resList
              .map(
                (e) => CirculoMedico.fromJson(e),
          )
              .toList();
          Utils.LogPrint("CIRCULOS: " + resList.toString());

          Map<String, dynamic> newc = {
            "claveCirculoMedico": "0",
            "circuloMedico": "Todos",
          };
          var newcirculo = CirculoMedico.fromJson(newc);
          circulosM.add(newcirculo);

          var tabCircles = resListC
              .where(
                (e) => e.circuloMedico!.length == 1,
          )
              .toList();
          resListC.removeWhere((e) => e.circuloMedico!.length == 1);
          tabCircles.sort(
                (a, b) => a.circuloMedico!.compareTo(b.circuloMedico!),
          );
          tabCircles = tabCircles
              .map(
                (e) => CirculoMedico(
              claveCirculoMedico: e.claveCirculoMedico,
              circuloMedico: 'Nivel de tabulador médico ${e.circuloMedico}',
            ),
          )
              .toList();
          resListC.addAll(tabCircles);
          circulosM.addAll(resListC);
          resList = circulosM;

          return circulosM;
        } catch (e) {
          data.stop();
          return [];
        }
      }
    } else {
      circulosM.addAll(list);
      print("Circulos lista");
      return circulosM;
    }

    return [];
  }

   @override
  Future <List<Especialidad>> getEspecialidades() async {
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
    List<Especialidad> especialidades = List<Especialidad>.empty(growable: true);

    if(Utils.listEspecialidades.isEmpty) {
      if(response.success){
        try {
          data.stop();
          var list = response.response;

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

        } catch (e) {
          data.stop();
          return List.empty(growable: true);
        }
      }
    }else{
      especialidades.addAll(Utils.listEspecialidades);
      return especialidades;
    }
    throw Exception('');
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
    List<TipoClinica> tipoclinicas = List<TipoClinica>.empty(growable: true);

    if(Utils.listEspecialidades.isEmpty) {
      if(response.success){
        try {
          data.stop();
          var list = response.response;
          Utils.LogPrint("TCLINICAS: " + list.toString());

          // Ajustes tipo de clinica.
          for(var n in list){
            var tclinica = TipoClinica.fromJson(n);
            tipoclinicas.add(tclinica);
          }

          if(Utils.listTClinicas != null){
            Utils.listTClinicas.clear();
          }
          Utils.listTClinicas.addAll(tipoclinicas);

          return tipoclinicas;
        } catch (e) {
          data.stop();
          return List.empty(growable: true);
        }
      }
    }else{
      tipoclinicas.addAll(Utils.listTClinicas);
      return tipoclinicas;
    }
    throw Exception('');
  }

  @override
  Future<List<TipoServicios>> getTipoServicio() async{
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
        baseUrl: config.baseOSCP!,
        path: Constants.getTiposServicio,
        method: Method.GET,
        body: null,
        headers: headers);

    MyResponse response = await RequestHandler.httpRequest(request);
    List<TipoServicios> tiposervicios = List<TipoServicios>.empty(growable: true);

    if(Utils.listEspecialidades.isEmpty) {
      if(response.success){
        try {
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
        } catch (e) {
          data.stop();
          return List.empty(growable: true);
        }
      }
    }else{
      tiposervicios.addAll(Utils.listTServicios);
      return tiposervicios;
    }
    throw Exception('');
  }

  List<DropdownMenuItem<String>> getServicios() {
    List servicios = ["Todos","Bomberos", "Gasolineras","Corralones"];
    List<DropdownMenuItem<String>> items = List<DropdownMenuItem<String>>.empty(growable: true);
    for (String servicio in servicios as Iterable<String>) {
      items.add(new DropdownMenuItem(value: servicio, child: new Text(servicio)));
    }
    return items;
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
    List<Estados> estados = List<Estados>.empty(growable: true);

    if(Utils.listEstados.isEmpty) {
      if(response.success){
        try {
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
        } catch (e) {
          data.stop();
          return List.empty(growable: true);
        }
      }
    }else{
      estados.addAll(Utils.listEstados);
      print("Estados lista");
      return estados;
    }
    throw Exception('');
  }

  Future<List<Municipios>> getMunicipios(String cvEstado) async{
    if (!await ConnectionManager.isConnected()) {
      customAlert(AlertDialogType.errorConexion, view.context, "", "");
    }
    final Trace data = FirebasePerformance.instance.newTrace("RedesMedicas_getMunicipios");
    data.start();
    

    var config = AppConfig.of(view.context)!;
    Map<String, String>? headers = {
      "apiKey": config.apiKeyServices!
    };
    var request = MyRequest(
        baseUrl: config.baseOSCP!,
        path: Constants.getMunicipios + cvEstado,
        method: Method.GET,
        body: null,
        headers: headers);

    MyResponse response = await RequestHandler.httpRequest(request);
    List<Municipios> municipios = List<Municipios>.empty(growable: true);

    if(Utils.listMunicipios != null || Utils.listMunicipios.isEmpty ) {
      if(response.success){
        try {
          data.stop();
          var list = response.response;
          Utils.LogPrint("MUNICIPIOS: " + list.toString());

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

          Utils.listMunicipios.addAll(municipios);

          return municipios;
        } catch (e) {
          data.stop();
          return List.empty(growable: true);
        }
      }
    }else{
      municipios.addAll(Utils.listMunicipios);
      return municipios;
    }
    throw Exception('');
  }


  @override
  Future<List<Clinicas>> getClinicasList() async{

    if (!await ConnectionManager.isConnected()) {
      customAlert(AlertDialogType.errorConexion, view.context, "", "");
    }
  final Trace data = FirebasePerformance.instance.newTrace("RedesMedicas_getClinicasList");
  data.start();
  
  var config = AppConfig.of(view.context)!;

  var headers = {
    "apiKey": config.apiKeyServices??""
  };

  var request = MyRequest(
      baseUrl: config.baseIntegracion??"",
      path: Constants.catalogoClinicas,
      method: Method.GET,
      body: null,
      headers: headers);


  MyResponse response = await RequestHandler.httpRequest(request);
  List<Clinicas> clinicasResult = [];

  if(response.success){
        try {
          data.stop();
          var clinicasModelo = ResultadoClinicas.fromJson(response.response);
          if(clinicasModelo != null){
              for(int i = 0; i < clinicasModelo.gruposClinicas!.length; i++){
                for(int j = 0; j <clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.length; j++ ){
                  Clinicas clinicasData = new Clinicas();
                  clinicasData.nombreComercial = clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).nombreComercial != null ? clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).nombreComercial:"";
                  clinicasData.tipoClinica = clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).tipoClinica != null ? clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).tipoClinica: "";
                  clinicasData.claveTipoClinica = clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).claveTipoClinica != null ? clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).claveTipoClinica: "" as int?;
                  clinicasData.cp = clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).cp != null ? clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).cp: "";
                  clinicasData.calleNumero = clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).calleNumero != null ? clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).calleNumero: "";
                  clinicasData.categorizador =  clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).categorizador != null ? clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).categorizador: "" as double?;
                  clinicasData.direccionCompleta = clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).direccionCompleta != null ? clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).direccionCompleta: "";
                  clinicasData.maps = clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).maps != null ? clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).maps: "";

                  clinicasResult.add(clinicasData);

                }
              }
            }
          return clinicasResult;
        } catch (e) {
          data.stop();
          return List.empty(growable: true);
        }
    }
    throw Exception('');
  }

  @override
  Future<List<Hospitales>> getHospitalesList() async{

  if (!await ConnectionManager.isConnected()) {
    customAlert(AlertDialogType.errorConexion, view.context, "", "");
  }

  final Trace data = FirebasePerformance.instance.newTrace("RedesMedicas_getHospitalesList");
  data.start();
  

  var config = AppConfig.of(view.context)!;
  Map<String, String>? headers = {
    "apiKey": config.apiKeyServices!
  };
  var request = MyRequest(
      baseUrl: config.baseOSCP!,
      path: Constants.getHospitales,
      method: Method.GET,
      body: null,
      headers: headers);

  MyResponse response = await RequestHandler.httpRequest(request);
  List<Hospitales> hospitalesResult = [];

  if(response.success){
        try {
          data.stop();
          var hospitalesModelo = ResultadoHospitales.fromJson(response.response);
          if(hospitalesModelo != null){
                 for(int i = 0; i < hospitalesModelo.gruposHospitalarios!.length; i++){
                   for(int j = 0; j <hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.length; j++ ){
                     hospitalesResult.add(hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j));
                   }
                 }
               }
          return hospitalesResult;
        } catch (e) {
          data.stop();
          return List.empty(growable: true);
        }
    }else{
      data.stop();
      return List.empty(growable: true);
    }
  }

  Future <List <OtServiciosM>> getOtrosServiciosMedicosList() async{
    final Trace data = FirebasePerformance.instance.newTrace("RedesMedicas_getOtrosServiciosMedicos");
    data.start();
    

    var config = AppConfig.of(view.context)!;
    Map<String, String>? headers = {
      "apiKey": config.apiKeyServices!
    };
    
    var request = MyRequest(
        baseUrl: config.baseOSCP!,
        path: Constants.getSauxs,
        method: Method.GET,
        body: null,
        headers: headers);

    MyResponse response = await RequestHandler.httpRequest(request);
    OtSvMedicos otrosServicosModelo = new OtSvMedicos();
    List <OtServiciosM> resultList = [];
    if(response.success){
      try{
        data.stop();
        otrosServicosModelo = await OtSvMedicos.fromJson(response.response);
        if(otrosServicosModelo != null){
          for(int i = 0; i < otrosServicosModelo.serviciosMedicos!.length; i++){
            for(int j = 0; j <otrosServicosModelo.serviciosMedicos!.elementAt(i).listaServicios!.length; j++ ){
              resultList.add(otrosServicosModelo.serviciosMedicos!.elementAt(i).listaServicios!.elementAt(j));
            }
          }
          //listSerch.addAll(listSearch);
          return resultList;
        }else{
          return List.empty(growable: true);
        }
      }catch(json){
        data.stop();
        return List.empty(growable: true);
      }
    }else{
      data.stop();
      return List.empty(growable: true);
    }
  }

  Future<List<Personas>> getPersonasPoliza(String name) async {

    final Trace data = FirebasePerformance.instance.newTrace("RedesMedicas_getPersonasPoliza");
    data.start();
    

    var config = AppConfig.of(view.context)!;
    Map<String, String>? headers = {
      "x-api-key": config.h107_Api_Key_Busqueda_Nombre!,
      "Content-Type": 'application/json'
    };
    var request = MyRequest(
        baseUrl: config.serviceBCA!,
        path: Constants.busquedaPorNombre,
        method: Method.POST,
        body: json.encode({
          'codIntermediario':datosPerfilador!.intermediarios, //["0053885001"],
          'nombreCliente': name
        }),
        headers: headers);

    List<Personas> polizasPerson = [];    

    MyResponse response = await RequestHandler.httpRequest(request);

    if (Utils.listPersonasPoliza.isEmpty) {
      if(response.success){
        try{
          data.stop();

          var list = response.response;
          for(var n in list){
            var persona = Personas.fromJson(n);
            polizasPerson.add(persona);
          }

  
          if(Utils.listPersonasPoliza != null){
            Utils.listPersonasPoliza.clear();
          }
          Utils.listPersonasPoliza.addAll(polizasPerson);
          return polizasPerson;

        }catch(json){
          data.stop();
          customAlert(AlertDialogType.errorBuscarPorCliente, view.context, "No se encontraron resultados", "Verifica que los datos ingresados estén correctos y vuelve a realizar tu búsqueda.");
          return List.empty(growable: true);
        }
      }else{
        data.stop();
        return List.empty(growable: true);
      }
    }else{
      polizasPerson.addAll(Utils.listPersonasPoliza);
      return polizasPerson;
    }
  }
  



   Future<List<PolizasUsuario>> getPolizaSearch(String poliza) async {
     if (!await ConnectionManager.isConnected()) {
       customAlert(AlertDialogType.errorConexion, view.context, "", "");
     }

    final Trace data = FirebasePerformance.instance.newTrace("RedesMedicas_getPolizaSearch");
    data.start();
    

    var results = List<PolizasUsuario>.empty(growable: true);
    var config = AppConfig.of(view.context)!;
    Map<String, String>? headers = {
      "apikey": config.h107_Api_Key_Busqueda_Cartera_Cliente!,
      "Content-Type": 'application/json'
    };
    var request = MyRequest(
        baseUrl: config.urlPoliza!,//urlNotifierService,
        path: Constants.busquedaPorPoliza,
        method: Method.POST,
        body: json.encode({"codIntermediario":datosPerfilador!.intermediarios,//["0053885001"],
          "data": {
            "numPoliza": poliza,
            "cveRol": ["TOM"],
            "cveSistema": "INFO",
            "cveEstadoPoliza": "A"
          }}),
        headers: headers);

    MyResponse response = await RequestHandler.httpRequest(request);

    if (Utils.listPolizasSearch.isEmpty) {
      if(response.success){
        try{
          data.stop();
          var cveCliente = response.response["clientes"][0]["clienteUnico"] ?? "";
          var nombre;
          if(response.response["clientes"][0]["tipoParticipante"] == "F"){
             nombre = response.response["clientes"][0]["nombres"] ?? "";
          }else{
             nombre = response.response["clientes"][0]["razonSocial"] ?? "";
          }
          var apellidoPaterno = response.response["clientes"][0]["apellidoPaterno"] ?? "";
          var apellidoMaterno = response.response["clientes"][0]["apellidoMaterno"] ?? "";
          List.empty(growable: true); headers = {
            "apikey": config.h107_Api_Key_Busqueda_Cartera_Cliente!,
            "Content-Type": 'application/json'
          };
          var request = MyRequest(
              baseUrl: config.urlPoliza!,//urlNotifierService,
              path: Constants.busquedaPorCliente,
              method: Method.POST,
              body: json.encode({"codIntermediario":datosPerfilador!.intermediarios, //["0053885001"],
                "data":{"clienteUnico":cveCliente}}),
              headers: headers);

          response = await RequestHandler.httpRequest(request);

          if (Utils.listPolizasSearch.isEmpty) {
            if(response.success){
              try{
                data.stop();
                //var results = List<PolizasUsuario>();

                List list = (response.response["polizasGmm"]["polizas"]);
                for (var objectGmm in list) {
                  var polizasUsuarioData = PolizasUsuario();
                  if(poliza == objectGmm["numPoliza"]){
                    polizasUsuarioData.numPoliza = objectGmm["numPoliza"] ?? "";
                    polizasUsuarioData.circuloMedico = objectGmm["circuloMedico"] ?? "";
                    polizasUsuarioData.planComercial = objectGmm["planComercial"] != null ? objectGmm["planComercial"] : "   ";
                    polizasUsuarioData.cvePlanComercial = objectGmm["cvePlanComercial"] ?? "";
                    polizasUsuarioData.cveCirculoMedico = objectGmm["cveCirculoMedico"] ?? "";
                    polizasUsuarioData.cveProdComercial = objectGmm["cveProdComercial"] ?? "";
                    polizasUsuarioData.cveProdTecnico = objectGmm["cveProdTecnico"] ?? "";
                    polizasUsuarioData.nombres = nombre;
                    polizasUsuarioData.apePaterno = apellidoPaterno;
                    polizasUsuarioData.apeMaterno = apellidoMaterno;
                    results.add(polizasUsuarioData);
                  }
                }

                if(Utils.listPolizaUsuarios != null){
                  Utils.listPolizaUsuarios.clear();
                }

                Utils.listPolizaUsuarios.addAll(results);
                return results;

              }catch(json){
                data.stop();
                return List.empty(growable: true);
              }
            }else{
              data.stop();
              return List.empty(growable: true);
            }
          }

          return results;

        }catch(json){
          data.stop();
          return List.empty(growable: true);
        }
      }else{
        data.stop();
        return List.empty(growable: true);
      }
    }
    throw Exception('');
  }

  Future<List<PolizasUsuario>> getPolizasClienteSearch(String cliente) async {
    final Trace data = FirebasePerformance.instance.newTrace("RedesMedicas_getPolizasClienteSearch");
    data.start();
    

    var config = AppConfig.of(view.context)!;
    Map<String, String>? headers = {
      "apikey": config.h107_Api_Key_Busqueda_Cartera_Cliente!,
      "Content-Type": 'application/json'
    };
    var request = MyRequest(
        baseUrl: config.urlPoliza!,//urlNotifierService,
        path: Constants.busquedaPorCliente,
        method: Method.POST,
        body: json.encode({"codIntermediario": datosPerfilador!.intermediarios,//["0053885001"],
          "data":{"clienteUnico":cliente}}),
        headers: headers);

    MyResponse response = await RequestHandler.httpRequest(request);

    if (Utils.listPolizasSearch.isEmpty) {
      if(response.success){
        try{
          data.stop();
          List<PolizasUsuario> polizasPerson = [];

          List list = (response.response["polizasGmm"]["polizas"]);
          for (var objectGmm in list) {
            var polizasUsuarioData = PolizasUsuario();
            polizasUsuarioData.numPoliza = objectGmm["numPoliza"] ?? "";
            polizasUsuarioData.circuloMedico = objectGmm["circuloMedico"] ?? "";
            polizasUsuarioData.planComercial = objectGmm["planComercial"] != null ? objectGmm["planComercial"] : "   ";
            polizasUsuarioData.cvePlanComercial = objectGmm["cvePlanComercial"] ?? "";
            polizasUsuarioData.cveCirculoMedico = objectGmm["cveCirculoMedico"] ?? "";
            polizasUsuarioData.cveProdComercial = objectGmm["cveProdComercial"] ?? "";
            polizasUsuarioData.cveProdTecnico = objectGmm["cveProdTecnico"] ?? "";
            polizasUsuarioData.nombres = "";
            polizasUsuarioData.apePaterno = "";
            polizasUsuarioData.apeMaterno = "";
            polizasPerson.add(polizasUsuarioData);
          }

          if(list.length == 0){
            var polizasUsuarioData = PolizasUsuario();
            polizasUsuarioData.nombres = "NA";
            polizasUsuarioData.apePaterno = "NA";
            polizasUsuarioData.apeMaterno = "NA";
            polizasUsuarioData.numPoliza = "Sin póliza";
            polizasUsuarioData.circuloMedico = "NA";
            polizasUsuarioData.planComercial = "NA";
            polizasUsuarioData.cvePlanComercial = "NA";
            polizasUsuarioData.cveCirculoMedico = "NA";
            polizasUsuarioData.cveProdComercial = "NA";
            polizasUsuarioData.cveProdTecnico = "NA";
            polizasPerson.add(polizasUsuarioData);
            
            customAlert(AlertDialogType.sinResultados, view.context, "", "");
          }

          if(Utils.listPolizaUsuarios != null){
            Utils.listPolizaUsuarios.clear();
          }

          Utils.listPolizaUsuarios.addAll(polizasPerson);

          return polizasPerson;

        }catch(json){
          data.stop();
          return List.empty(growable: true);
        }
      }else{
        data.stop();
        return List.empty(growable: true);
      }
    }
    throw Exception('');
  }

  @override
  Future<List<NivelHospitalario>> getNivelHospitalario(bool contratado, String plan, String clavePlan, String productoTecnico, String productoComercial) async{
    if (!await ConnectionManager.isConnected()) {
      customAlert(AlertDialogType.errorConexion, view.context, "", "");
    }
    final Trace data = FirebasePerformance.instance.newTrace("RedesMedicas_getNivelHosp");
    data.start();
    

    try{
      List<NivelHospitalario> niveles = List<NivelHospitalario>.empty(growable: true);

        var config = AppConfig.of(view.context)!;
        Map<String, String>? headers = {
          "apiKey": config.apiKeyServices!
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
            baseUrl: config.baseIntegracion!,
            path: Constants.nivelHospitalario + parametros,
            method: Method.GET,
            body: null,
            headers: headers);
        Utils.LogPrint(config.baseIntegracion! + Constants.nivelHospitalario + parametros);

        MyResponse response = await RequestHandler.httpRequest(request);

        if(response.success){
          try{
            data.stop();

            var list = response.response;

            for(var n in list){
              var nivel =  NivelHospitalario.fromJson(n);
              niveles.add(nivel);
            }
            if(Utils.listNiveles != null){
              Utils.listNiveles.clear();
            }
          //  if(niveles.length == 0){
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
            Utils.listNiveles.addAll(niveles);
            return niveles;

          }catch(json){
            data.stop();
            return List.empty(growable: true);
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

    }catch(e){
      data.stop();
      return List.empty(growable: true);
    }
  }

  Future sendAnalytics(String seccion, String opcion1, String opcion2, String estado, String municipio, String poliza) async {
    if (!await ConnectionManager.isConnected()) {
      customAlert(AlertDialogType.errorConexion, view.context, "", "");
    }

    Map<String, String> headers = {"Content-Type": "application/json"};
    Map<String,dynamic> body = new Map<String, dynamic>();

    if(poliza == "Sin póliza" || poliza == ""){
      poliza = "N/A";
    }

    if(opcion1.contains("NA - contratado")){
      opcion1 = "N/A";
    }
    List bodies = List.empty(growable: true);
    List mapas = List.empty(growable: true);
    var request;
    switch(seccion){

      case "Médicos":
        Map<String,dynamic> body1 = {
          "ec": "App Agentes / $seccion",
          "ea": "Póliza",
          "el": "$poliza"
        };
        mapas.add(body1);
        Map<String,dynamic> body2 = {
          "ec": "App Agentes / $seccion",
          "ea": "Círculo Médico",
          "el": "$opcion1"
        };
        mapas.add(body2);
        Map<String,dynamic> body3 = {
          "ec": "App Agentes / $seccion",
          "ea": "Especialidad: $opcion2",
          "el": "Estado: $estado / Municipio: $municipio"
        };
        mapas.add(body3);
        bodies.addAll(mapas);
        break;
      case "Hospitales":
        body = {
          "ec": "App Agentes / $seccion",
          "ea": "Plan hospitalario",
          "el": "$opcion1" //Estado: $estado / Municipio: $municipio
        };
        mapas.add(body);
        body = {
          "ec": "App Agentes / $seccion",
          "ea": "Póliza",
          "el": "$poliza"
        };
        mapas.add(body);
        bodies.addAll(mapas);
        break;
      case "Clínicas":
        body = {
          "ec": "App Agentes / $seccion",
          "ea": "Tipo clínica $opcion1",
          "el": "Estado: $estado / Municipio: $municipio"
        };
        break;
      case "Otros servicios de salud":
        body = {
          "ec": "App Agentes / $seccion",
          "ea": "Tipo servicio de salud: $opcion1",
          "el": "Estado: $estado / Municipio: $municipio"
        };
        break;
      case "Módulos GNP":
        body = {
          "ec": "App Agentes / $seccion",
          "ea": "Estado: $estado",
          "el": "Municipio: $municipio"
        };
        break;

    }
    var config = AppConfig.of(view.context);

    if(seccion == "Médicos" || seccion == "Hospitales"){
      for(int i=0; i<bodies.length; i++){
        request = MyRequest(
            baseUrl: config!.baseIntegracion!,
            path: Constants.apiclient,
            method: Method.POST,
            body: json.encode(bodies[i]),
            headers: headers);

        MyResponse response = await RequestHandler.httpRequest(request);
        if(response.success) {
          Utils.LogPrint(response.response);
        }else{
          Utils.LogPrint(response.response);
        }
      }
    }else{
      request = MyRequest(
          baseUrl: config!.baseIntegracion!,
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


}