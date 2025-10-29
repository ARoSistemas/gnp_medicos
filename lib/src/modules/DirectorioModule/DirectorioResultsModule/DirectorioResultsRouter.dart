
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioFiltrosModule/DirectorioFiltrosController.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioMapModule/DirectorioMapController.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioResultsModule/DirectorioResultsContract.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioResultsModule/DirectorioResultsController.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioResultsModule/SearchResult.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Entity/Parametros.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/AlertModule/GNPDialogIcon.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/AlertModule/MyDialog.dart';

class DirectorioResultsRouter implements DirectorioResultsWireFrame {

  late DirectorioResultsControllerState view;

  DirectorioResultsRouter(DirectorioResultsControllerState view){
    this.view = view;
  }

  @override
  void backToHome() {
    Navigator.pop(view.context);
  }

  @override
  void openMap(String? title, SearchResult searchResult, String catalogo) {
    Navigator.of(view.context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return DirectorioMapController(title: title, searchResult: searchResult, catalogo: catalogo,);
        }));
  }

  List<DropdownMenuItem<String>> getPolizas() {
    List polizas = ["Sin póliza","00001404824623 Producto Plan","00001404927574","00001404927575"];
    List<DropdownMenuItem<String>> items = [];
    for (String poliza in polizas) {
      items.add(new DropdownMenuItem(value: poliza, child: new Text(poliza)));
    }
    return items;
  }

  @override
  void openFilters(String? servicio,Parametros? parametros, String? catalogo, String? poliza, String? especialidad){
    Navigator.of(view.context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __){
          return DirectorioFiltrosController(servicio: servicio,parametros: parametros, catalogo: catalogo, poliza: poliza, especialidad: especialidad);
        }));
  }

  @override
  void showAlert(String icon, String title, String message) {
    showCustomDialog(
        context: view.context,
        builder: (context) =>
            GNPDialogIcon(icon: icon, title: title, description: message, actions: []));
  }

  @override
  void mostrarAlertaCallBackCustom(String? titulo, String? mensaje, BuildContext context,String buttonText,Function positive) {
    // flutter defined function
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        // return object of type Dialog
        return WillPopScope(
          onWillPop: ()async{
            return false;
          },
          child: AlertDialog(
            title: new Text(titulo!, textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: AppColors.primary700),),
            content: SingleChildScrollView(child: new Text(mensaje!, textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16, color: AppColors.gnpTextSystem),)),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
               Container(
                 child: new Center(
                  child: Row(
                    children: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(8.0)),
                        onPressed: null, child: SizedBox(),
                      ),
                      ButtonTheme(
                        minWidth: 134.0,
                        child: Container(
                          alignment: Alignment.center,
                          child: Row(
                            children: <Widget>[
                              TextButton( //new
                                style: TextButton.styleFrom(
                                  backgroundColor: AppColors.secondary900,
                                  foregroundColor: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: new Text(
                                    buttonText,
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16,),
                                  ),
                                ),
                                onPressed: positive as void Function()?,
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(8.0)),
                        onPressed: null, child: SizedBox(),
                      ),
                    ],
                  ),
              ),
               )
            ],
          ),
        );
      },
    );
  }


}