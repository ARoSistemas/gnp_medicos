import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/utils/exception_manager.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/widgets/custom_alert.dart';
import 'package:medicos/src/modules/directory/children/filter_results/domain/entities/models/item_results_mdl.dart';
import 'package:medicos/src/modules/directory/children/item_map/domain/entities/dtos/directions_dto.dart'
    as dtogmap;
import 'package:medicos/src/modules/directory/children/item_map/domain/repository/item_map_repository.dart';
import 'package:url_launcher/url_launcher.dart';

part 'item_map_model.dart';

class ItemMapController extends GetxController
    with StateMixin<_ItemMapModel>, WidgetsBindingObserver {
  final ItemMapRepository _apiConn = Get.find();
  final AppStateController appState = Get.find();

  UserModel get user => appState.user;

  /// Completer for GoogleMapController
  Completer<GoogleMapController> mapCtrler = Completer<GoogleMapController>();

  /// Key to force rebuild of the GoogleMap widget
  Rx<Key> mapKey = UniqueKey().obs;

  /// Current position of the user
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

  /// Set of polylines to display on the map
  RxSet<Polyline> polylines = <Polyline>{}.obs;

  /// Set of markers to display on the map
  RxSet<Marker> markers = <Marker>{}.obs;

  /// Controls the visibility of the central pin
  RxBool showCentralPin = false.obs;

  /// Indicates if the route is currently being loaded
  RxBool isLoadingRoute = false.obs;

  Map<String, dynamic>? arguments;

  /// Flag to track if controller is disposed
  bool _isDisposed = false;

  @override
  Future<void> onInit() async {
    super.onInit();

    /// Reset disposed flag in case controller is being reused
    _isDisposed = false;

    /// Observe app lifecycle changes
    WidgetsBinding.instance.addObserver(this);

    /// If it's mobile navigation, load the data from Get.arguments
    if (Get.arguments != null) {
      initData();
    } else {
      final bool isPhoneScreen =
          Get.context != null && Get.context!.width < 600;

      if (isPhoneScreen) {
        /// Phone screen should always receive arguments when navigating
        change(
          null,
          status: RxStatus.error(msg.noDataReceived.value),
        );
      } else {
        /// Tablet or desktop can start with empty map
        change(
          _ItemMapModel.empty(),
          status: RxStatus.success(),
        );
      }
    }
  }

  /// Safe method to handle onMapCreated callback
  /// Prevents "Future already completed" error when map is recreated
  void onMapCreated(GoogleMapController controller) {
    if (mapCtrler.isCompleted) {
      /// If completer is already completed, create a new one
      mapCtrler = Completer<GoogleMapController>();
    }
    mapCtrler.complete(controller);
  }

  /// Initializes the controller's data from arguments.
  void initData() {
    final Map<String, dynamic>? sourceArgs = arguments ?? Get.arguments;

    if (sourceArgs == null) {
      change(
        null,
        status: RxStatus.error(msg.noDataReceived.value),
      );
      return;
    }

    final item = sourceArgs['item'] as ItemResultsMdl;
    final titleAppBar = sourceArgs['titleAppBar'] as String;
    final _ItemMapModel tmp = _ItemMapModel(
      name: titleAppBar,
      title: item.title,
      subtitle: item.subtitle,
      desc: item.desc,
      tel: item.tel,
      lat: item.lat,
      lng: item.lng,
      gps: CameraPosition(
        target: LatLng(
          double.tryParse(item.lat) ?? 0.0,
          double.tryParse(item.lng) ?? 0.0,
        ),
        zoom: 15,
      ),
    );

    /// Clear previous markers and polylines before adding new one
    markers.clear();
    polylines.clear();
    showCentralPin.value = false;

    if (item.lat.isNotEmpty && item.lng.isNotEmpty) {
      markers.add(
        Marker(
          markerId: const MarkerId('origen'),
          position: LatLng(double.parse(item.lat), double.parse(item.lng)),
        ),
      );

      /// Move camera to the new item position
      unawaited(_moveCameraToItem(item));
    }

    change(tmp, status: RxStatus.success());
  }

  /// Reset map to default location (Ciudad de México)
  void resetToDefaultLocation() {
    /// Clear markers and polylines
    markers.clear();
    polylines.clear();
    showCentralPin.value = false;

    /// Set state to empty model with default location
    change(
      _ItemMapModel.empty(),
      status: RxStatus.success(),
    );
  }

  /// Moves the camera to the selected item's position
  Future<void> _moveCameraToItem(ItemResultsMdl item) async {
    /// Don't attempt to move camera if controller is disposed
    if (_isDisposed) {
      return;
    }

    await appService.threads.execute(
      customExceptionMessages: {
        Exception(): ExceptionAlertProperties(
          message: 'Error moving camera',
        ),
      },
      func: () async {
        /// Double check: verify controller is not disposed and map is ready
        if (_isDisposed || !mapCtrler.isCompleted) {
          return;
        }

        final GoogleMapController controller = await mapCtrler.future;

        /// Final check before animating
        if (_isDisposed) {
          return;
        }

        await controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                double.parse(item.lat),
                double.parse(item.lng),
              ),
              zoom: 15,
            ),
          ),
        );
      },
    );
  }

  @override
  Future<void> onClose() async {
    _isDisposed = true;

    /// Dispose map controller if it exists
    if (mapCtrler.isCompleted) {
      await mapCtrler.future
          .then((controller) {
            controller.dispose();
          })
          .catchError((_) {
            /// Ignore errors during disposal
          });
    }

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
      appService.alert.show(
        title: msg.locationServicesDisabledTitle.value,
        message: msg.locationServicesDisabledMessage.value,
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
        appService.alert.show(
          title: msg.permissionsDeniedTitle.value,
          message: msg.permissionsDeniedMessage.value,
          type: AlertType.error,
        );
        return;
      }
    }

    /// If permissions are denied permanently, open settings.
    if (permission == LocationPermission.deniedForever) {
      appService.alert.show(
        title: msg.permissionsPermanentlyDeniedTitle.value,
        message: msg.permissionsPermanentlyDeniedMessage.value,
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
        appService.alert.show(
          title: 'Google Maps Error',
          message: 'Error getting map controller: $e',
          type: AlertType.error,
        );
        return Future<GoogleMapController>.error(e);
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
    change(state, status: RxStatus.success());
  }

  /// Launch the phone dialer with the provided telephone number.
  Future<void> launchPhone() async {
    await appService.threads.execute(
      customExceptionMessages: {
        Exception(): ExceptionAlertProperties(
          message: msg.errorMakingPhoneCall.value,
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
  Future<void> getRouteTransportMode({
    required bool isModeDriving,
    required bool isWeb,
  }) async {
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
      appService.alert.show(
        title: msg.routeNotAvailableTitle.value,
        message: msg.routeNotAvailableMsg.value,
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
      infoWindow: InfoWindow(title: msg.youAreHere.value),
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

    await controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));

    update();

    isLoadingRoute.value = false;

    if (isWeb) {
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentPosition.latitude, currentPosition.longitude),
          zoom: 14.4746,
        ),
      );
    }
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
        '''?origin=${currentPosition.latitude},${currentPosition.longitude}&destination=${state!.lat},${state!.lng}&mode=$mode&key=${AppConfig.apiKeyMaps}''';

    final Response<dtogmap.DirectionsDto> hasData = await _apiConn
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
