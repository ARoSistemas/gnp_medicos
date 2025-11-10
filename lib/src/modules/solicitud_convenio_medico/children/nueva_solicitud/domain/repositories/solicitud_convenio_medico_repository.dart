import 'package:get/get.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/core/services/threads/threads_service.dart';
import 'package:medicos/shared/models/incoming/solicitudes_model.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/nueva_solicitud/domain/dtos/agreement_registration_dto.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/nueva_solicitud/domain/entities/catalog_convenio_mdl.dart';

class SolicitudConvenioMedicoRepository extends ApiBaseProvider {
  final ThreadsService threadsService = Get.find<ThreadsService>();

  @override
  final String url = 'https://admonproveedoressalud-services-qa.gnp.com.mx';

  @override
  String contextPath = '';

  Future<List<SolicitudModel>> getRequestsAgreement(
    String idAssistant,
    String jwt,
  ) async {
    final String solicitudEndPoint = '/gestor-medico/solicitudes/$idAssistant';
    final Response<List<SolicitudModel>> ret = await get(
      solicitudEndPoint,
      headers: finalHeaders(jwt),
      decoder: (data) {
        if (data is Map && data.containsKey('status')) {
          /// Falló por token expirado
          return [];
        }
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);

        final List<SolicitudModel> listaFinal = dataList
            .map(SolicitudModel.fromMap)
            .toList();

        return listaFinal;
      },
    );
    return ret.body ?? [];
  }

  Future<List<CatalogConvenioModel>> getSpecialty(
    String jwt,
  ) async {
    const String solicitudEndPoint = '/gestor-medico/catalogo/especialidad';

    final Response<List<CatalogConvenioModel>> ret = await get(
      solicitudEndPoint,
      headers: finalHeaders(jwt),
      decoder: (data) {
        if (data is Map && data.containsKey('status')) {
          /// Falló por token expirado
          return [];
        }
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);

        final List<CatalogConvenioModel> listaFinal = dataList
            .map(CatalogConvenioModel.fromMap)
            .toList();

        return listaFinal;
      },
    );
    return ret.body ?? [];
  }

  Future<List<CatalogConvenioModel>> getSubspecialty(
    String jwt,
  ) async {
    const String solicitudEndPoint = '/gestor-medico/catalogo/subespecialidad';

    final Response<List<CatalogConvenioModel>> ret = await get(
      solicitudEndPoint,
      headers: finalHeaders(jwt),
      decoder: (data) {
        if (data is Map && data.containsKey('status')) {
          /// Falló por token expirado
          return [];
        }
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);

        final List<CatalogConvenioModel> listaFinal = dataList
            .map(CatalogConvenioModel.fromMap)
            .toList();

        return listaFinal;
      },
    );
    return ret.body ?? [];
  }

  Future<List<CatalogConvenioModel>> getHopitalAttention(
    String jwt,
  ) async {
    const String solicitudEndPoint =
        '/gestor-medico/catalogo/hospital-atencion';

    final Response<List<CatalogConvenioModel>> ret = await get(
      solicitudEndPoint,
      headers: finalHeaders(jwt),
      decoder: (data) {
        if (data is Map && data.containsKey('status')) {
          /// Falló por token expirado
          return [];
        }
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);

        final List<CatalogConvenioModel> listaFinal = dataList
            .map(CatalogConvenioModel.fromMap)
            .toList();

        return listaFinal;
      },
    );
    return ret.body ?? [];
  }

  Future<List<CatalogConvenioModel>> getState(
    String jwt,
  ) async {
    const String solicitudEndPoint = '/convenio/catalogo/estado';

    final Response<List<CatalogConvenioModel>> ret = await get(
      solicitudEndPoint,
      headers: finalHeaders(jwt),
      decoder: (data) {
        if (data is Map && data.containsKey('status')) {
          /// Falló por token expirado
          return [];
        }
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);

        final List<CatalogConvenioModel> listaFinal = dataList
            .map(CatalogConvenioModel.fromMap)
            .toList();

        return listaFinal;
      },
    );
    return ret.body ?? [];
  }

  Future<Response<String>> newRequestAgreegament(
    AgreementRegistration registerRequestMode,
    String jwt,
  ) => post(
    headers: finalHeaders(jwt),
    '/gestor-medico/solicitud',
    registerRequestMode.toJson(),
    decoder: (data) {
      if (data is Map) {
        return data['solicitud']?.toString() ?? '';
      }
      return '';
    },
  );

  Map<String, String> finalHeaders(String jwt) => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $jwt',
  };
}
