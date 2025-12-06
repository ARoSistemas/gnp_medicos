import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/shared/widgets/custom_notification.dart';
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
    int? mbSize
  }) async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: type,
        allowedExtensions: allowedExtensions,
        withData: true,
      );

      
      if (result?.files.single != null && mbSize != null) {
       final int maxFileSizeInBytes = (mbSize.value()) * 1024 * 1024;
       if (result!.files.single.size > maxFileSizeInBytes) {
          appService.notifications.show(
            title: 'Archivo demasiado grande',
            message: 'El tamaño del archivo no debe exceder los $mbSize MB.',
            type: AlertType.warning,
          );
          return null;
        }
      }
      return result?.files.single;
    } on Exception catch (e) {
      appService.notifications.show(
        title: 'Error',
        message: 'Error al cargar el archivo: $e.',
        type: AlertType.error,
      );
    }
    return null;
  }
}
