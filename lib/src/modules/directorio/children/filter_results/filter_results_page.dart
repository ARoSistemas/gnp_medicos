import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/domain/entities/models/clinicas_mdl.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/domain/entities/models/hospital_mdl.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/domain/entities/models/items_results_mdl.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/domain/entities/models/medico_mdl.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/domain/entities/models/saux_mdl.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/domain/repositories/filter_results_repository.dart';
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
