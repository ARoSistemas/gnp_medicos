import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/utils/exception_manager.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/widgets/custom_notification.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/domain/entities/models/items_results_mdl.dart';
import 'package:url_launcher/url_launcher.dart';

part 'item_map_model.dart';

class ItemMapController extends GetxController
    with StateMixin<_ItemMapModel>, WidgetsBindingObserver {
  final AppStateController appState = Get.find<AppStateController>();

  /// Completer for GoogleMapController
  Completer<GoogleMapController> mapCtrler = Completer<GoogleMapController>();

  /// Key to force rebuild of the GoogleMap widget
  Rx<Key> mapKey = UniqueKey().obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    /// Observe app lifecycle changes
    WidgetsBinding.instance.addObserver(this);
    change(null, status: RxStatus.loading());

    /// Retrieve arguments passed to this page
    final Map<String, dynamic> arg =
        Get.arguments as Map<String, dynamic>? ?? {};

    final ItemsResultsMdl tmp =
        arg['item'] as ItemsResultsMdl? ?? ItemsResultsMdl.empty();
    final String tmpTitle = arg['titleAppBar'] as String? ?? '';

    change(
      _ItemMapModel.empty().copyWith(
        name: tmpTitle,
        title: tmp.title,
        subtitle: tmp.subtitle,
        desc: tmp.desc,
        tel: tmp.tel,
        lat: tmp.lat,
        lng: tmp.lng,
        gps: CameraPosition(
          target: LatLng(
            double.tryParse(tmp.lat) ?? 0,
            double.tryParse(tmp.lng) ?? 0,
          ),
          zoom: 14.4746,
        ),
      ),
      status: RxStatus.success(),
    );
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      /// Force rebuild of the map widget to avoid blank screen on resume
      mapCtrler = Completer<GoogleMapController>();
      mapKey.value = UniqueKey();
    }
  }

  /// Move the map to the current location of the user.
  Future<void> goToCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    /// Verify if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      AppService.i.notifications.show(
        title: 'Servicios de ubicación desactivados',
        message: 'Por favor, habilita los servicios de ubicación.',
        type: AlertType.warning,
      );
      return;
    }

    /// Check location permissions.
    permission = await Geolocator.checkPermission();

    /// If permissions are denied, request permissions.
    if (permission == LocationPermission.denied) {
      /// If permissions are denied, request permissions.
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        AppService.i.notifications.show(
          title: 'Permisos denegados',
          message: 'No se puede obtener la ubicación actual sin permisos.',
          type: AlertType.error,
        );
        return;
      }
    }

    /// If permissions are denied permanently, open settings.
    if (permission == LocationPermission.deniedForever) {
      AppService.i.notifications.show(
        title: 'Permisos denegados permanentemente',
        message: 'Abre la configuración de la app para habilitar la ubicación.',
        type: AlertType.error,
      );
      await Geolocator.openAppSettings();
      return;
    }

    /// Get the current location.
    final Position position = await Geolocator.getCurrentPosition();

    /// Get the GoogleMapController from the completer.
    final GoogleMapController controller = await mapCtrler.future.catchError(
      (e) {
        throw Exception('Error getting map controller: $e');
      },
    );

    /// Move the map to the location.
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 14.4746,
        ),
      ),
    );
  }

  /// Open Google Maps with the route to the destination.
  Future<void> getRouteTransportMode({required bool isModeDriving}) async {
    final Uri googleMapsUri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=${state!.lat},${state!.lng}&travelmode=${isModeDriving ? 'driving' : 'walking'}',
    );

    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri);
    }
  }

  Future<void> launchPhone() async {
    await appService.threads.execute(
      customExceptionMessages: {
        Exception(): ExceptionAlertProperties(
          message:
              '''Error al intentar realizar la llamada telefónica. Por favor, inténtalo de nuevo más tarde.''',
        ),
      },
      func: () async {
        final String tel = state!.tel.replaceAll(' ', '');
        final Uri launchUri = Uri(
          scheme: 'tel',
          path: tel,
        );
        await launchUrl(launchUri);
      },
    );
  }
}
