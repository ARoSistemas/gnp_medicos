import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/core/services/navigation/route_params.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart'
    show ColorPalette;
import 'package:medicos/shared/widgets/appbar_phone.dart';
import 'package:medicos/shared/widgets/banner_medico.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/upload_documents/children/request_documents/domain/repositories/request_documents_repository.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/upload_documents/children/request_documents/request_documents_controller.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/upload_documents/children/request_documents/widgets/card_upload_format.dart';

part 'request_documents_bindings.dart';

part 'request_documents_middleware.dart';

part 'request_documents_route_params.dart';

part 'responsive/request_documents_desktop_page.dart';

part 'responsive/request_documents_phone_page.dart';

part 'responsive/request_documents_tablet_page.dart';

class RequestDocumentsPage
    extends GetResponsiveView<RequestDocumentsController> {
  RequestDocumentsPage({super.key});

  static final GetPage page = GetPage(
    name: '/request-documents',
    page: RequestDocumentsPage.new,
    binding: _RequestDocumentsBindings(),
    middlewares: [_RequestDocumentsMiddleware()],
  );

  @override
  Widget? phone() => _RequestDocumentsPhonePage();

  @override
  Widget? tablet() => _RequestDocumentsTabletPage();

  @override
  Widget? desktop() => _RequestDocumentsDesktopPage();
}
