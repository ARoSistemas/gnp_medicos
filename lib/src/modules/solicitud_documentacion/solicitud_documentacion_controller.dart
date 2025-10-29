import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';

part 'solicitud_documentacion_model.dart';

class SolicitudDocumentacionController extends GetxController
    with
        StateMixin<_SolicitudDocumentacionModel>,
        GetSingleTickerProviderStateMixin {
          
  final AppStateController appState = Get.find<AppStateController>();
  UserModel get user => appState.user;

  late TabController tabController;
  final RxInt selectedIndex = 0.obs;
  final Rx<String?> selectedItem = Rx<String?>(null);

  final List<String> items = ['Carta de adhesión', 'Opción 2', 'Opción 3'];

  void updateSelectedValue(String? newValue) {
    if (newValue != null) {
      selectedItem.value = newValue;
    }
  }

  @override
  void onInit() {
    super.onInit();
    const _SolicitudDocumentacionModel solicitudDocumentacionModel =
        _SolicitudDocumentacionModel();
    change(solicitudDocumentacionModel, status: RxStatus.success());
    tabController = TabController(length: 2, vsync: this);

    tabController.addListener(() {
      selectedIndex.value = tabController.index;
    });
  }

  /* @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  } */
}
