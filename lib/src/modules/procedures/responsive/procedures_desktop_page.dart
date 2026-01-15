part of '../procedures_page.dart';

class _ProceduresDesktopPage extends StatelessWidget {
  _ProceduresDesktopPage();

  final ProceduresController _c = Get.find<ProceduresController>();

  // Define los headers de la tabla
  List<TableHeader> get _tableHeaders => [
    TableHeader(
      title: msg.folio.tr(),
      columnKey: 'folio',
      flex: 3,
      sortable: false
    ),
    TableHeader(
      title: msg.insuredName.tr(),
      columnKey: 'nombreAsegurado',
      flex: 6,
      sortable: false
    ),
    TableHeader(
      title: msg.condition.tr(),
      columnKey: 'padecimientoIcd',
      flex: 3,
      sortable: false
    ),
    TableHeader(
      title: msg.policy.tr(),
      columnKey: 'numPoliza',
    ),
    TableHeader(
      title: msg.attendingHospital.tr(),
      columnKey: 'hospitalAtencion',
      flex: 3,
    ),
    TableHeader(
      title: msg.status.tr(),
      columnKey: 'dictaminado',
    ),
    TableHeader(
      title: msg.dateOfLoss.tr(),
      columnKey: 'fechaApertura',
    ),
  ];

  // Convierte la lista de FolioSiniestro en filas de widgets
  List<List<Widget>> _buildRows(List<FolioSiniestro> folios) => folios
      .map(
        (folio) => [
          Text(
            folio.idTramite,
            style: const TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            folio.nombreAsegurado,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            folio.padecimiento,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            folio.poliza,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            folio.hospitalAtencion,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            folio.estatus,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            folio.fechaSiniestro,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      )
      .toList();

  Widget _buildProceduresTable() => Obx(
    () => TableWeb(
      minWidth: 1350,
      headers: _tableHeaders,
      rows: _buildRows(_c.folios),
      isFetchingMore: _c.isFetchingMore.value,
      showPagination: true,
      currentPage: _c.currentPage.value,
      totalPages: _c.state?.totalPages ?? 1,
      onNextPage: () {
        unawaited(_c.goToNextPage());
      },
      onPreviousPage: _c.goToPreviousPage,
      onSort: _c.onSort,
      sortColumn: _c.sortColumn.value,
      isAscending: _c.sortAscending.value,
    ),
  );

  @override
  Widget build(BuildContext context) {
    _c.viewType.value = AppLayout.desktop;
    _c.updateFoliosFromCurrentPage();
    return Scaffold(
    appBar: AppBarWeb(title: msg.myProcedures.tr()),
    body: _c.obx(
      (state) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Search bar
            CustomSearchBar(
              isWeb: kIsWeb,
              controller: _c.filterInputCtrler,
              onFilterPressed: _c.showFilterDialogWeb,
              onSearchPressed: _c.checkFilters,
            ),
  
            ///  List of procedures
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
  
                      /// Table with pagination
                      Expanded(
                        child: _buildProceduresTable(),
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
                            if (opt == 'Fecha del trámite') {
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
      onLoading: const Center(child: LoadingGnp()),
      onEmpty: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Search bar
            CustomSearchBar(
              isWeb: true,
              controller: _c.filterInputCtrler,
              onFilterPressed: _c.showFilterDialogWeb,
              onSearchPressed: _c.checkFilters,
            ),
  
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
  
                      /// Title
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 16,
                        ),
                        child: Text(
                          msg.notProcedures.tr(),
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
                          _c.isFilterApplied.value = opt.isNotEmpty;
                          _c.appliedFilterOption.value = opt;
                          _c.isFilterOpen.value = false;
                          if (opt == 'Fecha del trámite') {
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
