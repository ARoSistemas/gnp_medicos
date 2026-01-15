import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/utils/exception_manager.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/utils/enums.dart';
import 'package:medicos/shared/widgets/custom_alert.dart';
import 'package:medicos/shared/widgets/wdgt_calendar.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/payments/domain/dtos/payments_response_dto.dart';
import 'package:medicos/src/modules/payments/domain/entities/payment.dart';
import 'package:medicos/src/modules/payments/domain/repository/payments_repository.dart';
import 'package:medicos/src/modules/procedures/responsive/widgets/wdgt_filter_selector.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';

part 'payments_model.dart';

class PaymentsController extends GetxController with StateMixin<PaymentsModel> {
  final Rx<AppLayout> viewType = AppLayout.mobile.obs;
  final AppStateController appState = Get.find();
  final PaymentsRepository _repository = Get.find();
  final ScrollController scrollCtrlerMobile = ScrollController();

  bool get isWebView => viewType.value == AppLayout.desktop;

  List<BreadcrumbWeb> breadcrumbs = [
    BreadcrumbWeb(msg.home.tr(), route: WelcomePage.page.name),
    BreadcrumbWeb(msg.myPayments.tr()),
  ];

  RxList<Payment> payments = <Payment>[].obs;
  RxBool isFetchingMore = false.obs;

  String get jwt => appState.user.token.jwt;
  UserModel get user => appState.user;

  final TextEditingController filterInputCtrler = TextEditingController();

  /// Indicates if the Alert about no more data has been shown
  bool hasShownAlert = false;

  /// Filtros
  String paymentDate = '';
  String paymentNumber = '';
  String claimNumber = '';
  String fechaAperturaIni = '';
  String fechaAperturaFin = '';

  RxBool isFilterApplied = false.obs;
  RxString appliedFilterOption = ''.obs;
  RxInt currentPage = 1.obs;

  /// Sorting
  RxString sortColumn = ''.obs;
  RxBool sortAscending = true.obs;

  /// Indicates if the filter panel is open (for web)
  RxBool isFilterOpen = false.obs;

  /// List of pages, each containing a list of Payment
  List<List<Payment>> listPages = [];

  /// Options for filtering
  final List<String> optionsFilters = [
    'Fecha de pago',
    'Número de pago',
    'Número de siniestro',
  ];

  /// Get total local pages available
  int get totalLocalPages => listPages.length;

  /// Check if can go to previous page
  bool get canGoPrevious => currentPage.value > 1;

  /// Check if can go to next page
  bool get canGoNext =>
      currentPage.value < listPages.length || !(state?.isLastPage ?? false);

  final int pagToRequest = 10;

  @override
  Future<void> onInit() async {
    super.onInit();

    change(const PaymentsModel(), status: RxStatus.loading());

    /// Listen to scroll events for pagination
    scrollCtrlerMobile.addListener(_onScroll);
    await _fetchPayments();
  }

  Future<void> _fetchPayments() => appService.threads.execute(
    customExceptionMessages: {
      Exception(): ExceptionAlertProperties(
        message: msg.errorToGetPayments.tr(),
      ),
    },
    func: () async {
      final String filtros = _buildFilters();
      final Response<PaymentsDto> hasData = await _repository.fetchPayments(
        // rfc: 'AEX010101A01',
        rfc: appState.user.rfc,
        jwt: appState.user.token.jwt,
        filtros: filtros,
      );

      final PaymentsDto dataDTO = hasData.body!;
      if (dataDTO.data.isEmpty) {
        change(state, status: RxStatus.empty());
        return;
      }

      final List<Payment> newPayments = dataDTO.data
          .map(
            (e) => Payment(
              numeroPago: e.numeroPago.value(),
              fechaPago: e.fechaPago,
              siniestroAsociado: e.siniestroAsociado.value(),
              desEstadoPago: e.desEstadoPago.value(),
              montoReclamado: e.montoReclamado.value(),
              montoPagado: e.montoPagado.value(),
              numeroCuentaPago: e.numeroCuentaPago.value(),
              institucionBancaria: e.institucionBancaria.value(),
              metodoPago: null,
            ),
          )
          .toList();

      /// Dividir en páginas locales de 10 items
      _splitPages(newPayments);
      updatePaymentsFromCurrentPage();

      change(
        PaymentsModel.empty().copyWith(
          nextPageToken: dataDTO.nextPageToken,
          isLastPage: dataDTO.nextPageToken?.isEmpty,
          totalItems: dataDTO.totalItems,
          totalPages: dataDTO.totalPages,
          pageSize: dataDTO.pageSize,
        ),
        status: RxStatus.success(),
      );
    },
    onError: () {
      change(state, status: RxStatus.empty());
      AppService.i.alert.show(
        type: AlertType.error,
        title: msg.error.tr(),
        message: msg.errorToGetPayments.tr(),
      );
    },
  );

