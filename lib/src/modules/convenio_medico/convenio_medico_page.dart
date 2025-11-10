import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/constans/constans.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/appbar_phone.dart';
import 'package:medicos/shared/widgets/banner_medico.dart';
import 'package:medicos/shared/widgets/section_title.dart';

import 'package:medicos/src/modules/convenio_medico/convenio_medico_controller.dart';

part 'convenio_medico_bindings.dart';
part 'responsive/convenio_medico_desktop_page.dart';
part 'responsive/convenio_medico_phone_page.dart';
part 'responsive/convenio_medico_tablet_page.dart';

class ConvenioMedicoPage extends GetResponsiveView<ConvenioMedicoController> {
  ConvenioMedicoPage({super.key});

  static final GetPage page = GetPage(
    name: '/convenio-medico',
    page: ConvenioMedicoPage.new,
    transition: Transition.rightToLeft,
    binding: _ConvenioMedicoBindings(),
  );

  @override
  Widget? phone() => _ConvenioMedicoPhonePage();

  @override
  Widget? tablet() => _ConvenioMedicoTabletPage();

  @override
  Widget? desktop() => _ConvenioMedicoDesktopPage();
}
