import 'package:get/get.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/core/services/threads/threads_service.dart';
import 'package:medicos/shared/models/incoming/solicitudes_model.dart';

class SolicitudConvenioMedicoRepository extends ApiBaseProvider {
  final ThreadsService threadsService = Get.find<ThreadsService>();

  @override
  final String url = 'https://admonproveedoressalud-services-qa.gnp.com.mx';

  @override
  final String contextPath = '/gestor-medico';

  Future<List<SolicitudModel>> getRequestsAgreement(
    String idAssistant,
    String jwt,
  ) async {
    const String solicitudEndPoint = '/solicitudes/MDUMEIJ028';

    Response response = const Response(
      statusCode: 0,
      bodyString: '',
    );

    try {
      await threadsService.execute(
        func: () async {
          response = await get(
            headers: finalHeaders(jwt),
            solicitudEndPoint,
          );
        },
      );

      //Agregar la respuesta del servicio
      final List<dynamic> dataList = response.body;
      final List<SolicitudModel> listaFinal = dataList
          .map(
            (solicitud) =>
                SolicitudModel.fromMap(solicitud as Map<String, dynamic>),
          )
          .toList();
      return listaFinal;
    } on Exception catch (_) {
      return [];
    }
  }

  Map<String, String> finalHeaders(String jwt) => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $jwt',
  };
}
