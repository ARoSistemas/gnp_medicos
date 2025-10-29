import 'package:get/get.dart';

import 'package:medicos/src/modules/directorio/directorio_search_module/directorio_search_controller.dart';
import 'package:medicos/src/modules/directorio/directorio_search_module/directorio_search_page.dart';
import 'package:medicos/src/modules/directorio/stubs/service_response_time_measurement_manager.dart';
import 'package:medicos/src/modules/directorio/stubs/tipo_servicio.dart';
import 'package:permission_handler/permission_handler.dart';

class DirectorioRouter {
  final ServiceResponseTimeMeasurementManager directorioGMM =
      ServiceResponseTimeMeasurementManager();

  void backToHome() {
    Get.back();
  }

  Future<void> showMedicosSearch() async {
    await Get.to(
      () => const DirectorioSearchPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DirectorioSearchController>(
          () => DirectorioSearchController(servicio: TipoServicio.medicos),
        );
      }),
    );
  }

  Future<void> showHosptalesSearch() async {
    await Get.to(
      () => const DirectorioSearchPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DirectorioSearchController>(
          () => DirectorioSearchController(servicio: TipoServicio.hospitales),
        );
      }),
    );
  }

  Future<void> showClinicasSearch() async {
    await Get.to(
      () => const DirectorioSearchPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DirectorioSearchController>(
          () => DirectorioSearchController(servicio: TipoServicio.clinicas),
        );
      }),
    );
  }

  Future<void> showOtrosServSearch() async {
    await Get.to(
      () => const DirectorioSearchPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DirectorioSearchController>(
          () => DirectorioSearchController(servicio: TipoServicio.otrosServ),
        );
      }),
    );
  }

  Future<void> showModulosSearch() async {
    await Get.to(
      () => const DirectorioSearchPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DirectorioSearchController>(
          () => DirectorioSearchController(servicio: TipoServicio.modulos),
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

  Future<bool> requestLocationPermission() =>
      _requestPermission(Permission.locationAlways);

  Future<void> runsAfterBuild(
    DateTime timeStartSecond,
    String nameService,
  ) async {
    directorioGMM.stop(
      timeStartSecond: timeStartSecond,
      nameService: nameService,
    );
  }
}
