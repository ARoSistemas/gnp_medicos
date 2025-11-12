import 'package:get/get.dart';
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/src/modules/home/domain/entities/dtos/asisstant_dto.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/domain/dtos/permissions_dto.dart';

class HomeRepository extends ApiBaseProvider {
  @override
  final String url = AppConfig.baseUrlMedicos;

  @override
  final String contextPath = '/admonproveedores/asistentes';

  /// Fetch data for Assistants List
  Future<Response<List<AsisstantDto>>> fetchListado(String uuid, String jwt) =>
      get(
        '/$uuid/medicos',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt',
        },
        decoder: (data) {
          if (data is List) {
            final List<Map<String, dynamic>> dataList =
                List<Map<String, dynamic>>.from(data);
            return dataList.map(AsisstantDto.fromMap).toList();
          }
          return [];
        },
      );

  /// Fetch data for get Permissions
  Future<Response<List<PermissionsDto>>> getPermissions(
    String idAssistant,
    String affiliationCode,
    String jwt,
  ) => get(
    '/$idAssistant/medicos/$affiliationCode/permisos',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt',
    },
    decoder: (data) {
      if (data is List) {
        final List<PermissionsDto> list = data
        .map((item) => PermissionsDto.fromMap(item as Map<String, dynamic>))
        .toList()
        ..sort((a, b) => a.orden.compareTo(b.orden));
        return list;
      }
      return [];
    },
  );
}
