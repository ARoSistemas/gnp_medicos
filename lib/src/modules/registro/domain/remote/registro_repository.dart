import 'package:get/get.dart';
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';

class RegistroRepository extends ApiBaseProvider {
  @override
  final String url = AppConfig.baseUrl;

  @override
  final String contextPath = '/conveniomedicos';

  Future<bool> registerService(Map<String, String> data) async {
    // const String loginEnpoint = '/registrarUsuario';
    final Response res = await post('/registrarUsuario', data);
    return (res.statusCode ?? 0) >= 200 && (res.statusCode ?? 0) <= 299;
  }
}
