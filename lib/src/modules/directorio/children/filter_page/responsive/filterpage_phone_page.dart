part of '../filterpage_page.dart';

class _FilterPagePhonePage extends StatelessWidget {
  _FilterPagePhonePage();

  final FilterPageController _c = Get.find<FilterPageController>();

  // backgroundColor: Get.theme.colorScheme.primary,
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(backgroundColor: Colors.white, title: Text(_c.state!.name)),
    body: _c.obx(
      (state) => SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              spacing: 25,
              children: [
                /// Buscador segun sea el caso
                if (_c.state!.itemSelected != 'modulos_gnp') _buildSearch(),

                /// Input nombre médico
                if (_c.state!.itemSelected == 'medicos')
                  TextFieldWithBorderInBottom(
                    title: 'MÉDICO',
                    label: 'Nombre (Opcional)',
                    colorBorde: const Color(0xFFB0BEC5),
                    controller: _c.medicoCtrler,
                  ),

                /// Dropdown Circulo
                if (_c.state!.itemSelected == 'medicos')
                  Obx(
                    () => DropdownSearchField(
                      title: 'Circulo o tabulador médico',
                      hintText: _c.itemSelectedCirculos['circuloMedico'],
                      items: _c.itemsCirculos,
                      labelKey: 'circuloMedico',
                      onChanged: (value) {
                        _c.itemSelectedCirculos.value =
                            value ??
                            {
                              'claveCirculoMedico': '0',
                              'circuloMedico': 'Todos',
                            };
                      },
                    ),
                  ),

                /// Dropdown especialidad
                if (_c.state!.itemSelected == 'medicos')
                  Obx(
                    () => DropdownSearchField(
                      title: 'Especialidad',
                      hintText: _c.itemSelectedEspecialidades['especialidad'],
                      items: _c.itemsEspecialidades,
                      labelKey: 'especialidad',
                      onChanged: (value) {
                        _c.itemSelectedEspecialidades.value =
                            value ??
                            {'claveEspecialidad': '0', 'especialidad': 'Todos'};
                      },
                    ),
                  ),

                /// Dropdown Plan hospitalario
                if (_c.state!.itemSelected == 'hospitales')
                  Obx(
                    () => DropdownSearchField(
                      title: 'Plan hospitalario',
                      hintText: _c.itemSelectedPlanHospitalario['plan'],
                      items: _c.itemsPlanHospitalario,
                      labelKey: 'plan',
                      onChanged: (value) {
                        _c.itemSelectedPlanHospitalario.value =
                            value ?? {'clavePlan': '0', 'plan': 'Todos'};
                      },
                    ),
                  ),

                /// Dropdown Clinicas
                if (_c.state!.itemSelected == 'clinicas')
                  Obx(
                    () => DropdownSearchField(
                      title: 'Tipo de clínica',
                      hintText: _c.itemSelectedClinicas['tipoClinica'],
                      items: _c.itemsClinicas,
                      labelKey: 'tipoClinica',
                      onChanged: (value) {
                        _c.itemSelectedClinicas.value =
                            value ??
                            {'claveTipoClinica': '0', 'tipoClinica': 'Todos'};
                      },
                    ),
                  ),

                /// Dropdown Otros Servicios
                if (_c.state!.itemSelected == 'otros_servicios')
                  Obx(
                    () => DropdownSearchField(
                      title: 'Tipo Servicios',
                      hintText: _c.itemSelectedOtrosServicios['tipoProveedor'],
                      items: _c.itemsOtrosServicios,
                      labelKey: 'tipoProveedor',
                      onChanged: (value) {
                        _c.itemSelectedOtrosServicios.value =
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
                    hintText: _c.itemSelectedEstados['estado'],
                    items: _c.itemsEstados,
                    labelKey: 'estado',
                    onChanged: (value) {
                      _c.itemSelectedEstados.value =
                          value ??
                          {
                            'claveEstado': '0',
                            'estado': 'Todos',
                          };
                    },
                  ),
                ),

                /// Dropdown Municipios
                if (_c.state!.itemSelected != 'modulos_gnp')
                  Obx(
                    () => DropdownSearchField(
                      title: 'Municipio',
                      hintText: _c.itemSelectedMunicipios['municipio'],
                      items: _c.itemsMunicipios,
                      labelKey: 'municipio',
                      onChanged: (value) {
                        _c.itemSelectedMunicipios.value =
                            value ??
                            {
                              'claveMunicipio': '0',
                              'municipio': 'Todos',
                            };
                      },
                    ),
                  ),

                /// Datos del asegurado
                if (_c.state!.itemSelected == 'medicos' ||
                    _c.state!.itemSelected == 'hospitales') ...[
                  TextFieldWithBorderInBottom(
                    title: 'DATOS DEL ASEGURADO (OPCIONAL)',
                    label: 'Nombre o Póliza del asegurado',
                    colorBorde: const Color(0xFFB0BEC5),
                    controller: _c.aseguradoCtrler,
                  ),
                  const SizedBox(height: 150),
                ],
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
  );

  Widget _buildSearch() => Obx(
    () => Column(
      children: [
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
              hintText: _c.hintTextSearch.value,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 14,
              ),
            ),
            onChanged: (value) {
              if (_c.searchCtrler.text.isEmpty) {
                _c.resetSearch();
              }
            },
          ),
        ),
        if (_c.showSearchDropdown.value)
          Material(
            elevation: 4,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(6),
              bottomRight: Radius.circular(6),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 350),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _c.listFiltered.length,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> item = _c.listFiltered[index];
                  return ListTile(
                    title: Text(item[_c.keyToSearch.value]),
                    onTap: () async {
                      _c.fnInputSearch.unfocus();
                      _c.searchCtrler.text = item[_c.keyToSearch.value] ?? '';
                      _c.itemSearch = item;
                      await _c.goToFilterResultsPage();
                      // _c.hintTextSearch.value =
                      //     item[_c.keyToSearch.value] ?? 'Todos';
                    },
                  );
                },
              ),
            ),
          ),
      ],
    ),
  );
}

