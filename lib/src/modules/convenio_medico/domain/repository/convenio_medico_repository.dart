import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';

class ConvenioMedicoRepository extends ApiBaseProvider {
  final AppStateController stateControllers = Get.find<AppStateController>();

  @override
  final String url = AppConfig.baseUrlMedicos;

  @override
  final String contextPath = '/admonproveedores/archivos';

  Future<Uint8List?> donwMoloadMedicalAgreement(String affiliationCode) async {
    final String loginEnpoint = '/medicos/$affiliationCode/convenio';
    try {
      http.Response? response;
      final Uri uri = Uri.parse('$url$contextPath$loginEnpoint');
      response = await http.get(
        uri,
        headers: _getHeaders(stateControllers.user.token.jwt),
      );
      if (response.statusCode == HttpStatus.ok) {
        return response.bodyBytes;
      }
      return null;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<Uint8List?> downloadGuidelines() async {
    const String loginEnpoint = '/medicos/aviso';
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
