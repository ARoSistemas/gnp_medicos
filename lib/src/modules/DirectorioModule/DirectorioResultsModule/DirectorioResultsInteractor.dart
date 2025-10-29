import 'dart:convert';
import 'package:agentesgnp/CommonsV2/Widgets/CustomAlerts.dart';
import 'package:agentesgnp/EnvironmentVariablesSetup/app_config.dart';
import 'package:agentesgnp/Functions/ServiceResponseTimeMeasurementManager.dart';
import 'package:agentesgnp/RequestHandler/MyRequest.dart';
import 'package:agentesgnp/RequestHandler/MyResponse.dart';
import 'package:agentesgnp/RequestHandler/RequestHandler.dart';
import 'package:agentesgnp/Modelos/LoginModels.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioResultsModule/DirectorioResultsContract.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioResultsModule/DirectorioResultsController.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioResultsModule/SearchResult.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Clinicas.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Hospitales.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Medicos.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/ModulosGNP.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/OtrosServiciosMedicos.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/Utils.dart';
import 'package:agentesgnp/Utils/ConnectionManager.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/constants.dart'
    as Constants;
import 'package:flutter/cupertino.dart';

class DirectorioResultsInteractor implements DirectorioResultsUseCase {
  DirectorioResultsInteractorOutput? output;
  DirectorioResultsControllerState? view;
  final ServiceResponseTimeMeasurementManager _busqueda =
      ServiceResponseTimeMeasurementManager();
  int _num = 0;
  String nameservice = "";
  bool IMedicos = true;
  bool IHospital = true;
  bool IOtros = true;
  bool IModulos = true;
  bool IClinicas = true;
  bool inicio = true, busqueda = true;

  DirectorioResultsInteractor(DirectorioResultsInteractorOutput output,
      DirectorioResultsControllerState view) {
    this.output = output;
    this.view = view;
  }

