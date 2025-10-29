import 'package:get/get.dart';
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';

class AddAssistantsRepository extends ApiBaseProvider {
  @override
  final String url = AppConfig.baseUrl;

  @override
  final String contextPath = '/asistentes';

  Future<bool> onOffAssistant({
    required String idAssistant,
    required String affiliationCode,
    required bool status,
    required String jwt,
  }) async {
    final Response r = await put(
      '/relaciones/medicos/$affiliationCode/asistentes/$idAssistant',
      {'activo': status},
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );
    return (r.statusCode ?? 0) >= 200 && (r.statusCode ?? 0) <= 299;
  }
}