/// Llama a showSearch para abrir la interfaz de búsqueda.

// Future<void> _showSearchDialog() async {
//   await showSearch<String>(
//     context: context,
//     delegate: DirectorySearchDelegate(_c),
//   );
// }

/// SearchDelegate personalizado para buscar en el directorio.
///
/// Muestra sugerencias mientras el usuario escribe y presenta los resultados
// /// finales. Devuelve el `String` del título del elemento seleccionado.
// class DirectorySearchDelegate extends SearchDelegate<String> {
//   DirectorySearchDelegate(this.ctrler);

//   final SearchDirectoryController ctrler;

//   // --- Métodos Requeridos ---

//   /// Define las acciones para la AppBar de búsqueda
//   /// (ej. un botón para limpiar).
//   @override
//   List<Widget>? buildActions(BuildContext context) => [
//     if (query.isNotEmpty)
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//           showSuggestions(context);
//         },
//       ),
//   ];

//   /// Define el widget principal al inicio de la AppBar
//   /// (ej. un botón para volver).
//   @override
//   Widget? buildLeading(BuildContext context) => IconButton(
//     icon: const Icon(Icons.arrow_back),
//     onPressed: () {
//       // Verifica si el teclado está visible y lo oculta antes de regresar.
//       final FocusScopeNode currentFocus = FocusScope.of(context);
//       if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
//         FocusManager.instance.primaryFocus?.unfocus();
//       }
//       // Cierra la búsqueda sin devolver un resultado.
//       close(context, '');
//       Get.back();
//     },
//   );

//   /// Construye los resultados que se muestran después de que el
//   /// usuario envía la búsqueda.
//   @override
//   Widget buildResults(BuildContext context) {
//     // Aquí puedes filtrar los datos del controlador.
//     final List<String> results = ctrler.items
//         .where((item) => item.toLowerCase().contains(query.toLowerCase()))
//         .toList();

//     return Center(
//       child: Text(
//         '''Resultados para: "$query" ${results.isEmpty ?
//"(ninguno encontrado)" : ""}''',
//         style: Get.textTheme.headlineSmall,
//       ),
//     );
//   }

//   /// Construye las sugerencias que se muestran mientras el usuario escribe.
//   // @override
//   // Widget buildSuggestions(BuildContext context) {
//   //   // Para este ejemplo, mostramos sugerencias genéricas.
//   //   // Aquí deberías filtrar los datos reales de tu controlador.
//   //   final List<String> suggestions = List.generate(
//   //     1,
//   //     (i) => 'Sugerencia ${i + 1} para "$query"',
//   //   );

//   //   return ListView.builder(
//   //     itemCount: suggestions.length,
//   //     itemBuilder: (context, index) {
//   //       final String suggestion = suggestions[index];
//   //       return ListTile(
//   //         title: Text(suggestion),
//   //         onTap: () {
//   //           query = suggestion;
//   //           showResults(context);
//   //         },
//   //       );
//   //     },
//   //   );
//   // }

//   @override
//   Widget buildSuggestions(BuildContext context) => ListTile(
//     title: Text('Sugerencia para ${ctrler.state!.name}'),
//     onTap: () {
//       // query = suggestion;
//       showResults(context);
//     },
//   );

//   @override
//   String get searchFieldLabel => 'Buscar en directorio...';
// }
