
import 'package:get/get.dart';
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';

class RegistroRepository extends ApiBaseProvider {
  @override
  final String url = AppConfig.baseUrlMedicos;

  @override
  final String contextPath = '/admonproveedores/conveniomedicos';

  Future<bool> registerService(Map<String, String> data) async {
    final Response res = await post('/usuarios', data);
    return (res.statusCode ?? 0) >= 200 && (res.statusCode ?? 0) <= 299;
  }
}
