
import 'package:flutter/material.dart';

class AppConfig {
  final String? appName;
  final String? flavor;
  final String? baseOSCP;
  final String? baseIntegracion;
  final String? apiKeyServices;
  final String? shareLocation;
  final String? apiKeyGM;
  final String? baseGoogleApis;
  final String? h107_Api_Key_Busqueda_Nombre;
  final String? serviceBCA;
  final String? h107_Api_Key_Busqueda_Cartera_Cliente;
  final String? urlPoliza;


  AppConfig({
    this.appName,
    this.flavor,
    this.baseOSCP,
    this.baseIntegracion,
    this.apiKeyServices,
    this.shareLocation,
    this.apiKeyGM,
    this.baseGoogleApis,
    this.h107_Api_Key_Busqueda_Nombre,
    this.serviceBCA,
    this.h107_Api_Key_Busqueda_Cartera_Cliente,
    this.urlPoliza,
  });

  static AppConfig? of(BuildContext context) {
    return AppConfig(
      appName: 'Mock App',
      flavor: 'mock',
      baseOSCP: 'https://mock-base-oscp.com',
      baseIntegracion: 'https://mock-base-integracion.com',
      apiKeyServices: 'mock_api_key',
      shareLocation: 'https://mock-share-location.com',
      apiKeyGM: 'mock_google_maps_key',
      baseGoogleApis: 'https://mock-google-apis.com',
      h107_Api_Key_Busqueda_Nombre: 'mock_h107_api_key',
      serviceBCA: 'https://mock-service-bca.com',
      h107_Api_Key_Busqueda_Cartera_Cliente: 'mock_h107_cartera_cliente',
      urlPoliza: 'https://mock-url-poliza.com',
    );
  }
}
