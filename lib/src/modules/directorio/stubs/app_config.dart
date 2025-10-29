import 'package:flutter/material.dart';

class AppConfig {
  AppConfig({
    this.appName,
    this.flavor,
    this.baseOSCP,
    this.baseIntegracion,
    this.apiKeyServices,
    this.shareLocation,
    this.apiKeyGM,
    this.baseGoogleApis,
    this.apikeybusquedanombre,
    this.serviceBCA,
    this.apikeybusquedacarteracliente,
    this.urlPoliza,
  });
  final String? appName;
  final String? flavor;
  final String? baseOSCP;
  final String? baseIntegracion;
  final String? apiKeyServices;
  final String? shareLocation;
  final String? apiKeyGM;
  final String? baseGoogleApis;
  final String? apikeybusquedanombre;
  final String? serviceBCA;
  final String? apikeybusquedacarteracliente;
  final String? urlPoliza;

  static AppConfig? of(BuildContext context) => AppConfig(
    appName: 'Mock App',
    flavor: 'mock',
    baseOSCP: 'https://mock-base-oscp.com',
    baseIntegracion: 'https://mock-base-integracion.com',
    apiKeyServices: 'mock_api_key',
    shareLocation: 'https://mock-share-location.com',
    apiKeyGM: 'mock_google_maps_key',
    baseGoogleApis: 'https://mock-google-apis.com',
    apikeybusquedanombre: 'mock_h107_api_key',
    serviceBCA: 'https://mock-service-bca.com',
    apikeybusquedacarteracliente: 'mock_h107_cartera_cliente',
    urlPoliza: 'https://mock-url-poliza.com',
  );
}
