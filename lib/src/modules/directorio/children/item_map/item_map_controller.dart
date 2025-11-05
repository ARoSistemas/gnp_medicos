import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/domain/entities/models/items_results_mdl.dart';

part 'item_map_model.dart';

class ItemMapController extends GetxController
    with StateMixin<_ItemMapModel>, WidgetsBindingObserver {
  final AppStateController appState = Get.find<AppStateController>();

  final Rx<ItemsResultsMdl> itemToShow = ItemsResultsMdl.empty().obs;
  final RxString titleAppBar = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    final Map<String, dynamic> arg =
        Get.arguments as Map<String, dynamic>? ?? {};

    itemToShow.value =
        arg['item'] as ItemsResultsMdl? ?? ItemsResultsMdl.empty();
    titleAppBar.value = arg['titleAppBar'] as String? ?? '';

    await fetchResultsList();

    change(
      _ItemMapModel.empty().copyWith(
        name: titleAppBar.value,
      ),
      status: RxStatus.success(),
    );
  }

  Future<void> fetchResultsList() async {
    await Future.delayed(const Duration(milliseconds: 750), () {});
  }
}
