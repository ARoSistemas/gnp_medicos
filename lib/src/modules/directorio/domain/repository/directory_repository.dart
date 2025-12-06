import 'package:get/get_connect/http/src/response/response.dart';
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/src/modules/directorio/children/filter_page/domain/entities/models/estado_mdl.dart';

class DirectoryRepository extends ApiBaseProvider {
  @override
  final String url = AppConfig.urlDirectorio;

  @override
  final String contextPath = '/integracion/catalogo';

  /// Fetch data for Estados
  // url:: https://api-uat.oscpuat.gnp.com.mx/redesMedicas/catalogo/estados
  // Respuesta de apiResponseEstados ::
  // [
  //    {
  //       "claveEstado":"01",
  //       "estado":"AGUASCALIENTES"
  //    },
  //    {
  //       "claveEstado":"02",
  //       "estado":"BAJA CALIFORNIA"
  //    }
  // ]
  Future<Response<List<EstadoMdl>>> fetchEstados() => get(
    '/estados',
    headers: {
      'Content-Type': 'application/json',
      'apiKey': 'l7xxea7d6e3359234e548aac02166bca4b4b',
    },
    decoder: (data) {
      if (data is List) {
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);
        return dataList.map(EstadoMdl.fromMap).toList();
      }

      return [];
    },
  );
}