  Future<List<SearchResultList>> getHospitalBusqueda(
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
    if (!await ConnectionManager.isConnected()) {
      customAlert(AlertDialogType.errorConexion, view!.context, "", "");
    }
    ResultadoHospitales hospitalesModelo = new ResultadoHospitales();
    List<SearchResultList> listSerch = <SearchResultList>[];
    List<SearchResultList> listSearch = [];

    final Trace data =
        FirebasePerformance.instance.newTrace("RedesMedicas_getHospitalesB");
    data.start();
   

    var config = AppConfig.of(view!.context)!;
    var headers = {"apiKey": config.apiKeyServices??""};
    var body;
    var parametros = "&";
    var nivel = filtros == null ? Utils.cvNivelHosp : claveNivelHospitalario;
    body = {
      "idHospital": idHospital,
      "nombreComercial": nombreComercial,
      "claveEstado": claveEstado,
      "claveMunicipio": claveMunicipio,
      "rfc": rfc,
      "razonSocial": razonSocial,
      "codigoFiliacion": codigoFiliacion,
      "clavePlan": clavePlan,
      "claveLineaComercial": claveLineaComercial,
      "banPlanContratado": banPlanContratado,
      "claveNivelHospitalario": nivel,
      "productoTecnico": productoTecnico,
      "productoComercial": productoComercial,
      "pagina": pagina,
    };

    body.forEach((key, value) => parametros = value != null &&
            value.toString() != "null" &&
            value.toString() != "" &&
            value.toString() != "0" &&
            value.toString() != "000"
        ? parametros + key + "=" + value.toString() + "&"
        : parametros);
    print(parametros);
    parametros = parametros + "?";
    parametros = parametros.replaceAll("&?", "").replaceAll("??", "");
    body = null;

    var request = MyRequest(
        baseUrl: config.baseOSCP??"",
        path: Constants.getHospitales + parametros,
        method: Method.GET,
        body: body.toString(),
        headers: headers);
    Utils.LogPrint("HOSPITALES: " +
        (config.baseOSCP??"") +
        Constants.getHospitales +
        parametros);
    MyResponse response = await RequestHandler.httpRequest(request);

    if (response.success) {
      try {
        data.stop();
        hospitalesModelo = ResultadoHospitales.fromJson(response.response);
        if(hospitalesModelo != null){
          for(int i = 0; i < hospitalesModelo.gruposHospitalarios!.length; i++){
            if(hospitalesModelo.gruposHospitalarios![i].hospitales!.length>0){

            SearchResultList temListItmes = new SearchResultList();
            temListItmes.lista=[];
            temListItmes.etiquetaDeBusqueda = hospitalesModelo.gruposHospitalarios!.elementAt(i).etiquetaGrupoBusqueda;
            final hospitalGroup = hospitalesModelo.gruposHospitalarios!.elementAt(i);
            for(int j = 0; j <hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.length; j++ ){
              final hospital = hospitalGroup.hospitales!.elementAt(j);
              String nivelH = hospital.nivelHospitalarioAbreviado!;
              String acceso = hospital.accesoHospitalario!;
              final nivel = nivelH +
                  (nivelH.isNotEmpty && acceso.isNotEmpty ? '\n' : '') +
                  acceso;
              temListItmes.lista!.add(SearchResult(
                  titulo: hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).nombreComercial != null ? hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).nombreComercial:"",
                  texto:hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).direccionCompleta != null ? hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).direccionCompleta :"",
                  nivel: nivel,
                  tipo:hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).banTipoMensaje != null ? hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).banTipoMensaje : "",
                  alertaTitulo:hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).banTipoMensaje != null ? hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).banTipoMensaje:"",
                  alertaMensaje:hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).mensaje != null ? hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).mensaje : "",
                  telefono:hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).telefonoCompleto != null ?hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).telefonoCompleto:"" ,
                  extension: hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).extensionTelefono != null ? hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).extensionTelefono : "",
                  latitud:hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).latitud != null && hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).latitud != "" ? hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).latitud:"0.0",
                  longitud:hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).longitud != null && hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).longitud != "" ? hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).longitud:"0.0",
                  complemnto: hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).sitioWeb != null ? hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).sitioWeb : "",
                  extra: hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).nivelHospitalarioCompleto != null ? hospitalesModelo.gruposHospitalarios!.elementAt(i).hospitales!.elementAt(j).nivelHospitalarioCompleto : "",
                  subEsp: "",
                  selected: false,
                  registrosTotales: hospitalesModelo.registrosTotales == null ? 0 : hospitalesModelo.registrosTotales,
                  pagActual: hospitalesModelo.pagActual == null ? 0 : hospitalesModelo.pagActual,
                  pagTotales: hospitalesModelo.pagTotales == null ? 0 : hospitalesModelo.pagTotales,
                  alertaConsulta: hospitalesModelo.alertaConsulta == null ? "" : hospitalesModelo.alertaConsulta));
            }
            listSerch.add(temListItmes);
            }
          }
          Utils.cvNivelHosp = "";
          listSearch.addAll(listSerch);
          if (_num > 0 && dateTime != null && inicio) {
	          if (nombreComercial == "" || nombreComercial == null) {
		          nameservice = view!.poliza == "Sin póliza"
                ? "DirectorioHospital-BusquedaNombreAsegurado"
                : "DirectorioHospital-BusquedaPoliza";
            } else {
              nameservice = "DirectorioHospital-BusquedaNombre";
            }
            _busqueda.stop(timeStartSecond: dateTime, nameService: nameservice);
          inicio = false;
          }
          _num = 1;
          return listSerch;
        }
      } catch (json) {
        data.stop();
        print(json.toString());
      }
    } else {
      data.stop();
      return listSerch;
    }
    return [];
  }

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
    if (!await ConnectionManager.isConnected()) {
      customAlert(AlertDialogType.errorConexion, view!.context, "", "");
    }
    ResultadoMedicos medicosModelo = new ResultadoMedicos();
    List<SearchResultList> listSerch = <SearchResultList>[];
    List<SearchResultList> listSearch = [];

    final Trace data =
        FirebasePerformance.instance.newTrace("RedesMedicas_getMedicosB");
    data.start();
    

    var config = AppConfig.of(view!.context)!;
    var headers = {"apiKey": config.apiKeyServices??""};

    var parametros = "?";
    var body = {
      "claveConvenio": claveConvenio,
      "claveCirculoMedico": claveCirculoMedico,
      "banCirculoMedicoContratado": banCirculoMedicoContratado,
      "claveEstado": claveEstado,
      "claveMunicipio": claveMunicipio,
      "claveEspecialidad": claveEspecialidad,
      "nombreMedico": nombreMedico,
      "origen": origen,
      "especialidad": especialidad,
      "pagina": pagina,
    };

    body.forEach((key, value) => parametros = value != null &&
                value.toString() != "null" &&
                value.toString() != "" &&
                value.toString() != "0" &&
                value.toString() != "000" ||
            value.toString() == "false"
        ? parametros + key + "=" + value.toString() + "&"
        : parametros);

    parametros = parametros + "?";
    parametros = parametros.replaceAll("&?", "").replaceAll("??", "");
    Utils.LogPrint(parametros);
    var request = MyRequest(
        baseUrl: config.baseOSCP??"",
        path: Constants.getMedicos + parametros,
        method: Method.GET,
        body: null,
        headers: headers);
    Utils.LogPrint(config.baseOSCP??"" + Constants.getMedicos + parametros);
    MyResponse response = await RequestHandler.httpRequest(request);

    if (response.success) {
      try {
        data.stop();
        medicosModelo = await ResultadoMedicos.fromJson(response.response);
        if(medicosModelo != null){
          for(int i = 0; i < medicosModelo.gruposMedicos!.length; i++){

            SearchResultList temListItmes = new SearchResultList();
            temListItmes.lista=[];
            temListItmes.etiquetaDeBusqueda = medicosModelo.gruposMedicos!.elementAt(i).etiquetaGrupoBusqueda;
            for(int j = 0; j <medicosModelo.gruposMedicos!.elementAt(i).medicos!.length; j++ ){
              final medicGroup = medicosModelo.gruposMedicos!.elementAt(i);
              final medic = medicGroup.medicos!.elementAt(j);
              String cm = medic.circuloMedico!;
              String tng = medic.tabuladorNG!;
              cm = cm.isNotEmpty ? 'CÍRCULO MÉDICO $cm' : '';
              tng = tng.isNotEmpty ? 'TABULADOR MÉDICO $tng' : '';
              String nivel = cm +
                  (cm.isNotEmpty && tng.isNotEmpty ? '\n' : '') +
                  tng;
              temListItmes.lista!.add(SearchResult(
                  titulo: medicosModelo.gruposMedicos!.elementAt(i).medicos!.elementAt(j).nombreConcatenado != null ? medicosModelo.gruposMedicos!.elementAt(i).medicos!.elementAt(j).nombreConcatenado:"",
                  texto:medicosModelo.gruposMedicos!.elementAt(i).medicos!.elementAt(j).direccionCompleta != null ? medicosModelo.gruposMedicos!.elementAt(i).medicos!.elementAt(j).direccionCompleta :"",
                  nivel: nivel,
                  tipo:"",
                  alertaTitulo:"",
                  alertaMensaje:"",
                  telefono:medicosModelo.gruposMedicos!.elementAt(i).medicos!.elementAt(j).telefonoCompleto != null ? medicosModelo.gruposMedicos!.elementAt(i).medicos!.elementAt(j).telefonoCompleto:"" ,
                  extension: medicosModelo.gruposMedicos!.elementAt(i).medicos!.elementAt(j).extensionTelefono != null ? medicosModelo.gruposMedicos!.elementAt(i).medicos!.elementAt(j).extensionTelefono : "",
                  latitud:medicosModelo.gruposMedicos!.elementAt(i).medicos!.elementAt(j).latitud != null && medicosModelo.gruposMedicos!.elementAt(i).medicos!.elementAt(j).latitud != "" ? medicosModelo.gruposMedicos!.elementAt(i).medicos!.elementAt(j).latitud : "0.0",
                  longitud:medicosModelo.gruposMedicos!.elementAt(i).medicos!.elementAt(j).longitud != null && medicosModelo.gruposMedicos!.elementAt(i).medicos!.elementAt(j).longitud != "" ? medicosModelo.gruposMedicos!.elementAt(i).medicos!.elementAt(j).longitud : "0.0",
                  complemnto: medicosModelo.gruposMedicos!.elementAt(i).medicos!.elementAt(j).centroDeAtencion != null ? medicosModelo.gruposMedicos!.elementAt(i).medicos!.elementAt(j).centroDeAtencion : "",
                  extra: medicosModelo.gruposMedicos!.elementAt(i).medicos!.elementAt(j).descripcionMedico != null ? medicosModelo.gruposMedicos!.elementAt(i).medicos!.elementAt(j).descripcionMedico : "",
                  subEsp: medicosModelo.gruposMedicos!.elementAt(i).medicos!.elementAt(j).descripcionsubespecialidad != null ? medicosModelo.gruposMedicos!.elementAt(i).medicos!.elementAt(j).descripcionsubespecialidad : "",
                  selected: false,
                  registrosTotales: medicosModelo.registrosTotales == null ? 0 : medicosModelo.registrosTotales,
                  pagActual: medicosModelo.pagActual == null ? 0 : medicosModelo.pagActual,
                  pagTotales: medicosModelo.pagTotales == null ? 0 : medicosModelo.pagTotales,
                  alertaConsulta: ""));
            }
            listSearch.add(temListItmes);
          }
          listSerch.addAll(listSearch);
          if (_num > 0 && dateTime != null && inicio) {
            if (especialidad == "" || especialidad == null) {
              nameservice = view!.poliza == "Sin póliza"
                  ? "DirectorioMedico-BusquedaNombreAsegurado"
                  : "DirectorioMedico-BusquedaPoliza";
            } else {
              nameservice = "DirectorioMedico-BusquedaEspecialidad";
            }
            _busqueda.stop(timeStartSecond: dateTime, nameService: nameservice);
            inicio = false;
          }
          _num = 1;
          return listSerch;
        } else {
          return [];
        }
      } catch (json) {
        data.stop();
        return [];
      }
    } else {
      data.stop();
      return [];
    }
  }

  Future<List<SearchResultList>> getClinicasBusqueda(
      String? claveGestion,
      String? nombreProveedor,
      String? claveTipoClinica,
      String? descEstado,
      String? descMunicipio,
      int? pagina,
      DateTime? dateTime,
      String? tipoClinica) async {
    if (!await ConnectionManager.isConnected()) {
      customAlert(AlertDialogType.errorConexion, view!.context, "", "");
    }
    ResultadoClinicas clinicasModelo = new ResultadoClinicas();
    List<SearchResultList> listSerch = <SearchResultList>[];
    List<SearchResultList> listSearch = [];

    final Trace data =
        FirebasePerformance.instance.newTrace("RedesMedicas_getClinicasB");
    data.start();
    

    var config = AppConfig.of(view!.context)!;
    
    var headers = {"apiKey": config.apiKeyServices??""};
        var body;

    var parametros = "?";
    body = body = {
      "claveGestion": claveGestion,
      "paramBusqueda": nombreProveedor,
      "claveTipoClinica": tipoClinica, //int
      "claveEstado": descEstado == 'Todos' ? '' : descEstado,
      "claveMunicipio": descMunicipio == 'Todos' ? '' : descMunicipio,
      "origen": "APPAgentes",
      "pagina": pagina,
      'banClinicaCE': 'CE',
    };

    body.forEach((key, value) => parametros = value != null &&
                value.toString() != "null" &&
                value.toString() != "" &&
                value.toString() != "0" &&
                value.toString() != "000" ||
            value.toString() == "false"
        ? parametros + key + "=" + value.toString() + "&"
        : parametros);

    parametros = parametros + "?";
    parametros = parametros.replaceAll("&?", "").replaceAll("??", "");


        var request = MyRequest(
        baseUrl: config.baseOSCP??"",
        path: Constants.getClinicas + parametros,
        method: Method.GET,
        body: null,
        headers: headers);

    MyResponse response = await RequestHandler.httpRequest(request);

    if (response.success) {
      try {
         data.stop();
        clinicasModelo = ResultadoClinicas.fromJson(response.response);
        if(clinicasModelo != null){

          for(int i = 0; i < clinicasModelo.gruposClinicas!.length; i++){

            SearchResultList temListItmes = new SearchResultList();
            temListItmes.etiquetaDeBusqueda = clinicasModelo.gruposClinicas!.elementAt(i).etiquetaGrupoBusqueda;
            temListItmes.lista=[];

            for(int j = 0; j <clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.length; j++ ){
              final cli = clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j);
              final ng = cli.nivelHosptilarioNuevaGama ?? '';
              final ne = cli.nivelHosptilarioNuevoEsquema ?? '';
              final ve = cli.nivelHosptilarioViejoEsquema ?? '';
              final tipoClinica = cli.tipoClinica ?? '';
              List<String>? tags = [];
              if (ve != '') tags.add(ve);
              if (ne != '') tags.add(ne);
              if (ng != '') tags.add(ng);
              if (tipoClinica != '') tags.add(tipoClinica);

              temListItmes.lista!.add(SearchResult(
                  titulo: clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).nombreComercial != null ? clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).nombreComercial:"",
                  texto:clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).direccionCompleta != null ? clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).direccionCompleta :"",
                  nivel: clinicasModelo.gruposClinicas?.elementAt(i).clinicas?.elementAt(j).nivelHospitalarioAbreviado ?? "",
                  tipo:"",
                  alertaTitulo:"",
                  alertaMensaje:"",
                  telefono:clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).telefonoCompleto != null ? clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).telefonoCompleto:"" ,
                  extension: clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).extensionTelefono != null ? clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).extensionTelefono : "",
                  latitud:clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).latitud != null && clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).latitud != "" ? clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).latitud:"0.0",
                  longitud:clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).longitud != null && clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).longitud != "" ? clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).longitud:"0.0",
                  complemnto: clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).tipoClinica != null ? clinicasModelo.gruposClinicas!.elementAt(i).clinicas!.elementAt(j).tipoClinica : "",
                  extra: "",
                  subEsp: "",
                  selected: false,
                  registrosTotales: clinicasModelo.registrosTotales == null ? 0 : clinicasModelo.registrosTotales,
                  pagActual: clinicasModelo.pagActual == null ? 0 : clinicasModelo.pagActual,
                  pagTotales: clinicasModelo.pagTotales == null ? 0 : clinicasModelo.pagTotales,
                  alertaConsulta: "",
                  etiquetas: tags,
              ));
            }
            listSearch.add(temListItmes);
          }
          listSerch.addAll(listSearch);
          if(IClinicas){
             _busqueda.stop(
                 timeStartSecond: dateTime,
                 nameService: "DirectorioClinicas-BusquedaNombre");
                 IClinicas = false;
          }
          // if (_num > 0 && dateTime != null && IClinicas) {
          //   _busqueda.stop(
          //       timeStartSecond: dateTime,
          //       nameService: "DirectorioClinicas-BusquedaNombre");
          //       IClinicas = false;
          // }
          // _num = 1;
          return listSerch;
        }

      } catch (json) {
        data.stop();
        return [];
      }
    } else {
      data.stop();
      return [];
    }
    return [];
  }

  Future<List<SearchResultList>> getOtrosServiciosMedicosBusqueda(
      String? claveGestion,
      String? nombreProveedor,
      String? claveTipoServicio,
      String? claveEstado,
      String? claveMunicipio,
      int? pagina,
      DateTime dateTime) async {
    if (!await ConnectionManager.isConnected()) {
      customAlert(AlertDialogType.errorConexion, view!.context, "", "");
    }
    OtSvMedicos otrosServicosModelo = new OtSvMedicos();
    List<SearchResultList> listSerch = <SearchResultList>[];
    List<SearchResultList> listSearch = [];

    final Trace data = FirebasePerformance.instance
        .newTrace("RedesMedicas_getOtrosServiciosSB");
    data.start();
    

    var config = AppConfig.of(view!.context)!;
    var headers = {"apiKey": config.apiKeyServices??""};
    var body;
    var parametros = "?";
    body = {
      "claveGestion": claveGestion,
      "nombreProveedor": nombreProveedor,
      "claveTipoServicio": claveTipoServicio, //int
      "claveEstado": claveEstado,
      "claveMunicipio": claveMunicipio,
      "origen": "APPAgentes",
      "pagina": pagina,
    };

    body.forEach((key, value) => parametros = value != null &&
                value.toString() != "null" &&
                value.toString() != "" &&
                value.toString() != "0" &&
                value.toString() != "000" ||
            value.toString() == "false"
        ? parametros + key + "=" + value.toString() + "&"
        : parametros);

    parametros = parametros + "?";
    parametros = parametros.replaceAll("&?", "").replaceAll("??", "");

    var request = MyRequest(
        baseUrl: config.baseOSCP??"",
        path: Constants.getSauxs + parametros,
        method: Method.GET,
        body: null,
        headers: headers);

    MyResponse response = await RequestHandler.httpRequest(request);

    if (response.success) {
      try {
        data.stop();
        otrosServicosModelo = await OtSvMedicos.fromJson(response.response);
        if(otrosServicosModelo != null){
          for(int i = 0; i < otrosServicosModelo.serviciosMedicos!.length; i++){

            SearchResultList temListItmes = new SearchResultList();
            temListItmes.lista=[];
            temListItmes.etiquetaDeBusqueda = otrosServicosModelo.serviciosMedicos!.elementAt(i).etiquetaGrupoBusqueda;

            for(int j = 0; j <otrosServicosModelo.serviciosMedicos!.elementAt(i).listaServicios!.length; j++ ){

              temListItmes.lista!.add(SearchResult(
                  titulo: otrosServicosModelo.serviciosMedicos!.elementAt(i).listaServicios!.elementAt(j).nombreComercial != null ? otrosServicosModelo.serviciosMedicos!.elementAt(i).listaServicios!.elementAt(j).nombreComercial:"",
                  texto:otrosServicosModelo.serviciosMedicos!.elementAt(i).listaServicios!.elementAt(j).direccionCompleta != null ? otrosServicosModelo.serviciosMedicos!.elementAt(i).listaServicios!.elementAt(j).direccionCompleta :"",
                  nivel:"",
                  tipo:"",
                  alertaTitulo:"",
                  alertaMensaje:"",
                  telefono:otrosServicosModelo.serviciosMedicos!.elementAt(i).listaServicios!.elementAt(j).telefonoCompleto != null ? otrosServicosModelo.serviciosMedicos!.elementAt(i).listaServicios!.elementAt(j).telefonoCompleto:"" ,
                  extension: otrosServicosModelo.serviciosMedicos!.elementAt(i).listaServicios!.elementAt(j).extensionTelefono != null ? otrosServicosModelo.serviciosMedicos!.elementAt(i).listaServicios!.elementAt(j).extensionTelefono : "",
                  latitud:otrosServicosModelo.serviciosMedicos!.elementAt(i).listaServicios!.elementAt(j).latitud != null && otrosServicosModelo.serviciosMedicos!.elementAt(i).listaServicios!.elementAt(j).latitud !=  "" ? otrosServicosModelo.serviciosMedicos!.elementAt(i).listaServicios!.elementAt(j).latitud:"0.0",
                  longitud:otrosServicosModelo.serviciosMedicos!.elementAt(i).listaServicios!.elementAt(j).longitud != null && otrosServicosModelo.serviciosMedicos!.elementAt(i).listaServicios!.elementAt(j).longitud != "" ? otrosServicosModelo.serviciosMedicos!.elementAt(i).listaServicios!.elementAt(j).longitud:"0.0",
                  complemnto:otrosServicosModelo.serviciosMedicos!.elementAt(i).listaServicios!.elementAt(j).tipoServicio != null ?otrosServicosModelo.serviciosMedicos!.elementAt(i).listaServicios!.elementAt(j).tipoServicio:"",
                  extra: "",
                  subEsp: "",
                  selected: false,
                  registrosTotales: otrosServicosModelo.registrosTotales == null ? 0 : otrosServicosModelo.registrosTotales,
                  pagActual: otrosServicosModelo.pagActual == null ? 0 : otrosServicosModelo.pagActual,
                  pagTotales: otrosServicosModelo.pagTotales == null ? 0 : otrosServicosModelo.pagTotales,
                  alertaConsulta: ""));
            }
            listSearch.add(temListItmes);
          }
          listSerch.addAll(listSearch);

          if(IOtros){
            _busqueda.stop(
                 timeStartSecond: dateTime,
                 nameService: "DirectorioOtrosServicio-BusquedaNombre");
                 IOtros = false;
          }
          // if (_num > 0 && dateTime != null && IOtros) {
          //   _busqueda.stop(
          //       timeStartSecond: dateTime,
          //       nameService: "DirectorioOtrosServicio-BusquedaNombre");
          //       IOtros = false;
          // }
          // _num = 1;
          return listSerch;
        } else {
          return [];
        }
      } catch (json) {
        data.stop();
        return [];
      }
    } else {
      data.stop();
      return [];
    }
  }

  Future<List<SearchResultList>> getModulosBusqueda(
      String? claveEstado, DateTime dateTime) async {
    if (!await ConnectionManager.isConnected()) {
      customAlert(AlertDialogType.errorConexion, view!.context, "", "");
    }

    final Trace data =
        FirebasePerformance.instance.newTrace("RedesMedicas_getModulos");
    data.start();
    

    ResultadosModulosGNP modulosGNP = new ResultadosModulosGNP();
    List<SearchResultList> listSerch = <SearchResultList>[];
    List<SearchResultList> listSearch = [];

    var config = AppConfig.of(view!.context)!;
    var headers = {"apiKey": config.apiKeyServices??""};
    var parametros = "?";
    var body = {"claveEstado": claveEstado};
    body.forEach((key, value) => parametros = value != null &&
                value.toString() != "null" &&
                value.toString() != "" &&
                value.toString() != "0" &&
                value.toString() != "000" ||
            value.toString() == "false"
        ? parametros + key + "=" + value.toString() + "&"
        : parametros);

    parametros = parametros + "?";
    parametros = parametros
        .replaceAll("&?", "")
        .replaceAll("??", "")
        .replaceAll('"', "");

    var request = MyRequest(
        baseUrl: config.baseOSCP??"",
        path: Constants.getModulos + parametros,
        method: Method.GET,
        body: null,
        headers: headers);

    MyResponse response = await RequestHandler.httpRequest(request);

    if (response.success) {
      try {
        data.stop();
        modulosGNP = ResultadosModulosGNP.fromJson(response.response);
        if(modulosGNP != null){

          for(int i = 0; i < modulosGNP.gruposModulos!.length; i++){

            SearchResultList temListItmes = new SearchResultList();
            temListItmes.etiquetaDeBusqueda = modulosGNP.gruposModulos!.elementAt(i).etiquetaGrupoBusqueda;
            temListItmes.lista=[];

            for(int j = 0; j <modulosGNP.gruposModulos!.elementAt(i).modulos!.length; j++ ){

              temListItmes.lista!.add(SearchResult(
                  titulo: modulosGNP.gruposModulos!.elementAt(i).modulos!.elementAt(j).nombreModulo != null ? modulosGNP.gruposModulos!.elementAt(i).modulos!.elementAt(j).nombreModulo:"",
                  texto: modulosGNP.gruposModulos!.elementAt(i).modulos!.elementAt(j).direccionCompleta != null ? modulosGNP.gruposModulos!.elementAt(i).modulos!.elementAt(j).direccionCompleta :"",
                  nivel:"",
                  tipo:"",
                  alertaTitulo:"",
                  alertaMensaje:"",
                  telefono: modulosGNP.gruposModulos!.elementAt(i).modulos!.elementAt(j).telefonoCompleto != null ? modulosGNP.gruposModulos!.elementAt(i).modulos!.elementAt(j).telefonoCompleto:"" ,
                  extension: modulosGNP.gruposModulos!.elementAt(i).modulos!.elementAt(j).extensionTelefono != null ? modulosGNP.gruposModulos!.elementAt(i).modulos!.elementAt(j).extensionTelefono : "",
                  latitud: modulosGNP.gruposModulos!.elementAt(i).modulos!.elementAt(j).latitud != null && modulosGNP.gruposModulos!.elementAt(i).modulos!.elementAt(j).latitud != "" ? modulosGNP.gruposModulos!.elementAt(i).modulos!.elementAt(j).latitud:"0.0",
                  longitud: modulosGNP.gruposModulos!.elementAt(i).modulos!.elementAt(j).longitud != null && modulosGNP.gruposModulos!.elementAt(i).modulos!.elementAt(j).longitud != "" ? modulosGNP.gruposModulos!.elementAt(i).modulos!.elementAt(j).longitud:"0.0",
                  complemnto: modulosGNP.gruposModulos!.elementAt(i).modulos!.elementAt(j).horarioConcatenado != null ? modulosGNP.gruposModulos!.elementAt(i).modulos!.elementAt(j).horarioConcatenado : "",
                  extra: "",
                  subEsp: "",
                  selected: false,
                  registrosTotales: modulosGNP.registrosTotales == null ? 0 : modulosGNP.registrosTotales));
            }
            listSearch.add(temListItmes);
          }
          listSerch.addAll(listSearch);
          if (_num > 0 && dateTime != null && IModulos) {
            _busqueda.stop(
                timeStartSecond: dateTime,
                nameService: "DirectorioModulosGNP-BusquedaEstado");
                IModulos = false;
          }
          _num = 1;
          return listSerch;
        }
      } catch (e) {
        data.stop();
        return [];
      }
    } else {
      data.stop();
      return [];
    }

    return [];
  }
}
