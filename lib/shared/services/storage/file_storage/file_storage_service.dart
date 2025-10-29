import 'dart:typed_data';
export 'file_storage_service_io.dart'
    if (dart.library.html) 'file_storage_service_web.dart';

abstract class FileStorageBase {
  Future<void> downloadAndShareFile({
    required Uint8List data,
    required String fileName,
  });

  void pickFile() {}
}
