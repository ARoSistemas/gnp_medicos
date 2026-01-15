import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/src/modules/benefits/entities/dtos/benefit_dto.dart';

class BeneficiosRepository extends ApiBaseProvider {
  final AppStateController stateControllers = Get.find<AppStateController>();

  @override
  final String url = AppConfig.baseUrlMedicos;

  @override
  final String contextPath = '/gestor-medico/beneficios';


  Future<Response<List<BenefitDto>>> getBeneficios(
    String idAssistant,
    String affiliationCode
  ) => get(
    '/archivos',
    headers: _getHeaders(stateControllers.user.token.jwt),
    decoder: (data) {
      if (data is List) {
        final List<BenefitDto> list = data
        .map((item) => BenefitDto.fromJson(item as Map<String, dynamic>))
        .toList();
        return list;
      }
      return [];
    },
  );

  Future<Uint8List?> downloadBeneficio(String id) async {
    final String loginEnpoint = '/archivos/$id';
    try {
      http.Response? response;
      final Uri uri = Uri.parse('$url$contextPath$loginEnpoint');
      response = await http.get(uri, 
        headers: _getHeaders(stateControllers.user.token.jwt)
      );
      if (response.statusCode == HttpStatus.ok) {
        return response.bodyBytes;
      }
      return null;
    } on Exception catch (_) {
      return null;
    }
  }

  Map<String, String> _getHeaders(String jwt) => {
    'Authorization': 'Bearer $jwt',
  };
}
