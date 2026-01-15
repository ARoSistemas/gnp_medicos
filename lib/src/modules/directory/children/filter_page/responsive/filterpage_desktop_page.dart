part of '../filterpage_page.dart';

class _FilterPageDesktopPage extends StatelessWidget {
  _FilterPageDesktopPage();

  final FilterPageController _c = Get.find<FilterPageController>();

  @override
  Widget build(BuildContext context) {
    /// DirectoryController (if exists)
    final DirectoryController? dirController =
        Get.isRegistered<DirectoryController>()
        ? Get.find<DirectoryController>()
        : null;

    PreferredSizeWidget? appBar;

    /// Build reactive appBar for tablet
    if (_c.isWeb && dirController != null) {
      appBar = PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(() {
          final bool isTablet = dirController.isTablet.value;
          final bool showBackButton =
              isTablet && !dirController.showMenuTablet.value;

          if (showBackButton) {
            return AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: dirController.goBackToMenu,
              ),
              title: Text(msg.back.tr()),
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
            );
          }
          return const SizedBox.shrink();
        }),
      );
    } else if (!_c.isWeb) {
      appBar = AppBar(
        leading: const SizedBox.shrink(),
        title: Text(_c.itemSelected.subtitle),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      );
    }

    return Scaffold(
      appBar: appBar,
      body: _c.obx(
        (state) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 25,
            children: [
              /// Input search on List
              if (_c.state!.itemSelected == 'medicos')
                _buildSearch(height: context.pHeight(41)),

              /// Input to search general
              TextFieldWithBorderInBottom(
                title: _c.titleSearchby,
                label: _c.labelSearchby,
                colorBorde: const Color(0xFFB0BEC5),
                controller: _c.searchByCtrler,
                isWeb: _c.isWeb,
                onSubmitted: () => unawaited(
                  _c.goToFilterResultsWebPage(isSearchByButton: false),
                ),
              ),

              /// Dropdown Circulo
              if (_c.state!.itemSelected == 'medicos')
                Obx(
                  () => DropdownSearchField(
                    title: msg.circleOrTab.tr(),
                    hintText: _c.circuloSelected['circuloMedico'],
                    items: _c.catCirculos,
                    labelKey: 'circuloMedico',
                    onChanged: (value) {
                      _c.circuloSelected.value =
                          value ??
                          {
                            'claveCirculoMedico': '0',
                            'circuloMedico': msg.all.tr(),
                          };
                    },
                  ),
                ),

              /// Dropdown Especialidad
              if (_c.state!.itemSelected == 'medicos')
                Obx(
                  () => DropdownSearchField(
                    title: msg.specialty.tr(),
                    hintText: _c.especialidadSelected['especialidad'],
                    items: _c.catEspecialidades,
                    labelKey: 'especialidad',
                    onChanged: (value) {
                      _c.especialidadSelected.value =
                          value ??
                          {
                            'claveEspecialidad': '0',
                            'especialidad': msg.all.tr(),
                          };
                    },
                  ),
                ),

              /// Dropdown Plan hospitalario
              if (_c.state!.itemSelected == 'hospitales')
                Obx(
                  () => DropdownSearchField(
                    title: msg.healthPlan.tr(),
                    hintText: _c.planHospitalarioSelected['plan'],
                    items: _c.catPlanHospitalario,
                    labelKey: 'plan',
                    onChanged: (value) {
                      _c.planHospitalarioSelected.value =
                          value ?? {'clavePlan': '0', 'plan': msg.all.tr()};
                    },
                  ),
                ),

              /// Dropdown Clinicas
              if (_c.state!.itemSelected == 'clinicas')
                Obx(
                  () => DropdownSearchField(
                    title: msg.clinicType.tr(),
                    hintText: _c.clinicasSelected['tipoClinica'],
                    items: _c.catClinicas,
                    labelKey: 'tipoClinica',
                    onChanged: (value) {
                      _c.clinicasSelected.value =
                          value ??
                          {
                            'claveTipoClinica': '0',
                            'tipoClinica': msg.all.tr(),
                          };
                    },
                  ),
                ),

              /// Dropdown Otros Servicios
              if (_c.state!.itemSelected == 'otros_servicios')
                Obx(
                  () => DropdownSearchField(
                    title: msg.servicesType.tr(),
                    hintText: _c.otrosServiciosSelected['tipoProveedor'],
                    items: _c.catOtrosServicios,
                    labelKey: 'tipoProveedor',
                    onChanged: (value) {
                      _c.otrosServiciosSelected.value =
                          value ??
                          {
                            'claveTipoProveedor': '0',
                            'tipoProveedor': msg.all.tr(),
                          };
                    },
                  ),
                ),

              /// Dropdown Estados
              Obx(
                () => DropdownSearchField(
                  title: msg.estado.tr(),
                  hintText: _c.itemSelectedEstado['estado'],
                  items: _c.catEstados,
                  labelKey: 'estado',
                  onChanged: (value) async {
                    _c.itemSelectedEstado.value =
                        value ??
                        {
                          'claveEstado': '0',
                          'estado': msg.all.tr(),
                        };
                    _c.catMunicipios.clear();
                    if (_c.itemSelectedEstado['claveEstado'] == '0') {
                      _c.municipiosSelected.value = {};
                      return;
                    }
                    await _c.fetchDataMunicipios();
                  },
                ),
              ),

              /// Dropdown Municipios
              Obx(
                () =>
                    (_c.state!.itemSelected != 'modulos_gnp' &&
                        _c.municipiosSelected.isEmpty)
                    ? const SizedBox()
                    : DropdownSearchField(
                        title: msg.municipality.tr(),
                        hintText: _c.municipiosSelected['municipio'] ?? '',
                        items: _c.catMunicipios,
                        labelKey: 'municipio',
                        onChanged: (value) {
                          _c.municipiosSelected.value =
                              value ??
                              {
                                'claveMunicipio': '0',
                                'municipio': msg.all.tr(),
                              };
                        },
                      ),
              ),
              Obx(
                () => _c.municipiosSelected.isNotEmpty
                    ? const SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          msg.selectMunicipalityAfterState.value,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
              ),

              /// Check Level Hospital Note
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  msg.toCheckLevelHospital.tr(),
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),

              /// Search Button
              ElevatedButton(
                style: Get.theme.elevatedButtonTheme.style?.copyWith(
                  minimumSize: WidgetStateProperty.all(const Size(0, 48)),
                ),
                onPressed: _c.goToFilterResultsWebPage,
                child: Text(msg.search.tr()),
              ),

              SizedBox(height: context.pHeight(10)),
            ],
          ),
        ),
        onLoading: const Center(child: LoadingGnp()),
        onEmpty: Center(
          child: LoadingGnp(
            icon: const Icon(
              Icons.warning,
              size: 70,
              color: ColorPalette.primary,
            ),
            title: msg.noInformationToShow.tr(),
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

  Widget _buildSearch({double height = 350}) => Obx(
    () => Column(
      children: [
        /// Input search
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFB0BEC5)),
            borderRadius: BorderRadius.circular(6),
          ),
          child: TextField(
            controller: _c.searchCtrler,
            focusNode: _c.fnInputSearch,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: _c.hintTextSearch,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
          ),
        ),

        /// Dropdown search results
        if (_c.showSearchDropdown.value)
          Material(
            elevation: 4,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(6),
              bottomRight: Radius.circular(6),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: height),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _c.listFiltered.length,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> item = _c.listFiltered[index];
                  return ListTile(
                    title: Text(item[_c.keyToSearch.value]),
                    onTap: () => _c.onTapSearch(item),
                  );
                },
              ),
            ),
          ),
      ],
    ),
  );
}
