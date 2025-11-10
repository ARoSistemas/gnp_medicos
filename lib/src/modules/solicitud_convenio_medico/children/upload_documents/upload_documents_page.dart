import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/core/services/navigation/route_params.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/widgets/appbar_phone.dart';
import 'package:medicos/shared/widgets/banner_medico.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/upload_documents/children/request_documents/request_documents_page.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/upload_documents/children/request_documents/widgets/upload_download_formats.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/upload_documents/upload_documents_controller.dart';

part 'responsive/upload_documents_desktop_page.dart';
part 'responsive/upload_documents_phone_page.dart';
part 'responsive/upload_documents_tablet_page.dart';
part 'upload_documents_bindings.dart';
part 'upload_documents_middleware.dart';
part 'upload_documents_route_params.dart';

class UploadDocumentsPage extends GetResponsiveView<UploadDocumentsController> {
  UploadDocumentsPage({super.key});

  static final GetPage page = GetPage(
    name: '/upload-documents',
    page: UploadDocumentsPage.new,
    binding: _UploadDocumentsBindings(),
    middlewares: [_UploadDocumentsMiddleware()]
  );

  @override
  Widget? phone() => _UploadDocumentsPhonePage();

  @override
  Widget? tablet() => _UploadDocumentsTabletPage();

  @override
  Widget? desktop() => _UploadDocumentsDesktopPage();
}
