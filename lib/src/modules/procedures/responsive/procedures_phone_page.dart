part of '../procedures_page.dart';

class _ProceduresPhonePage extends StatelessWidget {
  _ProceduresPhonePage();

  final ProceduresController _c = Get.find<ProceduresController>();

  @override
  Widget build(BuildContext context) {
    _c.viewType.value = AppLayout.mobile;
    _c.updateFoliosFromCurrentPage();
    return Scaffold(
      appBar: AppBarPhoneWdgt(
        title: msg.myProcedures.tr(),
        name: _c.user.nombreCompleto,
        lastname: _c.user.apePaterno,
        rfc: _c.user.rfc,
        jwt: _c.user.token.jwt,
        medicalIdentifier: _c.user.codigoFiliacion,
        onBack: () async {
          await Get.offAllNamed(WelcomePage.page.name);
        },
      ),
      body: _c.obx(
        (state) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Search bar
              CustomSearchBar(
                onFilterPressed: _c.showFilterDialog,
                controller: _c.filterInputCtrler,
                onSearchPressed: _c.checkFilters,
              ),
        
              /// Chips de filtros aplicados
              Obx(
                () => _c.isFilterApplied.value
                    ? chipFiltered()
                    : const SizedBox.shrink(),
              ),
        
              /// Procedures list
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    padding: const EdgeInsets.only(bottom: 48),
                    controller: _c.scrollCtlerMobile,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount:
                        _c.folios.length +
                        (_c.isFetchingMore.value ? 1 : 0),
                    itemBuilder: (context, i) {
                      if (i == _c.folios.length &&
                          !(state?.isLastPage ?? false)) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: LoadingGnp(),
                          ),
                        );
                      }
                      return FolioItemWdgt(data: _c.folios[i]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        onLoading: const Center(child: LoadingGnp()),
        onEmpty: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Search bar
              CustomSearchBar(
                onFilterPressed: _c.showFilterDialog,
                controller: _c.filterInputCtrler,
                onSearchPressed: _c.checkFilters,
              ),

              /// Filters Chips applied
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
                  height: context.pHeight(30),
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
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: InkWell(
      onTap: _c.showCalendar,
      child: FilterChipTag(
        label: _c.appliedFilterOption.value,
        onRemove: _c.clearFilters,
      ),
    ),
  );
}
