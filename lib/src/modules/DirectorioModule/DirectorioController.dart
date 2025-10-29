
import 'package:agentesgnp/Functions/Analytics.dart';
import 'package:agentesgnp/Functions/ServiceResponseTimeMeasurementManager.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioContract.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioPresenter.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/AppColors.dart';
import 'package:flutter/material.dart';

import 'Utils/Utils.dart';

class DirectorioController extends StatefulWidget {
  DirectorioController({Key? key}) : super(key: key);

  @override
  DirectorioControllerState createState() => DirectorioControllerState();
}

class DirectorioControllerState extends State<DirectorioController>
    implements DirectorioView {
  late DirectorioPresenter presenter;
  Widget currentContent = Scaffold();
  bool visibleTabs = true;
  bool colorM = false;
  bool colorH = false;
  bool colorC = false;
  bool colorOt = false;
  bool colorMod = false;
  late DateTime dateTime;

  final ServiceResponseTimeMeasurementManager _directorioTime =
      new ServiceResponseTimeMeasurementManager();

  DirectorioControllerState() {
    this.presenter = DirectorioPresenter(this);
  }

  @override
  void initState() {
    _directorioTime.start("DirectorioGMM-PantallaInicio");
    super.initState();
    setState(() {
      colorM = false;
      colorH = false;
      colorC = false;
      colorOt = false;
      colorMod = false;
    });
    AnalyticsServices().sendTag('Directorio_Page');
    if (Utils.permissions == false) {
      presenter.requestLocationPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Utils.listEstados.isEmpty) {
      presenter.getEstados().then((value) => presenter
          .getMunicipios(Utils.listEstados[0].claveEstado!)
          .then((value) =>
              presenter.getCirculosM().then((value) => print("exito"))));
      presenter.getPlanes().then((value) => presenter.getClinicas().then(
          (value) => presenter
              .getTipoServicio()
              .then((value) => presenter.getEspecialidades())));
    }
    return getDirectorioMenu();
  }

  DefaultTabController getDirectorioMenu() {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.orange),
            title: Text(
              "Directorio",
              style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.dirTextColor),
            ),
            elevation: 0.0,
            surfaceTintColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                presenter.backToHome();
              },
            ),
          ),
          body: WillPopScope(
              onWillPop: () async {
                Navigator.pop(context);
                return false;
              },
              child: getBody()),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ));
  }

  ListView getBody() {
    if (context.findRenderObject() == null) {
      Future(_runsAfterBuild);
    }
    return ListView(
      children: [
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: colorM ? AppColors.secondary900 : AppColors.boxShadow,
                blurRadius: 10.0,
                spreadRadius: -22.0,
                offset: Offset(0.0, 1.5))
          ]),
          child: Card(
            margin: EdgeInsets.all(16.0),
            child: ListTile(
              onTap: () {
                setState(() {
                  colorM = true;
                  colorH = false;
                  colorC = false;
                  colorOt = false;
                  colorMod = false;
                  dateTime = DateTime.now();
                });

                Future.delayed(Duration(milliseconds: 500));
                presenter
                    .sendAnalytics("Médicos")
                    .then((value) => presenter.showMedicosSearch());
                AnalyticsServices().sendTag("dir_medicos");
              },
              contentPadding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
              leading: Image.asset('assets/img/dir_doctores.png',
                  width: 60.0, height: 60.0),
              title: Text('Médicos',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: colorM
                          ? AppColors.secondary900
                          : AppColors.gnpTextSystem)),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: colorH ? AppColors.secondary900 : AppColors.boxShadow,
                blurRadius: 10.0,
                spreadRadius: -22.0,
                offset: Offset(0.0, 1.5))
          ]),
          child: Card(
            margin: EdgeInsets.all(
                16.0), //EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
            child: ListTile(
              onTap: () {
                setState(() {
                  colorH = true;
                  colorM = false;
                  colorC = false;
                  colorOt = false;
                  colorMod = false;
                  dateTime = DateTime.now();
                });
                Future.delayed(Duration(milliseconds: 500));
                presenter
                    .sendAnalytics("Hospitales")
                    .then((value) => presenter.showHosptalesSearch());
                AnalyticsServices().sendTag("dir_hospitales");
              },
              contentPadding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
              leading: Image.asset('assets/img/dir_hospitales.png',
                  width: 60.0, height: 60.0),
              title: Text('Hospitales',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: colorH
                          ? AppColors.secondary900
                          : AppColors.gnpTextSystem)),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: colorC ? AppColors.secondary900 : AppColors.boxShadow,
                blurRadius: 10.0,
                spreadRadius: -22.0,
                offset: Offset(0.0, 1.5))
          ]),
          child: Card(
            margin: EdgeInsets.all(16.0),
            child: ListTile(
              onTap: () {
                setState(() {
                  colorC = true;
                  colorH = false;
                  colorM = false;
                  colorOt = false;
                  colorMod = false;
                  dateTime = DateTime.now();
                });

                Future.delayed(Duration(milliseconds: 500));
                presenter
                    .sendAnalytics("Clínicas")
                    .then((value) => presenter.showClinicasSearch());
                AnalyticsServices().sendTag("dir_clinicas");
              },
              contentPadding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
              leading: Image.asset('assets/img/dir_clinicas.png',
                  width: 60.0, height: 60.0),
              title: Text('Clínicas',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: colorC
                          ? AppColors.secondary900
                          : AppColors.gnpTextSystem)),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: colorOt ? AppColors.secondary900 : AppColors.boxShadow,
                blurRadius: 10.0,
                spreadRadius: -22.0,
                offset: Offset(0.0, 1.5))
          ]),
          child: Card(
            margin: EdgeInsets.all(16.0),
            child: ListTile(
              onTap: () {
                setState(() {
                  colorOt = true;
                  colorH = false;
                  colorM = false;
                  colorC = false;
                  colorMod = false;
                  dateTime = DateTime.now();
                });
                Future.delayed(Duration(milliseconds: 500));
                presenter
                    .sendAnalytics("Otros servicios de salud")
                    .then((value) => presenter.showOtrosServSearch());
                AnalyticsServices().sendTag("dir_otros");
              },
              contentPadding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
              leading: Image.asset('assets/img/dir_otrosServiciosSalud.png',
                  width: 60.0, height: 60.0),
              title: Text('Otros servicios de salud',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: colorOt
                          ? AppColors.secondary900
                          : AppColors.gnpTextSystem)),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: colorMod ? AppColors.secondary900 : AppColors.boxShadow,
                blurRadius: 10.0,
                spreadRadius: -22.0,
                offset: Offset(0.0, 1.5))
          ]),
          child: Card(
            margin: EdgeInsets.all(16.0),
            child: ListTile(
              onTap: () {
                setState(() {
                  colorMod = true;
                  colorH = false;
                  colorM = false;
                  colorC = false;
                  colorOt = false;
                  dateTime = DateTime.now();
                });
                Future.delayed(Duration(milliseconds: 500));
                presenter
                    .sendAnalytics("Módulos GNP")
                    .then((value) => presenter.showModulosSearch());
                AnalyticsServices().sendTag("dir_modulos");
              },
              contentPadding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
              leading: Image.asset('assets/img/dir_oficinas.png',
                  width: 60.0, height: 60.0),
              title: Text('Módulos GNP',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: colorMod
                          ? AppColors.secondary900
                          : AppColors.gnpTextSystem)),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _runsAfterBuild() async {
    _directorioTime.stop();
  }
}