  /// Listen to scroll events for pagination
  Future<void> _onScroll() async {
    if (scrollCtrlerMobile.position.pixels ==
        scrollCtrlerMobile.position.maxScrollExtent) {
      await goToNextPage();
    }
  }

  Future<void> loadNextPage({required bool isWeb}) async {
    /// Si es la última página, no hacer nada
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
    await _fetchPayments();
    isFetchingMore.value = false;
  }

  /// Divide items into pages of 10 (WEB only)
  void _splitPages(List<Payment> newItems) {
    for (int i = 0; i < newItems.length; i += pagToRequest) {
      final int end = (i + pagToRequest < newItems.length)
          ? i + pagToRequest
          : newItems.length;
      listPages.add(newItems.sublist(i, end));
    }
  }

  /// Update payments with items from current page (WEB only)
  void updatePaymentsFromCurrentPage() {
    if (listPages.isEmpty) {
      payments.clear();
      return;
    }

    if (isWebView) {
      final int pageIndex = currentPage.value - 1;
      if (pageIndex >= 0 && pageIndex < listPages.length) {
        payments.value = List.from(listPages[pageIndex]);
      }
    } else {
      payments.value = listPages.expand((e) => e).toList();
    }
  }

  /// Navigate to next page (WEB only)
  Future<void> goToNextPage() async {
    final int nextPage = currentPage.value + 1;

    /// Check if the next page already exists in local storage
    if (nextPage <= listPages.length) {
      /// Page exists locally, just navigate
      currentPage.value = nextPage;
      updatePaymentsFromCurrentPage();
      return;
    }

    /// The next page doesn't exist locally, check if we can fetch from server
    if (!(state?.isLastPage ?? false)) {
      /// There's more data on the server, fetch it
      await loadNextPage(isWeb: true);
      if (listPages.length >= nextPage) {
        /// Successfully fetched, navigate to the new page
        currentPage.value = nextPage;
        updatePaymentsFromCurrentPage();
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
      updatePaymentsFromCurrentPage();
    }
  }

  /// Build filters string for API call
  String _buildFilters() {
    final String pageToken = state?.nextPageToken ?? '';

    if (paymentDate.isEmpty &&
        paymentNumber.isEmpty &&
        claimNumber.isEmpty &&
        pageToken.isEmpty) {
      return '';
    }

    final StringBuffer filters = StringBuffer('?');
    if (paymentDate.isNotEmpty) {
      filters.write('fechaInicio=$fechaAperturaIni&fechaFin=$fechaAperturaFin');
    }
    if (paymentNumber.isNotEmpty) {
      filters.write(
        '${filters.length > 1 ? '&' : ''}numeroPago=$paymentNumber',
      );
    }
    if (claimNumber.isNotEmpty) {
      filters.write(
        '${filters.length > 1 ? '&' : ''}numeroSiniestro=$claimNumber',
      );
    }

    /// Always add page size and page token
    filters.write(
      '''${pageToken.isNotEmpty ? '&nextPageToken=$pageToken' : ''}&pageSize=$pagToRequest''',
    );

    /// Add sorting parameters if active
    if (sortColumn.value.isNotEmpty) {
      filters.write(
        '''&sortBy=${sortColumn.value}&sortOrder=${sortAscending.value ? 'asc' : 'desc'}''',
      );
    }

    return filters.toString();
  }

  /// Set filters based on selected option
  void setFilters() {
    switch (appliedFilterOption.value) {
      case 'Fecha de pago':
        paymentDate = filterInputCtrler.text;
      case 'Número de pago':
        paymentNumber = filterInputCtrler.text;
      case 'Número de siniestro':
        claimNumber = filterInputCtrler.text;
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
    change(
      state!.copyWith(
        nextPageToken: '',
        isLastPage: false,
      ),
      status: RxStatus.loading(),
    );

    /// Apply the filter based on the selected option
    setFilters();

    /// Clear current payments and fetch again
    hasShownAlert = false;

    /// Reset local pagination (WEB)
    listPages.clear();
    currentPage.value = 1;
    payments.clear();

    await _fetchPayments();
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
        options: const [
          'Fecha de pago',
          'Número de pago',
          'Número de siniestro',
        ],
        onOptionSelected: (opt) async {
          isFilterApplied.value = opt.isNotEmpty;
          appliedFilterOption.value = opt;
          if (appliedFilterOption.value == 'Fecha de pago') {
            await showCalendar();
          }
        },
      ),
    );
  }

