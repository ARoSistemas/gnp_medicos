// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter
// ignore_for_file: document_ignores

import 'dart:html' as html;
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/shared/services/storage/file_storage/file_storage_service.dart';
import 'package:medicos/shared/widgets/custom_alert.dart';

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

  @override
  Future<PlatformFile?> pickFile({
    FileType type = FileType.custom,
    List<String>? allowedExtensions,
    int? mbSize,
  }) async {
    try {
      final String ext = (allowedExtensions?? []).map((e) 
      => '.${e.toLowerCase()}').join(',');

      final input = html.FileUploadInputElement()
        ..accept = ext

      ..click();
      await input.onChange.first;

      if ((input.files ?? []).isEmpty) {
        return null;
      }

      final reader = html.FileReader()
      ..readAsArrayBuffer(input.files!.first);
      await reader.onLoad.first;

      final PlatformFile file = PlatformFile(
        name: input.files![0].name,
        size: input.files![0].size,
        path: input.files![0].relativePath,
        bytes: reader.result! as Uint8List,
      );

      if (allowedExtensions != null) {
        final String fileExtension = file.name.
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
        if (file.size > maxFileSizeInBytes) {
          appService.alert.show(
            title: 'Archivo demasiado grande',
            message: 'El tamaño del archivo no debe exceder los $mbSize MB.',
            type: AlertType.warning,
          );
          return null;
        }
      }
      return file;
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
