import 'dart:convert';
import 'package:agentesgnp/CommonsV2/Widgets/CustomAlerts.dart';
import 'package:agentesgnp/EnvironmentVariablesSetup/app_config.dart';
import 'package:agentesgnp/RequestHandler/MyRequest.dart';
import 'package:agentesgnp/RequestHandler/MyResponse.dart';
import 'package:agentesgnp/RequestHandler/RequestHandler.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioMapModule/DirectorioMapContract.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioMapModule/DirectorioMapController.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/Utils.dart';
import 'package:agentesgnp/Utils/ConnectionManager.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/constants.dart'  as Constants;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectorioMapInteractor implements DirectorioMapUseCase {

  DirectorioMapInteractorOutput? output;
  DirectorioMapControllerState? view;

  DirectorioMapInteractor(DirectorioMapInteractorOutput output, DirectorioMapControllerState view) {
    this.output = output;
    this.view = view;
  }

  Future<void> share(LatLng latLng) async {
    if (!await ConnectionManager.isConnected()) {
      customAlert(AlertDialogType.errorConexion, view!.context, "", "");
    }
    var config = AppConfig.of(view!.context);
    await FlutterShare.share(
        title: 'Ubicación de destino', //titulo para correos(asunto)
        text: '',
        linkUrl: config!.shareLocation??"" + latLng.latitude.toString() +','+ latLng.longitude.toString(),
        chooserTitle: 'Compartir ubicación');
  }

  Future sendAnalytics(String seccion, String accion, String lugar, String opcion) async {
    if (!await ConnectionManager.isConnected()) {
      customAlert(AlertDialogType.errorConexion, view!.context, "", "");
    }
    Map<String, String> headers = {"Content-Type": "application/json"};
    Map<String,dynamic> body = new Map<String, dynamic>();

    switch(accion){
      case "Compartir":
        body = {
          "ec": "App Agentes / $seccion",
          "ea": "$lugar",
          "el": accion
        };
        break;
      case "Navegar":
        body = {
          "ec": "App Agentes / $seccion",
          "ea": "$lugar",
          "el": accion
        };
        break;
      case "Ubicación Actual":
        body = {
          "ec": "App Agentes / $seccion",
          "ea": "Mapa",
          "el": accion
        };
        break;
      case "Caminar":
        body = {
          "ec": "App Agentes / $seccion",
          "ea": "$lugar",
          "el": accion
        };
        break;
      case "Conducir":
        body = {
          "ec": "App Agentes / $seccion",
          "ea": lugar,
          "el": accion
        };
        break;
      case "Contactar vía telefónica":
        body = {
          "ec": "App Agentes / $seccion",
          "ea": "$opcion",
          "el": accion
        };
        break;
    }
    var config = AppConfig.of(view!.context);

    var request = MyRequest(
        baseUrl: config?.baseIntegracion??"",
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