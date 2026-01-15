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
import 'package:medicos/shared/widgets/wdgt_image_from_web.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';
import 'package:medicos/src/modules/profile/children/fiscal_data/fiscal_data_controller.dart';
import 'package:medicos/src/modules/profile/widgets/card_data_bank.dart';

part 'fiscal_data_bindings.dart';
part 'fiscal_data_middleware.dart';
part 'fiscal_data_route_params.dart';
part 'responsive/fiscal_data_desktop_page.dart';
part 'responsive/fiscal_data_phone_page.dart';
part 'responsive/fiscal_data_tablet_page.dart';

class DatosFiscalesPage extends GetResponsiveView<DatosFiscalesController> {
  DatosFiscalesPage({super.key});

  static final GetPage page = GetPage(
    name: '/datos-fiscales',
    page: DatosFiscalesPage.new,
    binding: _DatosFiscalesBindings(),
    middlewares: [_DatosFiscalesMiddleware(), AuthGuard()],
  );

  @override
  Widget? phone() => _DatosFiscalesPhonePage();

  @override
  Widget? tablet() => const _DatosFiscalesTabletPage();

  @override
  Widget? desktop() => DatosFiscalesDesktopPage();
}
