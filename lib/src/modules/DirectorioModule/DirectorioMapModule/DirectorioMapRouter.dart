import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/AlertModule/MyDialog.dart';
import 'package:flutter/material.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioMapModule/DirectorioMapContract.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioMapModule/DirectorioMapController.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/AlertModule/GNPDialog.dart';
import 'package:url_launcher/url_launcher.dart';

class DirectorioMapRouter implements DirectorioMapWireFrame {

  DirectorioMapControllerState? view;

  DirectorioMapRouter(DirectorioMapControllerState view){
    this.view = view;
  }

  @override
  void backToHome() {
    Navigator.pop(view!.context);
  }

  @override
  void showAlertC(String title, String message) {
    showCustomDialog(
        context: view!.context,
        builder: (context) =>
            GNPDialog(title: title, description: message, actions: null));
  }

  @override
  void initCall(String telefono) {
    if (telefono.isNotEmpty) {
      var phone = "tel://$telefono";
      canLaunch(phone).then((value) => launch(phone));
    }
  }
}