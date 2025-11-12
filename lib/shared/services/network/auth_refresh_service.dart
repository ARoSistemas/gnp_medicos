import 'package:get/get.dart';
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/utils/logger.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/token_mdl.dart';

class AuthRefreshService {
  static Future<bool> refreshToken(GetConnect client) async {
    try {
      final AppStateController appState = Get.find<AppStateController>();
      final String refreshToken = appState.user.token.refreshtoken;
      final GetConnect tempClient = GetConnect();

      final Response<dynamic> response = await tempClient.post(
        '${AppConfig.baseUrlCuentasGnp}/auth/login/refresh',
        {'refreshtoken': refreshToken},
      );

      if (response.isOk && response.body is Map<String, dynamic>) {
        final Map<String, dynamic> body =
            response.body as Map<String, dynamic>;

        final String? newToken = body['jwt'] as String?;
        if (newToken == null || newToken.isEmpty) {
          return false;
        }
        appState.user = appState.user.copyWith(token: Token.fromMap(body));
        client.httpClient.addRequestModifier<void>((request) {
          request.headers.addAll({
            'Authorization': 'Bearer $newToken',
          });
          return request;
        });
        return true;
      }
    } on Exception catch (e, s) {
      logger.e('Error al refrescar token', error: e, stackTrace: s);
    }
    return false;
  }
}
