import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/card_file_download.dart';
import 'package:medicos/shared/widgets/wdgt_appbar_phone.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';
import 'package:medicos/src/modules/anexos/anexos_controller.dart';
import 'package:medicos/src/modules/anexos/domain/repository/annexes_repository.dart';

part 'anexos_bindings.dart';

part 'anexos_middleware.dart';

part 'responsive/anexos_desktop_page.dart';

part 'responsive/anexos_phone_page.dart';

part 'responsive/anexos_tablet_page.dart';

class AnexosPage extends GetResponsiveView<AnexosController> {
  AnexosPage({super.key});

  static final GetPage page = GetPage(
    name: '/anexos',
    page: AnexosPage.new,
    binding: _AnexosBindings(),
    middlewares: [_AnexosMiddleware()],
  );

  @override
  Widget? phone() => _AnexosPhonePage();

  @override
  Widget? tablet() => _AnexosTabletPage();

  @override
  Widget? desktop() => _AnexosDesktopPage();
}
