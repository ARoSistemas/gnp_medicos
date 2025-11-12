part of 'upload_documents_page.dart';

// If you don't use it, you can remove this file
class UploadDocumentsRouteParams extends RouteParams {
  UploadDocumentsRouteParams({
    required super.id,
  });

  @override
  String get keyId => 'uploadDocumentsId';

  String? get idSolicitud => id;
}
