import 'package:get/get.dart';
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/src/modules/payments/domain/dtos/payments_response_dto.dart';

class PaymentsRepository extends ApiBaseProvider {

  @override
  final String url = AppConfig.baseUrlMedicos;
  @override
  final String contextPath = '/gestor-medico/medicos';

  Future<Response<PaymentsDto>> fetchPayments({
    required String rfc,
    required String jwt,
    required String filtros,
  }) => get(
      '/$rfc/pagos$filtros',
      headers: {'Authorization': 'Bearer $jwt'},
      decoder: (body) {
        if (body is Map<String, dynamic>) {
          return PaymentsDto.fromJson(body);
        }
        return PaymentsDto.empty();
      }
    );
}
