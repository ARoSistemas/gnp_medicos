class AppConfig {
  static const String baseUrlMedicos = String.fromEnvironment('baseUrlMedicos');

  /// Base URL for the Directorio module.
  static const String baseUrlDirectorio = String.fromEnvironment(
    'baseUrlDirectorio',
  );
  static const String baseUrlOSCP = String.fromEnvironment('baseUrlOSCP');
  static const String baseUrlBCA = String.fromEnvironment('baseUrlBCA');
  static const String baseUrlGoogleApis = String.fromEnvironment(
    'baseUrlGoogleApis',
  );
  static const String shareLocation = String.fromEnvironment('shareLocation');
  static const String baseUrlIntegracion = String.fromEnvironment(
    'baseUrlIntegracion',
  );
  static const String urlPoliza = String.fromEnvironment('urlPoliza');
}
