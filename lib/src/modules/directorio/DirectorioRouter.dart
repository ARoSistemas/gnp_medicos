import 'package:get/get.dart';
import 'package:medicos/src/modules/directorio/DirectorioSearchModule/DirectorioSearchController.dart';
import 'package:medicos/src/modules/directorio/DirectorioSearchModule/DirectorioSearchPage.dart';
import 'package:medicos/src/modules/directorio/stubs/ServiceResponseTimeMeasurementManager.dart';
import 'package:medicos/src/modules/directorio/stubs/TipoServicio.dart';
import 'package:permission_handler/permission_handler.dart';

class DirectorioRouter {
  final ServiceResponseTimeMeasurementManager directorioGMM =
      ServiceResponseTimeMeasurementManager();

  void backToHome() {
    Get.back();
  }

  void showMedicosSearch() {
    // Future(() {
    //   _runsAfterBuild(view.dateTime, 'DirectorioMedico-PantallaInicio');
    // });
    Get.to(
      () => const DirectorioSearchPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DirectorioSearchController>(
          () => DirectorioSearchController(servicio: TipoServicio.Medicos),
        );
      }),
    );
  }

  void showHosptalesSearch() {
    // Future(() {
    //   _runsAfterBuild(view.dateTime, 'DirectorioHospitales-PantallaInicio');
    // });
    Get.to(
      () => const DirectorioSearchPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DirectorioSearchController>(
          () => DirectorioSearchController(servicio: TipoServicio.Hospitales),
        );
      }),
    );
  }

  void showClinicasSearch() {
    // Future(() {
    //   _runsAfterBuild(view.dateTime, 'DirectorioClinicas-PantallaInicio');
    // });
    Get.to(
      () => const DirectorioSearchPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DirectorioSearchController>(
          () => DirectorioSearchController(servicio: TipoServicio.Clinicas),
        );
      }),
    );
  }

  void showOtrosServSearch() {
    // Future(() {
    //   _runsAfterBuild(view.dateTime, 'DirectorioOtrosServicios-PantallaInicio');
    // });
    Get.to(
      () => const DirectorioSearchPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DirectorioSearchController>(
          () => DirectorioSearchController(servicio: TipoServicio.OtrosServ),
        );
      }),
    );
  }

  void showModulosSearch() {
    // Future(() {
    //   _runsAfterBuild(view.dateTime, 'DirectorioModulosGNP-PantallaInicio');
    // });
    Get.to(
      () => const DirectorioSearchPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DirectorioSearchController>(
          () => DirectorioSearchController(servicio: TipoServicio.Modulos),
        );
      }),
    );
  }

  Future<bool> _requestPermission(Permission permission) async {
    final PermissionStatus status = await permission.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> requestLocationPermission() async =>
      _requestPermission(Permission.locationAlways);

  Future<void> _runsAfterBuild(
    DateTime timeStartSecond,
    String nameService,
  ) async {
    directorioGMM.stop(
      timeStartSecond: timeStartSecond,
      nameService: nameService,
    );
  }
}
