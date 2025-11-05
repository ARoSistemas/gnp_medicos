import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';

class ProfileRepository extends ApiBaseProvider {
  @override
  final String url = AppConfig.baseUrlMedicos;

  @override
  final String contextPath = '/admonproveedores/medicos';
}
