import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:medicos/core/config/app_config.dart';
import 'package:medicos/core/services/network/network_service.dart';
import 'package:medicos/core/services/threads/threads_service.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/upload_documents/children/request_documents/domain/dtos/tipye_documents_dto.dart';

class RequestDocumentsRepository extends ApiBaseProvider {
  final ThreadsService threadsService = Get.find<ThreadsService>();

  @override
  final String url = AppConfig.baseUrlMedicos;

  @override
  final String contextPath = '';

  Future<List<TypeDocumentModel>> getTypeDocuments(String jwt) async {
    final Response<List<TypeDocumentModel>> ret = await get(
      '/convenio/catalogo/tipo-documento',
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

  Future uploadDocument({
    required String jwt,
    required String idSolicitud,
    required String nameFile,
    required String typeFile,
    required Uint8List fileBytes,
  }) async {
    final form = FormData({
      'nombre': nameFile,
      'tipo': typeFile,
      'archivo': MultipartFile(fileBytes, filename: 'document.pdf'),
    });

    final Response ret = await post(
      '/gestor-medico/solicitud/$idSolicitud/documentos',
      form,
      headers: finalHeaders(jwt),
      decoder: (data) {},
    );
    return ret.body;
  }

  Future<Response> deleteUploadedDocument(
    String jwt,
    String documentId,
  ) async {
    final Response ret = await delete(
      '/gestor-medico/documentos/$documentId',
      headers: finalHeaders(jwt),
      contentType: ''
    );
    return ret;
  }

  Future getUploadedDocuments(
    String jwt,
    String idSolicitud,
  ) async {
    final Response ret = await get(
      '/gestor-medico/solicitud/$idSolicitud/documentos',
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
    return ret.body;
  }


  Map<String, String> finalHeaders(String jwt) => {
    'Authorization': 'Bearer $jwt',
  };
}
