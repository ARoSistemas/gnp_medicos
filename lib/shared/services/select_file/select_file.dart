import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/shared/widgets/custom_notification.dart';

class SelectFileService extends GetxService {
  static SelectFileService get i => Get.find();

  Future<PlatformFile?> pickFile({
    FileType type = FileType.custom,
    List<String>? allowedExtensions,
  }) async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: type,
        allowedExtensions: allowedExtensions,
        withData: true,
      );

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
