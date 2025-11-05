import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';

class SearchDirectoryRepository extends ApiBaseProvider {
  @override
  final String url = AppConfig.baseUrlDirectorio;

  @override
  final String contextPath = '/admonproveedores/conveniomedicos';
}
