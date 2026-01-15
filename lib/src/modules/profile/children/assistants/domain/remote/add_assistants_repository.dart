import 'package:get/get.dart';
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';

class AddAssistantsRepository extends ApiBaseProvider {
  @override
  final String url = AppConfig.baseUrlMedicos;

  @override
  final String contextPath = '/admonproveedores';

  Future<bool> onOffAssistant({
    required String idAssistant,
    required String idTipoAsistente,
    required String affiliationCode,
    required bool status,
    required String jwt,
  }) async {
    final Response r = await put(
      '/medicos/$affiliationCode/asistentes/$idAssistant/relaciones',
      {
        'activo': status,
        'idTipoAsistente': idTipoAsistente
      },
      headers: {
        'Authorization': 'Bearer $jwt',
      },
    );
    return (r.statusCode ?? 0) >= 200 && (r.statusCode ?? 0) <= 299;
  }
}
