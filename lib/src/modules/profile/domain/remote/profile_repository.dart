import 'package:get/get_connect/http/src/response/response.dart';
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';

class ProfileRepository extends ApiBaseProvider {
  @override
  final String url = AppConfig.baseUrlMedicos;

  @override
  final String contextPath = '/gestor-medico/medicos';

  /// Fetch user profile data from the remote server.
  Future<Response<void>> fetchProfile(String id, String jwt) => get(
    '/$id/perfil/',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt',
    },
    decoder: (data) {
      // if (data is List) {
      //   final List<Map<String, dynamic>> dataList =
      //       List<Map<String, dynamic>>.from(data);
      //   return;
      // }
      // print('🔥 Profile Response:');
      // print(data);

      return;
    },
  );
}
