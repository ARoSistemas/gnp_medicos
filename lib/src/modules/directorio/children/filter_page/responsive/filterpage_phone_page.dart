part of '../filterpage_page.dart';

class _FilterPagePhonePage extends StatelessWidget {
  _FilterPagePhonePage();

  final FilterPageController _c = Get.find<FilterPageController>();

  @override
  Widget build(BuildContext context) {
    void onBack() {
      Get.back(
        result: {
          'catEspecialidades': _c.catEspecialidades,
          'catCirculos': _c.catCirculos,
          'catPlanHospitalario': _c.catPlanHospitalario,
          'catClinicas': _c.catClinicas,
          'catOtrosServicios': _c.catOtrosServicios,
        },
      );
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          onBack();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(_c.itemSelected.subtitle),
          leading: BackButton(onPressed: onBack),
        ),
        body: _c.obx(
          (state) => SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SingleChildScrollView(
                child: Column(
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
                    ),

                    /// Dropdown Circulo
                    if (_c.state!.itemSelected == 'medicos')
                      Obx(
                        () => DropdownSearchField(
                          title: 'Circulo o tabulador médico',
                          hintText: _c.circuloSelected['circuloMedico'],
                          items: _c.catCirculos,
                          labelKey: 'circuloMedico',
                          onChanged: (value) {
                            _c.circuloSelected.value =
                                value ??
                                {
                                  'claveCirculoMedico': '0',
                                  'circuloMedico': 'Todos',
                                };
                          },
                        ),
                      ),

                    /// Dropdown Especiality
                    if (_c.state!.itemSelected == 'medicos')
                      Obx(
                        () => DropdownSearchField(
                          title: 'Especialidad',
                          hintText: _c.especialidadSelected['especialidad'],
                          items: _c.catEspecialidades,
                          labelKey: 'especialidad',
                          onChanged: (value) {
                            _c.especialidadSelected.value =
                                value ??
                                {
                                  'claveEspecialidad': '0',
                                  'especialidad': 'Todos',
                                };
                          },
                        ),
                      ),

                    /// Dropdown Plan hospitalario
                    if (_c.state!.itemSelected == 'hospitales')
                      Obx(
                        () => DropdownSearchField(
                          title: 'Plan hospitalario',
                          hintText: _c.planHospitalarioSelected['plan'],
                          items: _c.catPlanHospitalario,
                          labelKey: 'plan',
                          onChanged: (value) {
                            _c.planHospitalarioSelected.value =
                                value ?? {'clavePlan': '0', 'plan': 'Todos'};
                          },
                        ),
                      ),

                    /// Dropdown Clinicas
                    if (_c.state!.itemSelected == 'clinicas')
                      Obx(
                        () => DropdownSearchField(
                          title: 'Tipo de clínica',
                          hintText: _c.clinicasSelected['tipoClinica'],
                          items: _c.catClinicas,
                          labelKey: 'tipoClinica',
                          onChanged: (value) {
                            _c.clinicasSelected.value =
                                value ??
                                {
                                  'claveTipoClinica': '0',
                                  'tipoClinica': 'Todos',
                                };
                          },
                        ),
                      ),

                    /// Dropdown Otros Servicios
                    if (_c.state!.itemSelected == 'otros_servicios')
                      Obx(
                        () => DropdownSearchField(
                          title: 'Tipo Servicios',
                          hintText: _c.otrosServiciosSelected['tipoProveedor'],
                          items: _c.catOtrosServicios,
                          labelKey: 'tipoProveedor',
                          onChanged: (value) {
                            _c.otrosServiciosSelected.value =
                                value ??
                                {
                                  'claveTipoProveedor': '0',
                                  'tipoProveedor': 'Todos',
                                };
                          },
                        ),
                      ),

                    /// Dropdown Estados
                    Obx(
                      () => DropdownSearchField(
                        title: 'Estado',
                        hintText: _c.itemSelectedEstado['estado'],
                        items: _c.catEstados,
                        labelKey: 'estado',
                        onChanged: (value) async {
                          _c.itemSelectedEstado.value =
                              value ??
                              {
                                'claveEstado': '0',
                                'estado': 'Todos',
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
                              title: 'Municipio',
                              hintText:
                                  _c.municipiosSelected['municipio'] ?? '',
                              items: _c.catMunicipios,
                              labelKey: 'municipio',
                              onChanged: (value) {
                                _c.municipiosSelected.value =
                                    value ??
                                    {
                                      'claveMunicipio': '0',
                                      'municipio': 'Todos',
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
                                'Para mostrar municipios, seleccione un estado',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
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
              title: esMessages.mx.noInformationToShow.value,
              subtitle: '',
            ),
          ),
          onError: (_) => Center(
            child: LoadingGnp(
              icon: const Icon(
                Icons.error,
                size: 70,
                color: ColorPalette.primary,
              ),
              title: esMessages.mx.errorLoadingInfo.value,
              subtitle: esMessages.mx.pleaseTryAgainLater.value,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _c.obx(
            (state) => ElevatedButton(
              onPressed: _c.goToFilterResultsPage,
              child: const Text('Buscar'),
            ),
            onLoading: const SizedBox(),
            onError: (_) => const SizedBox(),
            onEmpty: const SizedBox(),
          ),
        ),
      ),
    );
  }

  Widget _buildSearch({double height = 350}) {
    /// Action on tap search item
    Future<void> onTapSearch(Map<String, dynamic> item) async {
      /// Unfocus input search
      _c.fnInputSearch.unfocus();

      /// Set value to search input
      _c.searchCtrler.text = item[_c.keyToSearch.value] ?? '';

      /// If the filter is for doctors
      if (_c.state!.itemSelected == 'medicos') {
        _c.especialidadSelected.value = item;
      }

      /// If the filter is for hospitals
      if (_c.state!.itemSelected == 'hospitales') {
        _c.planHospitalarioSelected.value = item;
      }

      /// If the filter is for clinics
      if (_c.state!.itemSelected == 'clinicas') {
        _c.clinicasSelected.value = item;
      }

      /// If the filter is for other services
      if (_c.state!.itemSelected == 'otros_servicios') {
        _c.otrosServiciosSelected.value = item;
      }

      /// Navigate to the results page
      await _c.goToFilterResultsPage();
    }

    return Obx(
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
                      onTap: () => onTapSearch(item),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
