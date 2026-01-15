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
import 'package:medicos/src/modules/profile/children/personal_data/personal_data_controller.dart';

part 'personal_data_bindings.dart';

part 'personal_data_middleware.dart';

part 'personal_data_route_params.dart';

part 'responsive/personal_data_desktop_page.dart';

part 'responsive/personal_data_phone_page.dart';

part 'responsive/personal_data_tablet_page.dart';

class DatosPersonalesPage extends GetResponsiveView<DatosPersonalesController> {
  DatosPersonalesPage({super.key});

  static final GetPage page = GetPage(
    name: '/datos-personales',
    page: DatosPersonalesPage.new,
    binding: _DatosPersonalesBindings(),
    middlewares: [_DatosPersonalesMiddleware(), AuthGuard()],
  );

  @override
  Widget? phone() => _DatosPersonalesPhonePage();

  @override
  Widget? tablet() => const _DatosPersonalesTabletPage();

  @override
  Widget? desktop() => DatosPersonalesDesktopPage();
}
