import 'package:get/get.dart';
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/src/modules/login/login_controller.dart';

class AuthRepository extends ApiBaseProvider {
  @override
  final String url = AppConfig.baseUrlMedicos;

  @override
  final String contextPath = '/admonproveedores/conveniomedicos';

  /// Fetch data for Login
  Future<Response<LoginModel>> login(
    String email,
    String password,
  ) => post(
    '/login',
    {
      'mail': email,
      'password': password,
      'tipousuario': 'administrador',
    },
    decoder: (data) {
      if ((data as Map<String, dynamic>)['code'] is int) {
        return LoginModel.fromMap(data);
      }

      return LoginModel.empty();
    },
  );

  /// Fetch data for Password Recovery
  Future<bool> forgotPassword(String email) async {
    final Response response = await get('/reset/$email');
    return response.statusCode! >= 200 && response.statusCode! <= 299;
  }
}
