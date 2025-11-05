import 'package:medicos/core/config/app_config.dart';

class Assets {
  static String png(String asset) {
    final Map<String, String> map = {
      'logo': '${AppConfig.baseUrlMedicos}/admonproveedores/logo.png',
    };
    return map[asset] ?? '';
  }
}
