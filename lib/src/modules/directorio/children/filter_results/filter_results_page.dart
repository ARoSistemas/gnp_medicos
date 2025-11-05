import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/filter_results_controller.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/widgets/wdgt_item_results.dart';
import 'package:medicos/src/modules/directorio/children/item_map/item_map_page.dart';

part 'filter_results_bindings.dart';

part 'responsive/filter_results_desktop_page.dart';
part 'responsive/filter_results_phone_page.dart';
part 'responsive/filter_results_tablet_page.dart';

class FilterResultsPage extends GetResponsiveView<FilterResultsController> {
  FilterResultsPage({super.key});

  static final GetPage page = GetPage(
    name: '/filter-results-page',
    page: FilterResultsPage.new,
    binding: _FilterResultsBindings(),
  );

  @override
  Widget? phone() => _FilterResultsPhonePage();

  @override
  Widget? tablet() => _FilterResultsTabletPage();

  @override
  Widget? desktop() => _FilterResultsDesktopPage();
}
