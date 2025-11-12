import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/core/services/navigation/route_params.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/appbar_phone.dart';
import 'package:medicos/shared/widgets/banner_medico.dart';
import 'package:medicos/shared/widgets/card_file_download.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';
import 'package:medicos/src/modules/formats/domain/remote/formats_repository.dart';
import 'package:medicos/src/modules/formats/formats_controller.dart';

part 'formats_bindings.dart';

part 'formats_middleware.dart';

part 'formats_route_params.dart';

part 'responsive/formats_desktop_page.dart';

part 'responsive/formats_phone_page.dart';

part 'responsive/formats_tablet_page.dart';

class FormatsPage extends GetResponsiveView<FormatsController> {
  FormatsPage({super.key});

  static final GetPage page = GetPage(
    name: '/formatos',
    page: FormatsPage.new,
    binding: _FormatsBindings(),
    middlewares: [_FormatsMiddleware()]
  );

  @override
  Widget? phone() => _FormatsPhonePage();

  @override
  Widget? tablet() => _FormatsTabletPage();

  @override
  Widget? desktop() => _FormatsDesktopPage();
}
