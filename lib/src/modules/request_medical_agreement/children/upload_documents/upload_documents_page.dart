import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/core/services/navigation/route_params.dart';
import 'package:medicos/shared/mddlewares/auth_middleware.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/appbar_phone.dart';
import 'package:medicos/shared/widgets/appbar_web.dart';
import 'package:medicos/shared/widgets/banner_medico.dart';
import 'package:medicos/shared/widgets/section_title.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/request_medical_agreement/children/upload_documents/children/request_documents/request_documents_page.dart';
import 'package:medicos/src/modules/request_medical_agreement/children/upload_documents/children/request_documents/widgets/upload_download_formats.dart';
import 'package:medicos/src/modules/request_medical_agreement/children/upload_documents/upload_documents_controller.dart';

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
    transition: Transition.rightToLeft,
    customTransition: MenuWebAdaptiveTransition(),
    binding: _UploadDocumentsBindings(),
    middlewares: [_UploadDocumentsMiddleware(), AuthGuard()],
  );

  @override
  Widget? phone() => _UploadDocumentsPhonePage();

  @override
  Widget? tablet() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: const _UploadDocumentsTabletPage(),
  );

  @override
  Widget? desktop() => MenuWeb(
    breadcrumbs: controller.breadcrumbs,
    child: _UploadDocumentsDesktopPage(),
  );
}
