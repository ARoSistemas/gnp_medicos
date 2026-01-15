import 'package:get/get_connect/http/src/response/response.dart';
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/src/modules/procedures/domain/dtos/my_procedures_dto.dart';

class ProceduresRepository extends ApiBaseProvider {
  @override
  final String url = AppConfig.baseUrlMedicos;

  @override
  final String contextPath = '/gestor-medico/medicos/';

  Future<Response<MyProceduresDto>> fetchFolios({
    required String rfc,
    required String jwt,
    required String filtros,
  }) => get(
    '$rfc/tramites$filtros',
    headers: {
      'Authorization': 'Bearer $jwt',
    },
    decoder: (data) {
      final tmp = data as Map<String, dynamic>;

      final Map<String, dynamic> tmpEntidad = tmp['entidad'] ?? {};
      final List tmpData = tmpEntidad['data'] ?? [];

      if (tmpData.isNotEmpty) {
        return MyProceduresDto.fromMap(tmp);
      }

      return MyProceduresDto.empty();
    },
  );
}
