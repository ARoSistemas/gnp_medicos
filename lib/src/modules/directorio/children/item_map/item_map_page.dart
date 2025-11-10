import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/wdgt_loading.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/filter_results_controller.dart';
import 'package:medicos/src/modules/directorio/children/item_map/item_map_controller.dart';

part 'item_map_bindings.dart';

part 'responsive/item_map_desktop_page.dart';
part 'responsive/item_map_phone_page.dart';
part 'responsive/item_map_tablet_page.dart';

class ItemMapPage extends GetResponsiveView<FilterResultsController> {
  ItemMapPage({super.key});

  static final GetPage page = GetPage(
    name: '/item-map-page',
    page: ItemMapPage.new,
    binding: _ItemMapBindings(),
  );

  @override
  Widget? phone() => _ItemMapPhonePage();

  @override
  Widget? tablet() => _ItemMapTabletPage();

  @override
  Widget? desktop() => _ItemMapDesktopPage();
}
