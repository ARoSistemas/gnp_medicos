import 'package:flutter/services.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart' as http;
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/src/modules/anexos/domain/dtos/anneses_dto.dart';

class AnnexesRepository extends ApiBaseProvider {
  @override
  final String url = AppConfig.baseUrlMedicos;

  @override
  final String contextPath = '/gestor-medico/documentacion/anexos';

  Future<Response<List<AnnexesDto>>> fetchAnnexes(String jwt) => get(
    '',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jwt',
    },
    decoder: (data) {
      if (data is List) {
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);
        return dataList.map(AnnexesDto.fromMap).toList();
      }

      return [];
    },
  );

  Future<Uint8List?> downloadAnnexes(String filename, String jwt) async {
    try {
      http.Response? response;
      final Uri uri = Uri.parse('$url$contextPath/$filename');
      response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt',
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        return response.bodyBytes;
      }

      return null;
    } on Exception catch (_) {
      return null;
    }
  }
}
