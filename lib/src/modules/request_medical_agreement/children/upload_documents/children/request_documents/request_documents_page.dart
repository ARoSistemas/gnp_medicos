import 'package:desktop_drop/desktop_drop.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/core/services/navigation/route_params.dart';
import 'package:medicos/shared/mddlewares/auth_middleware.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/appbar_phone.dart';
import 'package:medicos/shared/widgets/banner_medico.dart';
import 'package:medicos/shared/widgets/section_title.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';
import 'package:medicos/src/modules/request_medical_agreement/children/upload_documents/children/request_documents/domain/dtos/tipye_documents_dto.dart';
import 'package:medicos/src/modules/request_medical_agreement/children/upload_documents/children/request_documents/domain/repositories/request_documents_repository.dart';
import 'package:medicos/src/modules/request_medical_agreement/children/upload_documents/children/request_documents/request_documents_controller.dart';
import 'package:medicos/src/modules/request_medical_agreement/children/upload_documents/children/request_documents/widgets/card_upload_format.dart';

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
    middlewares: [_RequestDocumentsMiddleware(), AuthGuard()],
  );

  @override
  Widget? phone() => _RequestDocumentsPhonePage();

  @override
  Widget? tablet() => const _RequestDocumentsTabletPage();

  @override
  Widget? desktop() => _RequestDocumentsDesktopPage();
}
/// Widget público para reutilizar la vista desktop del perfil en otros módulos
class RequestDocumentsDesktopView extends StatelessWidget {
  const RequestDocumentsDesktopView({
    super.key,
  });

  @override
  Widget build(BuildContext context){
    Get
    ..put(RequestDocumentsRepository())
    ..lazyPut<RequestDocumentsController>(
        RequestDocumentsController.new,
    );
    return _RequestDocumentsDesktopPage();
  }
}
