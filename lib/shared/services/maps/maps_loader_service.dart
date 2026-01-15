export 'maps_loader_service_io.dart'
    if (dart.library.html) 'maps_loader_service_web.dart';


abstract class MapsLoaderBase {
  void injectScript() {
    _();
  }

  void _() {
    // Empty method
  }
}
