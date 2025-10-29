
import 'package:agentesgnp/Functions/ServiceResponseTimeMeasurementManager.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioContract.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioController.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/DirectorioSearchModule/DirectorioSearchController.dart';
import 'package:agentesgnp/UserInterfaces/DirectorioModule/Utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class DirectorioRouter implements DirectorioWireFrame {
  late DirectorioControllerState view;
  final ServiceResponseTimeMeasurementManager directorioGMM =
      ServiceResponseTimeMeasurementManager();

  DirectorioRouter(DirectorioControllerState view) {
    this.view = view;
  }

  @override
  void backToHome() {
    Navigator.pop(view.context);
  }

  @override
  void showMedicosSearch() {
    Navigator.of(view.context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          if (context.findRenderObject() == null) {
            Future(() {
              _runsAfterBuild(view.dateTime, "DirectorioMedico-PantallaInicio");
            });
          }
          return DirectorioSearchController(servicio: TipoServicio.Medicos);
        }));
  }

  @override
  void showHosptalesSearch() {
    Navigator.of(view.context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          if (context.findRenderObject() == null) {
            Future(() {
              _runsAfterBuild(
                  view.dateTime, "DirectorioHospitales-PantallaInicio");
            });
          }
          return DirectorioSearchController(servicio: TipoServicio.Hospitales);
        }));
  }

  @override
  void showClinicasSearch() {
    Navigator.of(view.context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          if (context.findRenderObject() == null) {
            Future(() {
              _runsAfterBuild(
                  view.dateTime, "DirectorioClinicas-PantallaInicio");
            });
          }
          return DirectorioSearchController(servicio: TipoServicio.Clinicas);
        }));
  }

  @override
  void showOtrosServSearch() {
    Navigator.of(view.context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          if (context.findRenderObject() == null) {
            Future(() {
              _runsAfterBuild(
                  view.dateTime, "DirectorioOtrosServicios-PantallaInicio");
            });
          }
          return DirectorioSearchController(servicio: TipoServicio.OtrosServ);
        }));
  }

  @override
  void showModulosSearch() {
    Navigator.of(view.context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          if (context.findRenderObject() == null) {
            Future(() {
              _runsAfterBuild(
                  view.dateTime, "DirectorioModulosGNP-PantallaInicio");
            });
          }
          return DirectorioSearchController(servicio: TipoServicio.Modulos);
        }));
  }

  Future<bool> _requestPermission(Permission permission) async {
    var status = await permission.request();
    if (status == PermissionStatus.granted) {
      Utils.permissions = true;
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestLocationPermission() async {
    return _requestPermission(Permission.locationAlways);
  }

  Future<void> _runsAfterBuild(
      DateTime timeStartSecond, String nameService) async {
    directorioGMM.stop(
        timeStartSecond: timeStartSecond, nameService: nameService);
  }
}
