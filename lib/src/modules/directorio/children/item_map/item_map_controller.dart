import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/utils/exception_manager.dart';
import 'package:medicos/shared/widgets/custom_notification.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/domain/entities/models/items_results_mdl.dart';
import 'package:medicos/src/modules/directorio/children/item_map/domain/entities/dtos/directions_dto.dart'
    as dtogmap;
import 'package:medicos/src/modules/directorio/children/item_map/domain/repositories/item_map_repository.dart';
import 'package:url_launcher/url_launcher.dart';

part 'item_map_model.dart';

class ItemMapController extends GetxController
    with StateMixin<_ItemMapModel>, WidgetsBindingObserver {
  final ItemMapRepository _itemMapRepo = Get.find();

  /// Completer for GoogleMapController
  Completer<GoogleMapController> mapCtrler = Completer<GoogleMapController>();

  /// Key to force rebuild of the GoogleMap widget
  Rx<Key> mapKey = UniqueKey().obs;

  Position currentPosition = Position(
    latitude: 0,
    longitude: 0,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
    altitudeAccuracy: 0,
    headingAccuracy: 0,
  );

  RxSet<Polyline> polylines = <Polyline>{}.obs;

  /// Set of markers to display on the map
  RxSet<Marker> markers = <Marker>{}.obs;

  /// Controls the visibility of the central pin
  RxBool showCentralPin = true.obs;

  RxBool isLoadingRoute = false.obs;

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
  Future<void> goToCurrentLocation({
    required bool moveCamera,
    bool clearMap = true,
  }) async {
    isLoadingRoute.value = true;

    /// Verify if location services are enabled.
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      AppService.i.notifications.show(
        title: 'Servicios de ubicación desactivados',
        message: 'Por favor, habilita los servicios de ubicación.',
        type: AlertType.warning,
      );
      return;
    }

    /// Check location permissions.
    LocationPermission permission = await Geolocator.checkPermission();

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
    currentPosition = await Geolocator.getCurrentPosition();

    if (clearMap) {
      polylines.clear();
      markers.clear();
      showCentralPin.value = true;
    }

    isLoadingRoute.value = false;

    /// if only updating location without moving camera
    if (!moveCamera) {
      return;
    }

    /// Get the GoogleMapController from the completer.
    final GoogleMapController controller = await mapCtrler.future.catchError(
      (e) {
        throw Exception('Error getting map controller: $e');
      },
    );

    update();

    /// Move the map to the location.
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentPosition.latitude, currentPosition.longitude),
          zoom: 14.4746,
        ),
      ),
    );
  }

  /// Launch the phone dialer with the provided telephone number.
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

  /// Open Google Maps with the route to the destination.
  Future<void> getRouteTransportMode({required bool isModeDriving}) async {
    isLoadingRoute.value = true;
    await goToCurrentLocation(moveCamera: false, clearMap: false);
    polylines.clear();

    /// Hide the central pin and clear markers before drawing a new route
    showCentralPin.value = false;
    markers.clear();

    final List<LatLng> routePoints = await getRoutePoints(
      isModeDriving ? 'driving' : 'walking',
    );

    if (routePoints.isEmpty) {
      AppService.i.notifications.show(
        title: 'Ruta no disponible',
        message:
            '''No se pudo obtener la ruta al destino. Por favor, inténtalo de nuevo más tarde.''',
        type: AlertType.error,
      );
      return;
    }

    polylines.add(
      routePoints.isNotEmpty
          ? Polyline(
              polylineId: const PolylineId('ruta1'),
              color: Colors.blue,
              width: 5,
              points: routePoints,
              patterns: isModeDriving
                  ? []
                  : [PatternItem.dash(10), PatternItem.gap(20)],
            )
          : const Polyline(
              polylineId: PolylineId('ruta1'),
              color: Colors.transparent,
              width: 0,
            ),
    );

    /// Add start and end markers
    final Marker startMarker = Marker(
      markerId: const MarkerId('start_marker'),
      position: LatLng(currentPosition.latitude, currentPosition.longitude),
      infoWindow: const InfoWindow(title: 'Aquí te encuentras'),
    );
    final Marker endMarker = Marker(
      markerId: const MarkerId('end_marker'),
      position: LatLng(
        double.tryParse(state!.lat) ?? 0,
        double.tryParse(state!.lng) ?? 0,
      ),
      infoWindow: InfoWindow(title: state!.title),
    );

    markers.addAll({startMarker, endMarker});

    final GoogleMapController controller = await mapCtrler.future;
    final LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(
        routePoints.map((e) => e.latitude).reduce((a, b) => a < b ? a : b),
        routePoints.map((e) => e.longitude).reduce((a, b) => a < b ? a : b),
      ),
      northeast: LatLng(
        routePoints.map((e) => e.latitude).reduce((a, b) => a > b ? a : b),
        routePoints.map((e) => e.longitude).reduce((a, b) => a > b ? a : b),
      ),
    );

    await controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        bounds,
        100,
      ),
    );
    update();

    isLoadingRoute.value = false;
  }

  /// Draw route on the map based on the selected mode of transportation.
  Future<void> drawRoute(String mode) async {
    final List<LatLng> routePoints = await getRoutePoints(mode);
    final polyline = Polyline(
      polylineId: const PolylineId('ruta1'),
      color: Colors.blue,
      width: 5,
      points: routePoints,
    );
    polylines.add(polyline);
  }

  /// Get route points from current location
  /// to destination using specified mode.
  Future<List<LatLng>> getRoutePoints(String mode) async {
    /// If latitude or longitude is empty, return an empty list
    if (state!.lat.isEmpty || state!.lng.isEmpty) {
      return [];
    }
    final directions =
        '''?origin=${currentPosition.latitude},${currentPosition.longitude}&destination=${state!.lat},${state!.lng}&$mode&key=AIzaSyD2bbZFGV3US6N_qtlrkxHUc1Sj_tAozPg''';

    final Response<dtogmap.DirectionsDto> hasData = await _itemMapRepo
        .getRoutePoints(
          directions,
        );

    final String points = hasData.body!.routes.isNotEmpty
        ? hasData.body!.routes[0].overviewPolyline.points
        : '';

    return decodePolyline(points);
  }

  /// Decode an encoded polyline string into a list of LatLng points.
  List<LatLng> decodePolyline(String encoded) {
    if (encoded.isEmpty) {
      return [];
    }

    final List<LatLng> polyline = [];
    int index = 0;
    final int len = encoded.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b;
      int shift = 0;
      int result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      final int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      final int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      polyline.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return polyline;
  }
}
