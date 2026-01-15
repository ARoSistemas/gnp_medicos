part of '../payments_page.dart';

class _PaymentsDesktopPage extends StatelessWidget {
  _PaymentsDesktopPage();

  final PaymentsController _c = Get.find<PaymentsController>();

  // Define los headers de la tabla
  List<TableHeader> get _tableHeaders => [
    TableHeader(
      title: msg.paymentNumber.tr(),
      columnKey: 'numeroPago',
      sortable: false,
    ),
    TableHeader(
      title: msg.paymentDate.tr(),
      columnKey: 'fechaPago',
    ),
    TableHeader(
      title: msg.amountClaimed.tr(),
      columnKey: 'montoReclamado',
      sortable: false,
    ),
    TableHeader(
      title: msg.amountPaid.tr(),
      columnKey: 'montoPagado',
      sortable: false,
    ),
    TableHeader(
      title: msg.associatedIncident.tr(),
      columnKey: 'siniestroAsociado',
      sortable: false,
    ),
    TableHeader(
      title: msg.paymentStatus.tr(),
      columnKey: 'desEstadoPago',
    ),
  ];

  // Convierte la lista de Payment en filas de widgets
  List<List<Widget>> _buildRows(List<Payment> payments) => payments
      .map(
        (payment) => [
          Text(
            payment.numeroPago,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            payment.fechaPago.toString(),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '\$${payment.montoReclamado.toStringAsFixed(2)} MXN',
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '\$${payment.montoPagado.toStringAsFixed(2)} MXN',
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            payment.siniestroAsociado,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            payment.desEstadoPago,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    _c.viewType.value = AppLayout.desktop;
    _c.updatePaymentsFromCurrentPage();
    return Scaffold(
      appBar: AppBarWeb(title: msg.myPayments.tr()),
      body: _c.obx(
        (state) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              /// Search bar
              CustomSearchBar(
                isWeb: true,
                controller: _c.filterInputCtrler,
                onFilterPressed: _c.showFilterDialogWeb,
                onSearchPressed: _c.checkFilters,
              ),

              /// Payments table
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Filter chips applied
                        Obx(
                          () => _c.isFilterApplied.value
                              ? chipFiltered()
                              : const SizedBox.shrink(),
                        ),

                        /// Payments table
                        Expanded(
                          child: Obx(
                            () => TableWeb(
                              headers: _tableHeaders,
                              rows: _buildRows(_c.payments),
                              isFetchingMore: _c.isFetchingMore.value,
                              showPagination: true,
                              currentPage: _c.currentPage.value,
                              pageSize: _c.state!.pageSize,
                              totalPages: _c.state!.totalPages,
                              onNextPage: () => unawaited(_c.goToNextPage()),
                              onPreviousPage: _c.goToPreviousPage,
                              onSort: _c.onSort,
                              sortColumn: _c.sortColumn.value,
                              isAscending: _c.sortAscending.value,
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// Filter panel for web
                    Obx(
                      () => Positioned(
                        top: 0,
                        left: 0,
                        child: FilterSelectorWeb(
                          options: _c.optionsFilters,
                          onSelected: (opt) async {
                            _c.isFilterApplied.value = opt.isNotEmpty;
                            _c.appliedFilterOption.value = opt;
                            _c.isFilterOpen.value = false;
                            if (opt == 'Fecha del pago') {
                              await _c.showCalendar();
                            }
                          },
                          onClear: () {
                            _c.clearFilters();
                            _c.isFilterOpen.value = false;
                          },
                          isOpen: _c.isFilterOpen.value,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onLoading: const Center(child: LoadingGnp()),
        onEmpty: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Search bar
              CustomSearchBar(
                isWeb: true,
                onFilterPressed: _c.showFilterDialogWeb,
                controller: _c.filterInputCtrler,
                onSearchPressed: _c.checkFilters,
              ),

              /// Empty state
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Chips de filtros aplicados
                        Obx(
                          () => _c.isFilterApplied.value
                              ? chipFiltered()
                              : const SizedBox.shrink(),
                        ),

                        /// Title
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 16,
                          ),
                          child: Text(
                            msg.notPayments.tr(),
                            textAlign: TextAlign.start,
                            style: Get.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: ColorPalette.textPrimary,
                            ),
                          ),
                        ),

                        /// Image for empty state
                        Center(
                          child: SizedBox(
                            height: context.pHeight(40),
                            width: context.pWidth(80),
                            child: ImageFromWeb(
                              imageName: 'imagen_tramites_sin_resultados.png',
                              jwt: _c.jwt,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// Filter panel for web
                    Obx(
                      () => Positioned(
                        top: 0,
                        left: 0,
                        child: FilterSelectorWeb(
                          options: _c.optionsFilters,
                          onSelected: (opt) async {
                            if (opt.isNotEmpty) {
                              _c.isFilterApplied.value = opt.isNotEmpty;
                              _c.appliedFilterOption.value = opt;
                              _c.isFilterOpen.value = !_c.isFilterOpen.value;
                              if (opt == 'Fecha de pago') {
                                await _c.showCalendar();
                              }
                            }
                          },
                          onClear: () {
                            _c.clearFilters();
                            _c.isFilterOpen.value = false;
                          },
                          isOpen: _c.isFilterOpen.value,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        onError: (_) => Center(
          child: LoadingGnp(
            isError: true,
            title: msg.errorLoadingInfo.tr(),
            subtitle: msg.pleaseTryAgainLater.tr(),
          ),
        ),
      ),
    );
  }

  /// Filter chip widget
  Widget chipFiltered() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: InkWell(
      onTap: _c.showCalendar,
      child: FilterChipTag(
        label: _c.appliedFilterOption.value,
        onRemove: _c.clearFilters,
      ),
    ),
  );
}
