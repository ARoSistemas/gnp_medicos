import 'package:medicos/shared/services/maps/maps_loader_service.dart';

class MapsLoaderService extends MapsLoaderBase {
  @override
  void injectScript() {
    // No hace nada en plataformas que no sean Web
  }
}
