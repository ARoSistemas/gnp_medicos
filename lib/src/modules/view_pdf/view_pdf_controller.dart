import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/widgets/custom_alert.dart';
import 'package:medicos/src/modules/convenio_medico/domain/repository/convenio_medico_repository.dart';

part 'view_pdf_model.dart';

class ViewPdfController extends GetxController with StateMixin<_ViewPdfModel> {
  final ConvenioMedicoRepository convenioMedicoRepository = Get.put(
    ConvenioMedicoRepository(),
  );
  final AppStateController stateController = Get.find();

  RxBool isLoading = false.obs;

  late final Uint8List? file;
  late final String? title;
  bool download = true;
  bool get isPdf => title.value().toLowerCase().endsWith('.pdf');
  bool get isImage {
    final String name = title.value().toLowerCase();
    return name.endsWith('.jpg') ||
        name.endsWith('.png') ||
        name.endsWith('.jpeg');
  }

  bool get isDoc {
    final String name = title.value().toLowerCase();
    return name.endsWith('.doc') || name.endsWith('.docx');
  }

  bool get isXml {
    final String name = title.value().toLowerCase();
    return name.endsWith('.xml');
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    change(state, status: RxStatus.loading());
    final data = Get.arguments as Map;
    file = data['file'];
    title = data['title'];
    download = data['download'] ?? true;
    change(state, status: RxStatus.success());
  }

  @override
  Future<void> onReady() async{
    super.onReady();
    if (isDoc || isXml) {
      Get.back();
      await downloadDevice();
    }
  }

  Future<void> downloadDevice() async {
    if (file != null) {
      final fileName = '$title';
      await appService.fileStorage.downloadAndShareFile(
        data: file!,
        fileName: fileName,
      );
    } else {
      appService.alert.show(
        title: 'Error',
        message: 'Documento no disponible.',
        type: AlertType.error,
      );
    }
  }
}
