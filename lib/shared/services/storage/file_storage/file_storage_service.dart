import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
export 'file_storage_service_io.dart'
    if (dart.library.html) 'file_storage_service_web.dart';

abstract class FileStorageBase {
  Future<void> downloadAndShareFile({
    required Uint8List data,
    required String fileName,
  });
  
  Future<PlatformFile?> pickFile({
    FileType type = FileType.custom,
    List<String>? allowedExtensions,
    int? mbSize,
  });
}
