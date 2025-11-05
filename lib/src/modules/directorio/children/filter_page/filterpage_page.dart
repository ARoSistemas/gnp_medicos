import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';
import 'package:medicos/src/modules/directorio/children/filter_page/filterpage_controller.dart';
import 'package:medicos/src/modules/directorio/children/filter_page/widgets/wdgt_dropdown_search_field.dart';
import 'package:medicos/src/modules/directorio/children/filter_page/widgets/wdgt_textfield_with_border.dart';

part 'filterpage_bindings.dart';

part 'responsive/filterpage_desktop_page.dart';
part 'responsive/filterpage_phone_page.dart';
part 'responsive/filterpage_tablet_page.dart';

class FilterPage extends GetResponsiveView<FilterPageController> {
  FilterPage({super.key});

  static final GetPage page = GetPage(
    name: '/filter-page',
    page: FilterPage.new,
    binding: _FilterPageBindings(),
  );

  @override
  Widget? phone() => _FilterPagePhonePage();

  @override
  Widget? tablet() => _FilterPageTabletPage();

  @override
  Widget? desktop() => _FilterPageDesktopPage();
}
