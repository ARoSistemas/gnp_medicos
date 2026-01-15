part of '../filter_results_page.dart';

class _FilterResultsDesktopPage extends StatelessWidget {
  _FilterResultsDesktopPage();

  final FilterResultsController _c = Get.find<FilterResultsController>();

  @override
  Widget build(BuildContext context) {
    /// DirectoryController (if exists)
    final DirectoryController? dirController =
        Get.isRegistered<DirectoryController>()
        ? Get.find<DirectoryController>()
        : null;

    return Scaffold(
      appBar: dirController != null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Obx(() {
                final bool isTablet = dirController.isTablet.value;
                return AppBar(
                  leading: isTablet
                      ? IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: dirController.goBackToFiltersTablet,
                        )
                      : const SizedBox.shrink(),
                  title: Text(
                    isTablet
                        ? msg.back.tr()
                        : (_c.state?.name ?? msg.searchResults.tr()),
                  ),
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.white,
                );
              }),
            )
          : AppBar(
              leading: const SizedBox.shrink(),
              title: Text(_c.state?.name ?? msg.searchResults.tr()),
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
            ),
      body: _c.obx(
        (state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// header
            Obx(
              () => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  msg.resultsFoundPage.tr(
                    args: [
                      _c.totalResults.toString(),
                      _c.currentPage.value.toString(),
                      _c.nTotalPages.toString(),
                    ],
                  ),
                ),
              ),
            ),

            /// Chips de filtros
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                /// only show searchBy if not empty
                if (_c.itemToSearch.value.searchBy.isNotEmpty)
                  _ThisFilterChips(
                    label: _c.itemToSearch.value.searchBy,
                  ),

                /// Filtros para medicos
                if (_c.itemToSearch.value.itemSelected.idPage == 'medicos')
                  /// Dropdown Circulo
                  _ThisFilterChips(
                    label:
                        _c.itemToSearch.value.circuloMedico['circuloMedico'] ??
                        msg.all.tr(),
                  ),

                /// Dropdown especialidad
                if (_c.itemToSearch.value.itemSelected.idPage == 'medicos')
                  _ThisFilterChips(
                    label: _c.itemToSearch.value.especialidad['especialidad'],
                  ),

                /// Filtros para Plan hospitalario
                if (_c.itemToSearch.value.itemSelected.idPage == 'hospitales')
                  _ThisFilterChips(
                    label:
                        _c.itemToSearch.value.planHospitalario['plan'] ??
                        msg.all.tr(),
                  ),

                /// Filtros para clinicas
                if (_c.itemToSearch.value.itemSelected.idPage == 'clinicas')
                  _ThisFilterChips(
                    label:
                        _c.itemToSearch.value.clinica['tipoClinica'] ??
                        msg.all.tr(),
                  ),

                /// Filtros para otros servicios
                if (_c.itemToSearch.value.itemSelected.idPage ==
                    'otros_servicios')
                  _ThisFilterChips(
                    label:
                        _c.itemToSearch.value.otrosServicios['tipoProveedor'] ??
                        msg.all.tr(),
                  ),

                /// Estados (Es general para todos)
                _ThisFilterChips(
                  label: _c.itemToSearch.value.estado['estado'],
                ),

                /// Filtros para Municipios
                if (_c.itemToSearch.value.itemSelected.idPage !=
                        'modulos_gnp' &&
                    _c.itemToSearch.value.municipio.isNotEmpty)
                  _ThisFilterChips(
                    label: _c.itemToSearch.value.municipio['municipio'],
                  ),
              ],
            ),
            const Divider(color: Colors.transparent),

            /// Button to clear filters
            TextButton.icon(
              onPressed: _c.goToFilterPage,
              icon: const Icon(Icons.delete),
              label: Text(msg.deleteSearchFilters.tr()),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),

            /// Subtitle with the selected category
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                '${_c.state?.name ?? ''} ${msg.selected.tr()}'.toUpperCase(),
              ),
            ),

            /// if there are results, show the list
            if (_c.listToShow.isNotEmpty)
              Expanded(
                child: Scrollbar(
                  controller: _c.scrollController,
                  child: Obx(
                    () => ListView.builder(
                      controller: _c.scrollController,
                      itemCount:
                          _c.listToShow.length +
                          (_c.isFetchingMore.value ? 1 : 0),
                      itemBuilder: (context, i) {
                        if (i == _c.listToShow.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: LoadingGnp(),
                            ),
                          );
                        }

                        final ItemResultsMdl item = _c.setItem(
                          _c.itemToSearch.value.itemSelected.idPage,
                          _c.listToShow[i],
                        );

                        return InkWell(
                          hoverColor: Colors.transparent,
                          onTap: () =>
                              Get.find<DirectoryController>().showItemOnMapWeb(
                                item,
                                _c.itemToSearch.value.itemSelected.subtitle,
                              ),
                          child: CardItemsResults(item: item),
                        );
                      },
                    ),
                  ),
                ),
              ),

            /// if there are no results, show a message
            if (_c.listToShow.isEmpty)
              Container(
                height: context.pHeight(40),
                width: context.pWidth(90),
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  msg.noResultsWithFilters.tr(),
                  style: Get.textTheme.bodyMedium?.copyWith(
                    color: Colors.black54,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
        onLoading: const Center(child: LoadingGnp()),
        onEmpty: Center(
          child: LoadingGnp(
            icon: const Icon(
              Icons.warning,
              size: 70,
              color: ColorPalette.primary,
            ),
            title: msg.noResultsFound.tr(),
            subtitle: '',
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
}
