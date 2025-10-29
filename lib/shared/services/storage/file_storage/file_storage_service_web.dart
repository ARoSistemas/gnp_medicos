// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter
// ignore_for_file: document_ignores

import 'dart:html' as html;
import 'dart:typed_data';
import 'package:medicos/shared/services/storage/file_storage/file_storage_service.dart';

class FileStorageService extends FileStorageBase {
  @override
  Future<void> downloadAndShareFile({
    required Uint8List data,
    required String fileName,
  }) async {
    final blob = html.Blob([data]);
    final String url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
