import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/shared/services/storage/file_storage/file_storage_service.dart';
import 'package:medicos/shared/widgets/custom_alert.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class FileStorageService extends FileStorageBase {
  @override
  Future<void> downloadAndShareFile({
    required Uint8List data,
    required String fileName,
  }) async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(data);
      final xFile = XFile(file.path);
      await SharePlus.instance.share(ShareParams(files: [xFile]));
    } on Exception catch (e) {
      appService.alert.show(
        title: 'Error',
        message: 'Error al descargar o compartir: $e.',
        type: AlertType.error,
      );
    }
  }

  @override
  Future<PlatformFile?> pickFile({
    FileType type = FileType.custom,
    List<String>? allowedExtensions,
    int? mbSize,
  }) async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: type,
        allowedExtensions: allowedExtensions
      );

      if (result?.files.single == null) {
        return null;
      }

      if (allowedExtensions != null) {
        final String fileExtension = result!.files.single.name.
        split('.').last.toLowerCase();
        if(!allowedExtensions.any((ext) => ext.toLowerCase() == fileExtension)){
          appService.alert.show(
            title: 'Archivo no permitido',
            message: 'El archivo no contiene una extension válida.',
            type: AlertType.warning,
          );
           return null;
        }
      }

      if (mbSize != null) {
        final int maxFileSizeInBytes = (mbSize.value()) * 1024 * 1024;
        if (result!.files.single.size > maxFileSizeInBytes) {
          appService.alert.show(
            title: 'Archivo demasiado grande',
            message: 'El tamaño del archivo no debe exceder los $mbSize MB.',
            type: AlertType.warning,
          );
          return null;
        }
      }
      return result?.files.single;
    } on Exception catch (e) {
      appService.alert.show(
        title: 'Error',
        message: 'Error al cargar el archivo: $e.',
        type: AlertType.error,
      );
    }
    return null;
  }
}
