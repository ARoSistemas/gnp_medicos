import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/utils/exception_manager.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/directory/children/filter_page/domain/entities/models/estado_mdl.dart';
import 'package:medicos/src/modules/directory/children/filter_page/filterpage_controller.dart';
import 'package:medicos/src/modules/directory/children/filter_page/filterpage_page.dart';
import 'package:medicos/src/modules/directory/children/filter_results/domain/entities/models/item_results_mdl.dart';
import 'package:medicos/src/modules/directory/children/filter_results/filter_results_controller.dart';
import 'package:medicos/src/modules/directory/children/filter_results/filter_results_page.dart';
import 'package:medicos/src/modules/directory/children/item_map/item_map_controller.dart';
import 'package:medicos/src/modules/directory/children/item_map/item_map_page.dart';
import 'package:medicos/src/modules/directory/domain/entities/filter_directory_mdl.dart';
import 'package:medicos/src/modules/directory/domain/entities/items_directory_mdl.dart';
import 'package:medicos/src/modules/directory/domain/repository/directory_repository.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';

part 'directory_model.dart';

class DirectoryController extends GetxController
    with StateMixin<_DirectoryModel> {
  final AppStateController appState = Get.find();
  final DirectoryRepository _apiCon = Get.find();

  UserModel get user => appState.user;
  String get jwt => appState.user.token.jwt;

  List<BreadcrumbWeb> breadcrumbs = [
    BreadcrumbWeb(msg.home.tr(), route: WelcomePage.page.name),
    BreadcrumbWeb(msg.directory.tr()),
  ];

  /// Catalog for specialties
  List<Map<String, dynamic>> catEspecialidades = [];

  /// Catalog for medical circles
  List<Map<String, dynamic>> catCirculos = [];

  /// Catalog for states
  List<Map<String, dynamic>> catEstados = [];

  /// Catalog for hospital plans
  List<Map<String, dynamic>> catPlanHospitalario = [];

  /// Catalog for clinics
  List<Map<String, dynamic>> catClinicas = [];

  /// Catalog for other services
  List<Map<String, dynamic>> catOtrosServicios = [];

  /// Items in the directory
  final List<ItemDirectoryMdl> items = [
    // ItemDirectoryMdl(
    //   title: msg.medico.pValue!,
    //   subtitle: '${msg.medico.pValue!} ${msg.enconvenio.tr()}',
    //   idPage: 'medicos',
    //   img: 'icono_modulo_directorio_doctores.png',
    // ),
    ItemDirectoryMdl(
      title: msg.hospital.pValue!,
      subtitle: '${msg.hospital.pValue!} ${msg.inAgreement.tr()}',
      idPage: 'hospitales',
      img: 'icono_modulo_directorio_hospitales.png',
    ),

    ItemDirectoryMdl(
      title: msg.clinica.pValue!,
      subtitle: '${msg.clinica.pValue!} ${msg.inAgreement.tr()}',
      idPage: 'clinicas',
      img: 'icono_modulo_directorio_clinicas.png',
    ),

    ItemDirectoryMdl(
      title: msg.otherServices.tr(),
      subtitle: msg.otherServices.tr(),
      idPage: 'otros_servicios',
      img: 'icono_modulo_directorio_otros.png',
    ),
  ];

  /// Currently hovered index
  int? hoveredIndex;

  /// Currently selected index
  int? selectedIndex;

  /// **********************************
  /// For Web
  int selectedMenu = 0;

  /// Widget to display on the web page
  final Rx<Widget?> currentWebPage = Rx<Widget?>(null);

  /// Widget to display on the web page
  final Rx<Widget?> currentWebResultPage = Rx<Widget?>(null);

  /// Widget to display the map on the web page
  final Rx<Widget?> currentWebMapPage = Rx<Widget?>(null);

  final RxBool showFilterPage = true.obs;

  /// **********************************
  /// For Tablet
  final RxBool showMenuTablet = true.obs;

  final RxBool isTablet = false.obs;

  /// Store the selected item for tablet navigation
  ItemDirectoryMdl? selectedItem;

  @override
  Future<void> onInit() async {
    super.onInit();

    change(state, status: RxStatus.loading());

    if (catEstados.isEmpty) {
      final bool success = await _loadEstados();

      if (!success) {
        change(null, status: RxStatus.error(msg.errorLoadingStates.tr()));
        return;
      }
    }

    /// Initialize map without blocking the UI
    unawaited(showItemMapPage());

    change(const _DirectoryModel(), status: RxStatus.success());
  }

  /// We obtain the data for the states
  Future<bool> _loadEstados() => appService.threads.execute(
    customExceptionMessages: {
      Exception(): ExceptionAlertProperties(
        message: msg.errorLoadingStates.tr(),
      ),
    },
    func: () async {
      /// We obtain the data for the states
      final Response<List<EstadoMdl>> hasData = await _apiCon.fetchEstados();

      /// We save the temporary list
      final List<EstadoMdl> tmpData = hasData.body!;

      /// We build the list of states
      catEstados = [
        {'claveEstado': '0', 'estado': msg.all.tr()},
        ...tmpData.map(
          (e) => {
            'claveEstado': e.claveEstado,
            'estado': e.estado,
          },
        ),
      ];
    },
  );

  /// Navegar a filtro
  Future<void> gotoMobile(ItemDirectoryMdl item) async {
    await Get.toNamed(
      FilterPage.page.name,
      arguments: {
        'item': item,
        'catEspecialidades': catEspecialidades,
        'catCirculos': catCirculos,
        'catPlanHospitalario': catPlanHospitalario,
        'catClinicas': catClinicas,
        'catOtrosServicios': catOtrosServicios,
        'catEstados': catEstados,
      },
    )?.then((result) {
      if (result != null && result is Map) {
        catEspecialidades = result['catEspecialidades'];
        catCirculos = result['catCirculos'];
        catPlanHospitalario = result['catPlanHospitalario'];
        catClinicas = result['catClinicas'];
        catOtrosServicios = result['catOtrosServicios'];
      }
    });
  }

  /// Navegar a filtro (Web/Tablet)
  Future<void> gotoWeb(ItemDirectoryMdl item) async {
    /// Store selected item for tablet navigation
    selectedItem = item;

    /// If a results controller exists,
    /// delete it to avoid scroll controller conflicts.
    if (Get.isRegistered<FilterResultsController>()) {
      await Get.delete<FilterResultsController>();
    }

    /// Reset map to default state (Ciudad de México)
    if (Get.isRegistered<ItemMapController>()) {
      Get.find<ItemMapController>()
      .resetToDefaultLocation();
    }

    /// Show filter page
    showFilterPage.value = true;

    /// For tablet: hide menu when selecting an item, show map
    if (isTablet.value) {
      showMenuTablet.value = false;
    }

    /// change state to loading
    change(state, status: RxStatus.loading());

    /// Initialize the bindings for the filter page
    final Bindings? bindingsFilterPage = FilterPage.page.binding;

    if (bindingsFilterPage != null) {
      bindingsFilterPage.dependencies();
    }

    final FilterPageController filterController =
        Get.find<FilterPageController>()
          ..arguments = {
            'item': item,
            'catEspecialidades': catEspecialidades,
            'catCirculos': catCirculos,
            'catPlanHospitalario': catPlanHospitalario,
            'catClinicas': catClinicas,
            'catOtrosServicios': catOtrosServicios,
            'catEstados': catEstados,
          }
          ..isWeb = true;

    await filterController.setTypeSearch(item);
    currentWebPage.value = FilterPage();
    change(state, status: RxStatus.success());
  }

  /// Show results page (Web)
  Future<void> showResultsWebPage(ItemToSearchDirectoryMdl searchData) async {
    change(state, status: RxStatus.loading());

    /// Hide the filter page and destroy its controller
    showFilterPage.value = false;
    await Get.delete<FilterPageController>();

    /// Initialize the bindings for the results page
    final Bindings? bindings = FilterResultsPage.page.binding;
    if (bindings != null) {
      bindings.dependencies();
    }

    /// Find the controller and pass the arguments
    final FilterResultsController filterResultsController =
        Get.find<FilterResultsController>();

    filterResultsController.itemToSearch.value = searchData;

    await filterResultsController.setTypeSearch(searchData);

    currentWebResultPage.value = FilterResultsPage();

    change(state, status: RxStatus.success());
  }

  /// Show item on map (Web)
  Future<void> showItemOnMapWeb(
    ItemResultsMdl item,
    String titleAppBar,
  ) async {
    /// Update the existing map controller with the new item data
    if (Get.isRegistered<ItemMapController>()) {
      Get.find<ItemMapController>()
        ..arguments = {
          'item': item,
          'titleAppBar': titleAppBar,
        }
        ..initData();
    } else {
      /// Initialize the bindings for the map page if not exists
      final Bindings? bindings = ItemMapPage.page.binding;
      if (bindings != null) {
        bindings.dependencies();
      }

      Get.find<ItemMapController>()
        ..arguments = {
          'item': item,
          'titleAppBar': titleAppBar,
        }
        ..initData();

      currentWebMapPage.value = ItemMapPage();
    }
  }

  /// Show page Item Map
  Future<void> showItemMapPage() async {
    /// Initialize the bindings for the itemMap page only if not registered
    if (!Get.isRegistered<ItemMapController>()) {
      final Bindings? bindingsItemMap = ItemMapPage.page.binding;

      if (bindingsItemMap != null) {
        bindingsItemMap.dependencies();
      }
    }

    /// Get the map controller (onInit will handle initialization)
    Get.find<ItemMapController>();

    /// Set the map page widget
    currentWebMapPage.value = ItemMapPage();
  }

  /// Go back to menu (Tablet only)
  /// Shows menu and hides map, resets filter page
  Future<void> goBackToMenu() async {
    showMenuTablet.value = true;
    showFilterPage.value = true;
    currentWebPage.value = null;
    selectedIndex = null;

    /// Delete filter controller if exists
    if (Get.isRegistered<FilterPageController>()) {
      await Get.delete<FilterPageController>();
    }
  }

  /// Go back to filters from results (Tablet only)
  Future<void> goBackToFiltersTablet() async {
    showFilterPage.value = true;

    /// Delete results controller
    if (Get.isRegistered<FilterResultsController>()) {
      await Get.delete<FilterResultsController>();
    }

    currentWebResultPage.value = null;

    /// Recreate filter controller if there's a selected item
    if (selectedItem != null) {
      /// Initialize the bindings for the filter page
      final Bindings? bindingsFilterPage = FilterPage.page.binding;

      if (bindingsFilterPage != null) {
        bindingsFilterPage.dependencies();
      }

      final FilterPageController filterController =
          Get.find<FilterPageController>()
            ..arguments = {
              'item': selectedItem,
              'catEspecialidades': catEspecialidades,
              'catCirculos': catCirculos,
              'catPlanHospitalario': catPlanHospitalario,
              'catClinicas': catClinicas,
              'catOtrosServicios': catOtrosServicios,
              'catEstados': catEstados,
            }
            ..isWeb = true;

      await filterController.setTypeSearch(selectedItem!);
      currentWebPage.value = FilterPage();
    }
  }
}
