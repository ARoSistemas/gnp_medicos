// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter
// ignore_for_file: document_ignores

import 'dart:html' as html;
import 'package:medicos/shared/services/maps/maps_loader_service.dart';

class MapsLoaderService extends MapsLoaderBase {
  @override
  void injectScript() {
    const String mapsKey = String.fromEnvironment('webFirebaseApiKey');

    if (mapsKey.isNotEmpty) {
      final script = html.ScriptElement()
        ..src = 'https://maps.googleapis.com/maps/api/js?key=$mapsKey'
        ..async = true
        ..defer = true;
      html.document.head?.append(script);
    }
  }
}
