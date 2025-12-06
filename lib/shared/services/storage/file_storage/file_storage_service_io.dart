import 'dart:io';
import 'dart:typed_data';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/shared/services/storage/file_storage/file_storage_service.dart';
import 'package:medicos/shared/widgets/custom_notification.dart';
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
      appService.notifications.show(
        title: 'Error',
        message: 'Error al descargar o compartir: $e.',
        type: AlertType.error,
      );
    }
  }
}