  /// Clear all applied filters
  void clearFilters() {
    paymentDate = '';
    paymentNumber = '';
    claimNumber = '';
    isFilterApplied.value = false;
    appliedFilterOption.value = '';
    filterInputCtrler.clear();

    /// Reset local pagination (WEB)
    listPages.clear();
    payments.clear();
    currentPage.value = 1;
  }

  void clearFiltersSort() {
    /// Reset local pagination (WEB)
    payments.clear();
    listPages.clear();
    currentPage.value = 1;
  }

  Future<void> showCalendar() async {
    if (appliedFilterOption.value != 'Fecha de pago') {
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
      clearFilters();
    }
  }

  /// Show filter dialog for web
  Future<void> showFilterDialogWeb() async {
    clearFilters();
    isFilterOpen.value = !isFilterOpen.value;
  }

  /// Sort payments by column
  Future<void> onSort(String column) async {
    clearFiltersSort();
    if (sortColumn.value == column) {
      sortAscending.value = !sortAscending.value;
    } else {
      sortColumn.value = column;
      sortAscending.value = true;
    }

    /// Reset all
    hasShownAlert = false;

    change(
      state!.copyWith(
        nextPageToken: '',
        isLastPage: false,
      ),
      status: RxStatus.loading(),
    );

    await _fetchPayments();
  }

  /// Sort payments list

  // Future<void> _sortByColumn(String column, {bool ascending = true}) async {
  //   payments
  //     ..sort((a, b) {
  //       int result;

  //       if (column == 'numeroPago') {
  //         result = a.numeroPago.compareTo(b.numeroPago);
  //       } else if (column == 'fechaPago') {
  //         final String fechaA = a.fechaPago.toString();
  //         final String fechaB = b.fechaPago.toString();
  //         result = fechaA.compareTo(fechaB);
  //       } else if (column == 'montoReclamado') {
  //         result = a.montoReclamado.compareTo(b.montoReclamado);
  //       } else if (column == 'montoPagado') {
  //         result = a.montoPagado.compareTo(b.montoPagado);
  //       } else if (column == 'siniestroAsociado') {
  //         result = a.siniestroAsociado.compareTo(b.siniestroAsociado);
  //       } else if (column == 'desEstadoPago') {
  //         result = a.desEstadoPago.compareTo(b.desEstadoPago);
  //       } else {
  //         result = 0;
  //       }

  //       return ascending ? result : -result;
  //     })
  //     ..refresh();
  // }

  @override
  void onClose() {
    scrollCtrlerMobile.dispose();
    filterInputCtrler.dispose();
    super.onClose();
  }
}
