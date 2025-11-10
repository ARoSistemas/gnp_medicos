import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/core/services/navigation/route_params.dart';
import 'package:medicos/shared/constans/constans.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/appbar_phone.dart';
import 'package:medicos/src/modules/convenio_medico/children/view_pdf/view_pdf_controller.dart';
import 'package:pdfrx/pdfrx.dart';

part 'view_pdf_bindings.dart';

part 'view_pdf_middleware.dart';

part 'view_pdf_route_params.dart';

part 'responsive/view_pdf_desktop_page.dart';

part 'responsive/view_pdf_phone_page.dart';

part 'responsive/view_pdf_tablet_page.dart';

class ViewPdfPage extends GetResponsiveView<ViewPdfController> {
  ViewPdfPage({super.key});

  static final GetPage page = GetPage(
    name: '/view-pdf',
    page: ViewPdfPage.new,
    binding: _ViewPdfBindings(),
    middlewares: [_ViewPdfMiddleware()],
  );

  @override
  Widget? phone() => _ViewPdfPhonePage();

  @override
  Widget? tablet() => _ViewPdfTabletPage();

  @override
  Widget? desktop() => _ViewPdfDesktopPage();
}
