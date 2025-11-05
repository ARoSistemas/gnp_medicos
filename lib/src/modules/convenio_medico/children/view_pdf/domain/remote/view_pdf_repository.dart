import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/core/services/threads/threads_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';

class ViewPdfRepository extends ApiBaseProvider {
  final AppStateController stateController = Get.find<AppStateController>();
  final ThreadsService threadsService = Get.find<ThreadsService>();

  @override
  final String url = AppConfig.baseUrlMedicos;

  @override
  final String contextPath = '/admonproveedores/archivos';

  Future<Uint8List?> downloadLineamiento() async {
    const String loginEnpoint = '/medicos/aviso';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${stateController.user.token.jwt}',
    };
    try {
      http.Response? response;
      final Uri uri = Uri.parse('$url$contextPath$loginEnpoint');
      response = await http.get(uri, headers: headers);
      if (response.statusCode == HttpStatus.ok) {
        return response.bodyBytes;
      }
      return null;
    } on Exception catch (_) {
      return null;
    }
  }
}
