import 'package:get/get.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/core/services/threads/threads_service.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/upload_documents/children/request_documents/domain/dtos/tipye_documents_dto.dart';

class RequestDocumentsRepository extends ApiBaseProvider {
  final ThreadsService threadsService = Get.find<ThreadsService>();

  @override
  final String url =
      'https://admonproveedoressalud-services-qa.gnp.com.mx/convenio';

  @override
  final String contextPath = '/catalogo';

  Future<List<TypeDocumentModel>> getTypeDocuments(String jwt) async {
    final Response<List<TypeDocumentModel>> ret = await get(
      '/tipo-documento',
      headers: finalHeaders(jwt),
      decoder: (data) {
        if (data is Map && data.containsKey('status')) {
          /// Falló por token expirado
          return [];
        }
        final List<Map<String, dynamic>> dataList =
            List<Map<String, dynamic>>.from(data);

        final List<TypeDocumentModel> listFinal = dataList
            .map(TypeDocumentModel.fromMap)
            .toList();
        return listFinal;
      },
    );
    return ret.body ?? [];
  }

  Map<String, String> finalHeaders(String jwt) => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $jwt',
  };
}
