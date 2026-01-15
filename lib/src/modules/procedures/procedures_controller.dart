import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/utils/exception_manager.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/utils/enums.dart';
import 'package:medicos/shared/widgets/custom_alert.dart';
import 'package:medicos/shared/widgets/wdgt_calendar.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/procedures/domain/dtos/my_procedures_dto.dart';
import 'package:medicos/src/modules/procedures/domain/entities/folio_mdl.dart';
import 'package:medicos/src/modules/procedures/domain/repository/procedures_repository.dart';
import 'package:medicos/src/modules/procedures/responsive/widgets/wdgt_filter_selector.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';

part 'procedures_model.dart';

class ProceduresController extends GetxController
    with StateMixin<_ProceduresModel> {
  final Rx<AppLayout> viewType = AppLayout.mobile.obs;
  final AppStateController appState = Get.find();
  final ProceduresRepository _apiCon = Get.find();

  UserModel get user => appState.user;
  String get jwt => appState.user.token.jwt;

  bool get isWebView => viewType.value == AppLayout.desktop;

  /// Scroll controller for pagination
  final ScrollController scrollCtlerMobile = ScrollController();
  final TextEditingController filterInputCtrler = TextEditingController();

  /// Indicates if more data is being fetched for pagination
  RxBool isFetchingMore = false.obs;

  /// Next page token for pagination
  String nextPageToken = '';

  /// Current page index for pagination
  RxInt currentPage = 1.obs;

  /// Indicates if the Alert about no more data has been shown
  bool hasShownAlert = false;

  /// List of folios to retrieve
  RxList<FolioSiniestro> folios = <FolioSiniestro>[].obs;

  /// Indicates if the filter panel is open (for web)
  RxBool isFilterOpen = false.obs;

  /// Filters
  String folio = '';
  String nombreAsegurado = '';
  String padecimiento = '';
  String poliza = '';
  String hospitalAtencion = '';
  String estatus = '';
  String fechaApertura = '';
  String fechaAperturaIni = '';
  String fechaAperturaFin = '';

  /// Options for filtering
  final List<String> optionsFilters = [
    'Folio / Siniestro',
    'Nombre del asegurado',
    'Padecimiento',
    'Póliza',
    'Hospital de atención',
    'Estado del trámite',
    'Fecha del trámite',
  ];
  RxBool isFilterApplied = false.obs;
  RxString appliedFilterOption = ''.obs;

  /// Sorting
  RxString sortColumn = 'folio'.obs;
  RxBool sortAscending = true.obs;

  /// Breadcrumbs for navigation
  List<BreadcrumbWeb> breadcrumbs = [
    BreadcrumbWeb(msg.home.tr(), route: WelcomePage.page.name),
    BreadcrumbWeb(msg.myProcedures.tr()),
  ];

  /// List of pages, each containing a list of FolioSiniestro
  List<List<FolioSiniestro>> listPages = [];

  /// Get total local pages available
  int get totalLocalPages => listPages.length;

  /// Check if can go to previous page
  bool get canGoPrevious => currentPage.value > 1;

  /// Check if can go to next page
  bool get canGoNext =>
      currentPage.value < listPages.length || !(state?.isLastPage ?? false);

  @override
  Future<void> onInit() async {
    super.onInit();
    change(const _ProceduresModel(), status: RxStatus.loading());

    /// Listen to scroll events for pagination
    scrollCtlerMobile.addListener(_onScroll);

    /// Fetch initial data for mobile
    await _fetchFolios();
  }

  @override
  void onClose() {
    scrollCtlerMobile.removeListener(_onScroll);
    filterInputCtrler.dispose();
    scrollCtlerMobile.dispose();
    super.onClose();
  }

  /// We obtain the data for the states
  // $rfc/tramites
  Future<bool> _fetchFolios() => appService.threads.execute(
    customExceptionMessages: {
      Exception(): ExceptionAlertProperties(
        message: msg.errorToGetProcedures.tr(),
      ),
    },
    func: () async {
      final String filtros = _buildFilters();

      // rfc: 'OHA051017KE7',
      // rfc: 'CACE681015S90',
      final Response<MyProceduresDto> hasData = await _apiCon.fetchFolios(
        rfc: user.rfc,
        jwt: jwt,
        filtros: filtros,
      );

      final MyProceduresDto dataDTO = hasData.body!;
      if (dataDTO.entidad.data.isEmpty) {
        change(state, status: RxStatus.empty());
        return;
      }

      final List<FolioSiniestro> newFolios = dataDTO.entidad.data
          .map(
            (e) => FolioSiniestro(
              idTramite: e.idTramite,
              folio: e.folioTransaccion,
              nombreAsegurado: e.nombreAsegurado,
              fechaSiniestro: e.fechaSiniestro,
              padecimiento: e.padecimientoIcd,
              hospitalAtencion: e.hospitalAtencion,
              estatus: e.estatus,
              poliza: e.nroPoliza,
            ),
          )
          .toList();

      /// Para WEB: Se divide en páginas de 10 items en cache
       _splitPages(newFolios);
      updateFoliosFromCurrentPage();

      change(
        _ProceduresModel.empty().copyWith(
          totalItems: dataDTO.entidad.totalItems,
          totalPages: dataDTO.entidad.totalPages,
          queryPageSize: dataDTO.entidad.queryPageSize,
          nextPageToken: dataDTO.entidad.nextPageToken,
          isLastPage: dataDTO.entidad.nextPageToken.isEmpty,
        ),
        status: RxStatus.success(),
      );
    },
    onError: () {
      change(state, status: RxStatus.success());
      appService.alert.show(
        type: AlertType.info,
        title: msg.error.tr(),
        message: msg.errorToGetProcedures.tr(),
      );
    },
  );

  /// Valid filters:
  // folio=SIGRHO250524000108&
  // nombreAsegurado=Carlos%20Donoso&
  // padecimiento=LIPOMA&
  // poliza=34566789&
  // hospitalAtencion=Cl%C3%ADnica%20centro&
  // estatus=Cancelado&
  // fechaApertura=2025-01-30&
  // pageSize=20&
  // pageToken=v1.eyJ0IjoiT2JqZWN0cy4xIiwicHMiOjEwLCJ0b2tlbiI6InYzLmV5Sn
  // sort=$COLUMNA,asc|desc
  String _buildFilters() {
    final String pageToken = state?.nextPageToken ?? '';
    if (folio.isEmpty &&
        nombreAsegurado.isEmpty &&
        padecimiento.isEmpty &&
        poliza.isEmpty &&
        hospitalAtencion.isEmpty &&
        estatus.isEmpty &&
        fechaApertura.isEmpty &&
        pageToken.isEmpty &&
        sortColumn.value.isEmpty) {
      return '';
    }

    final StringBuffer filtros = StringBuffer('?');

    if (folio.isNotEmpty) {
      filtros.write('folio=$folio');
    }
    if (nombreAsegurado.isNotEmpty) {
      filtros.write(
        '${folio.isEmpty ? '' : '&'}nombreAsegurado=$nombreAsegurado',
      );
    }
    if (padecimiento.isNotEmpty) {
      filtros.write(
        '''${(folio.isEmpty && nombreAsegurado.isEmpty) ? '' : '&'}padecimiento=$padecimiento''',
      );
    }
    if (poliza.isNotEmpty) {
      filtros.write(
        '''${(folio.isEmpty && nombreAsegurado.isEmpty && padecimiento.isEmpty) ? '' : '&'}poliza=$poliza''',
      );
    }
    if (hospitalAtencion.isNotEmpty) {
      filtros.write(
        '''${(folio.isEmpty && nombreAsegurado.isEmpty && padecimiento.isEmpty && poliza.isEmpty) ? '' : '&'}hospitalAtencion=$hospitalAtencion''',
      );
    }
    if (estatus.isNotEmpty) {
      filtros.write(
        '''${(folio.isEmpty && nombreAsegurado.isEmpty && padecimiento.isEmpty && poliza.isEmpty && hospitalAtencion.isEmpty) ? '' : '&'}estatus=$estatus''',
      );
    }
    if (fechaApertura.isNotEmpty) {
      filtros.write(
        '''${(folio.isEmpty && nombreAsegurado.isEmpty && padecimiento.isEmpty && poliza.isEmpty && hospitalAtencion.isEmpty && estatus.isEmpty) ? '' : '&'}fechaAperturaIni=$fechaAperturaIni&fechaAperturaFin=$fechaAperturaFin''',
      );
    }

    /// Always add page size and page token
    filtros.write(
      '''${pageToken.isNotEmpty ? '&pageToken=$pageToken' : ''}&pageSize=10''',
    );

    /// Add sorting parameters if active
    if (sortColumn.value.isNotEmpty) {
      filtros.write(
        '''&sort=${sortColumn.value},${sortAscending.value ? 'asc' : 'desc'}''',
      );
    } else {
      filtros.write(
        '''&sort=fechaApertura,desc''',
      );
    }

    return filtros.toString();
  }

  /// Sort by column
  Future<void> onSort(String column) async {
    clearFiltersSort();
    if (sortColumn.value == column) {
      sortAscending.value = !sortAscending.value;
    } else {
      sortColumn.value = column;
      sortAscending.value = true;
    }

    // await _sortByColumn(column, ascending: sortAscending.value);
    hasShownAlert = false;

    change(
      state!.copyWith(
        nextPageToken: '',
        isLastPage: false,
      ),
      status: RxStatus.loading(),
    );

    await _fetchFolios();
  }

  /// Sort folios list by column
  // Future<void> _sortByColumn(String column, {bool ascending = true}) async {
  //   folios
  //     ..sort((a, b) {
  //       int result;

  //       switch (column) {
  //         case 'folio':
  //           result = a.folio.compareTo(b.folio);

  //         case 'nombreAsegurado':
  //           result = a.nombreAsegurado.compareTo(b.nombreAsegurado);

  //         case 'padecimiento':
  //           result = a.padecimiento.compareTo(b.padecimiento);

  //         case 'poliza':
  //           result = a.poliza.compareTo(b.poliza);

  //         case 'hospitalAtencion':
  //           result = a.hospitalAtencion.compareTo(b.hospitalAtencion);

  //         case 'estatus':
  //           result = a.estatus.compareTo(b.estatus);

  //         case 'fechaApertura':
  //           result = _compareDates(
  //             a.fechaSiniestro,
  //             b.fechaSiniestro,
  //           );

  //         default:
  //           result = 0;
  //       }

  //       return ascending ? result : -result;
  //     })
  //     ..refresh();
  // }

  /// Compare two date strings
  // int _compareDates(String a, String b) {
  //   final DateTime dateA = DateTime.parse(a);
  //   final DateTime dateB = DateTime.parse(b);
  //   return dateA.compareTo(dateB);
  // }

  /// Divide items into pages of 10 (WEB only)
  void _splitPages(List<FolioSiniestro> newItems) {
    for (int i = 0; i < newItems.length; i += 10) {
      final int end = (i + 10 < newItems.length) ? i + 10 : newItems.length;
      listPages.add(newItems.sublist(i, end));
    }
  }

  /// Update folios with items from current page (WEB only)
  void updateFoliosFromCurrentPage() {
    if (listPages.isEmpty) {
      folios.clear();
      return;
    }

    if (isWebView) {
      final int pageIndex = currentPage.value - 1;
      if (pageIndex >= 0 && pageIndex < listPages.length) {
        folios.value = List.from(listPages[pageIndex]);
      }
    } else {
      folios.value = listPages.expand((e) => e).toList();
    }
  }

  /// Navigate to next page (WEB only)
  Future<void> goToNextPage() async {
    final int nextPage = currentPage.value + 1;

    /// Check if the next page already exists in local storage
    if (nextPage <= listPages.length) {
      /// Page exists locally, just navigate
      currentPage.value = nextPage;
      updateFoliosFromCurrentPage();
      return;
    }

    /// The next page doesn't exist locally, check if we can fetch from server
    if (!(state?.isLastPage ?? false)) {
      /// There's more data on the server, fetch it
      await loadNextPage(isWeb: true);
      if (listPages.length >= nextPage) {
        /// Successfully fetched, navigate to the new page
        currentPage.value = nextPage;
        updateFoliosFromCurrentPage();
      }
    } else {
      /// No more data available
      appService.alert.show(
        type: AlertType.info,
        title: msg.endOfList.tr(),
        message: msg.noMoreProceduresToLoad.tr(),
      );
    }
  }

  /// Navigate to previous page (WEB only)
  void goToPreviousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
      updateFoliosFromCurrentPage();
    }
  }

  /// Load next page for pagination
  Future<void> loadNextPage({required bool isWeb}) async {
    /// if it's the last page, show alert once only for mobile
    if (state?.isLastPage ?? false) {
      if (!hasShownAlert && !isWeb) {
        appService.alert.show(
          type: AlertType.info,
          title: msg.endOfList.tr(),
          message: msg.noMoreProceduresToLoad.tr(),
        );
        hasShownAlert = true;
      }
      return;
    }

    /// Only for mobile
    if (!isWeb) {
      if (isFetchingMore.value) {
        return;
      }
    }

    isFetchingMore.value = true;
    await _fetchFolios();
    isFetchingMore.value = false;
  }

  /// Listen to scroll events for pagination
  Future<void> _onScroll() async {
    if (scrollCtlerMobile.position.pixels ==
        scrollCtlerMobile.position.maxScrollExtent) {
      await goToNextPage();
    }
  }

  /// Clear all applied filters
  void clearFilters() {
    folio = '';
    nombreAsegurado = '';
    padecimiento = '';
    poliza = '';
    hospitalAtencion = '';
    estatus = '';
    fechaApertura = '';
    isFilterApplied.value = false;
    appliedFilterOption.value = '';
    fechaAperturaIni = '';
    fechaAperturaFin = '';
    filterInputCtrler.clear();
    sortColumn.value = '';
    sortAscending.value = true;

    /// Reset local pagination (WEB)
    listPages.clear();
    currentPage.value = 1;
    folios.clear();
  }

  void clearFiltersSort() {
    nextPageToken = '';

    /// Reset local pagination (WEB)
    folios.clear();
    listPages.clear();
    currentPage.value = 1;
  }

  /// Set filters based on selected option
  void setFilters() {
    switch (appliedFilterOption.value) {
      case 'Folio / Siniestro':
        folio = filterInputCtrler.text;
      case 'Nombre del asegurado':
        nombreAsegurado = filterInputCtrler.text;
      case 'Padecimiento':
        padecimiento = filterInputCtrler.text;
      case 'Póliza':
        poliza = filterInputCtrler.text;
      case 'Hospital de atención':
        hospitalAtencion = filterInputCtrler.text;
      case 'Estado del trámite':
        estatus = filterInputCtrler.text;
      case 'Fecha del trámite':
        fechaApertura = filterInputCtrler.text;
      default:
    }
  }

  /// Check if any filters are applied
  Future<void> checkFilters() async {
    /// Validate that there is input in the search bar
    if (filterInputCtrler.text.isEmpty) {
      appService.alert.show(
        type: AlertType.warning,
        title: msg.emptyFilters.tr(),
        message: msg.selectFilterAndEnterData.tr(),
      );
      return;
    }
    change(state?.copyWith(
      nextPageToken: '',
      isLastPage: false
    ), status: RxStatus.loading());

    /// Apply the filter based on the selected option
    setFilters();

    /// Clear current folios and fetch again
    folios.clear();
    hasShownAlert = false;
    nextPageToken = '';

    /// Reset local pagination (WEB)
    listPages.clear();
    currentPage.value = 1;
    folios.clear();

    await _fetchFolios();
  }

  /// Show filter dialog
  Future<void> showFilterDialog() async {
    clearFilters();
    await showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) => FilterBottomSheet(
        options: optionsFilters,
        onOptionSelected: (opt) async {
          isFilterApplied.value = opt.isNotEmpty;
          appliedFilterOption.value = opt;
          if (appliedFilterOption.value == 'Fecha del trámite') {
            await showCalendar();
          }
        },
      ),
    );
  }

  /// Handle date range selection
  /// Only Web
  Future<void> showCalendar() async {
    if (appliedFilterOption.value != 'Fecha del trámite') {
      return;
    }

    final DateTimeRange<DateTime>? result = await CalendarService.instance
        .pickDateRange(
          context: Get.context!,
        );

    if (result != null) {
      fechaAperturaIni = result.start.toIso8601String().split('T').first;
      fechaAperturaFin = result.end.toIso8601String().split('T').first;
      filterInputCtrler.text = '$fechaAperturaIni - $fechaAperturaFin';

      /// call to search
      await checkFilters();
    } else {
      // If no date is selected, clear the applied filter
      if (listPages.isNotEmpty) {
        clearFilters();
        isFilterApplied.value = false;
        appliedFilterOption.value = '';
      }
    }
  }

  /// Show filter dialog for web
  Future<void> showFilterDialogWeb() async {
    clearFilters();
    isFilterOpen.value = !isFilterOpen.value;
  }
}
