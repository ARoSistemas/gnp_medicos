
class Configuration {
  String? apiKeyServices;
  String? baseOSCP;
  String? baseIntegracion;
}

Configuration? mainConfiguration = Configuration()
  ..apiKeyServices = 'dummy_api_key'
  ..baseOSCP = 'https://dummy.api.com'
  ..baseIntegracion = 'https://dummy.api.com';
