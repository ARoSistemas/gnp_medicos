import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/core/services/navigation/route_params.dart';
import 'package:medicos/shared/mddlewares/auth_middleware.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/appbar_phone.dart';
import 'package:medicos/shared/widgets/banner_medico.dart';
import 'package:medicos/shared/widgets/section_title.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';
import 'package:medicos/src/modules/profile/children/academic_data/academic_data_controller.dart';

part 'academic_data_bindings.dart';

part 'academic_data_middleware.dart';

part 'academic_data_route_params.dart';

part 'responsive/academic_data_desktop_page.dart';

part 'responsive/academic_data_phone_page.dart';

part 'responsive/academic_data_tablet_page.dart';

class DatosAcademicosPage extends GetResponsiveView<DatosAcademicosController> {
  DatosAcademicosPage({super.key});

  static final GetPage page = GetPage(
    name: '/datos-academicos',
    page: DatosAcademicosPage.new,
    binding: _DatosAcademicosBindings(),
    middlewares: [_DatosAcademicosMiddleware(), AuthGuard()],
  );

  @override
  Widget? phone() => _DatosAcademicosPhonePage();

  @override
  Widget? tablet() => const _DatosAcademicosTabletPage();

  @override
  Widget? desktop() => DatosAcademicosDesktopPage();
}
