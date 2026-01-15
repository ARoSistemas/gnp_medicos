import 'package:get/get.dart';
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/domain/dtos/assistant_dto.dart';

class AssistantsRepository extends ApiBaseProvider {
  @override
  final String url = AppConfig.baseUrlMedicos;

  @override
  final String contextPath = '/admonproveedores/medicos';

  /// Fetch Assistants List
  ///
  /// Response:
  ///
  /// [
  ///   {
  ///     "idAsistente":"MDUANAP001",
  ///     "nombre":"PruebaAndres",
  ///     "apellidoPaterno":"Andres",
  ///     "apellidoMaterno":"Andres",
  ///     "fechaNacimiento":"2007-10-10",
  ///     "cveLada":"",
  ///     "telefono":"8883332121",
  ///     "email":"andres@prueba.com",
  ///     "activo":false,
  ///     "idTipoAsistente":"aba",
  ///     "nombreTipoAsistente":"Asistente Básico"
  ///     },
  ///     {
  ///       "idAsistente":"MDUCOCA001",
  ///        ...
  ///        ...
  ///     }
  /// ]
  Future<List<AssistantDto>> getAssistantList(
    String affiliationCode,
    String jwt,
  ) async {
    final Response<List<AssistantDto>> ret = await get(
      '/$affiliationCode/asistentes',
      headers: {
        'Authorization': 'Bearer $jwt',
      },
      decoder: (data) {
        if (data is Map && data.containsKey('status')) {
          /// Falló por token expirado
          return [];
        }
        if (data is List) {
          final List<Map<String, dynamic>> dataList =
              List<Map<String, dynamic>>.from(data);

          final List<AssistantDto> listaFinal = dataList
              .map(AssistantDto.fromMap)
              .toList();

          return listaFinal;
        }
        return [];
      },
    );
    return ret.body ?? [];
  }
}
