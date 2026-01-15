import 'package:get/get.dart';
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/src/modules/login/login_controller.dart';

class AuthRepository extends ApiBaseProvider {
  @override
  final String url = AppConfig.baseUrlMedicos;

  @override
  final String contextPath = '/admonproveedores';

  /// Fetch data for Login
  Future<Response<LoginModel>> login(
    String email,
    String password,
  ) => post(
    '/conveniomedicos/login',
    {
      'mail': email,
      'password': password,
      'tipousuario': 'administrador',
    },
    decoder: (data) {
      if (data is Map<String, dynamic> && data['code'] is int) {
        return LoginModel.fromMap(data);
      }

      return LoginModel.empty();
    },
  );

  /// Fetch data for Password Recovery
  Future<bool> forgotPassword(String email) async {
    final Response response = await get('/conveniomedicos/reset/$email');
    return response.statusCode! >= 200 && response.statusCode! <= 299;
  }

  Future<Response> postActivation({
    required String uid,
    required String contrasenaActual,
    required String contrasenaNueva,
  }) => post(
    '/conveniomedicos/activacion',
    {
      'uid': uid,
      'contrasenaActual': contrasenaActual,
      'contrasenaNueva': contrasenaNueva,
    },
  );

  /// Fetch data for Password Recovery
  Future<bool> deleteAccount(String idParticipante, String jwt) async {
    
    final Response response = await delete(
      '/usuarios/$idParticipante',
      headers: {
      'Authorization': 'Bearer $jwt',
    },
    );
    return response.statusCode! >= 200 && response.statusCode! <= 299;
  }
  
}
