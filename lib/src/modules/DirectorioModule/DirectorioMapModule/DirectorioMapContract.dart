import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class DirectorioMapView {

}

abstract class DirectorioMapPresentation {
  void backToHome();
  void share(LatLng latLng);
  Future sendAnalytics(String seccion, String accion, String lugar, String opcion);
}

abstract class DirectorioMapUseCase {
  void share(LatLng latLng);
  Future sendAnalytics(String seccion, String accion, String lugar, String opcion);
}

abstract class DirectorioMapInteractorOutput {

  void showAlertC(String title,String message);
}

abstract class DirectorioMapWireFrame {
  void backToHome();
  void showAlertC(String title,String message);
}