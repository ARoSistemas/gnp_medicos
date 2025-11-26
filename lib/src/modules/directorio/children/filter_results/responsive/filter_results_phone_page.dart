part of '../filter_results_page.dart';

class _FilterResultsPhonePage extends StatelessWidget {
  _FilterResultsPhonePage();

  final FilterResultsController _c = Get.find<FilterResultsController>();

  @override
  Widget build(BuildContext context) {
    /// Set item results based on the selected page and current item
    ItemResultsMdl setItem(String idPage, dynamic currentItem) {
      ItemResultsMdl cardItemResults = ItemResultsMdl.empty();

      switch (_c.itemToSearch.value.itemSelected.idPage) {
        case 'medicos':
          final MedicoMdl tmp = currentItem;
          cardItemResults = ItemResultsMdl(
            title:
                '''${tmp.nombre} ${tmp.apellidoPaterno} ${tmp.apellidoMaterno}''',
            subtitle:
                '''${tmp.circuloMedico} - Tabulador médico: ${tmp.tabuladorNg}''',
            desc: tmp.direccionCompleta,
            tel: tmp.telefonoCompleto,
            lat: tmp.latitud,
            lng: tmp.longitud,
          );
        case 'hospitales':
          final HospitalMdl tmp = currentItem;
          cardItemResults = ItemResultsMdl(
            title: tmp.razonSocial,
            subtitle:
                '''${tmp.nivelHosptilarioViejoEsquema} - ${tmp.nivelHosptilarioNuevoEsquema} ${tmp.nivelHosptilarioNuevaGama}''',
            desc: tmp.direccionCompleta,
            tel: tmp.telefonoCompleto,
            lat: tmp.latitud,
            lng: tmp.longitud,
          );
        case 'clinicas':
          final ClinicaMdl tmp = currentItem;
          cardItemResults = ItemResultsMdl(
            title: tmp.nombreComercial,
            subtitle: tmp.nivelHospitalarioAbreviado,
            desc: tmp.direccionCompleta,
            tel: tmp.telefonoCompleto,
            lat: tmp.latitud,
            lng: tmp.longitud,
          );
        case 'otros_servicios':
          final SauxMdl tmp = currentItem;
          cardItemResults = ItemResultsMdl(
            title: tmp.nombreComercial,
            subtitle: tmp.tipoServicio,
            desc: tmp.direccionCompleta,
            tel: tmp.telefonoCompleto,
            lat: tmp.latitud,
            lng: tmp.longitud,
          );
        default:
          cardItemResults = ItemResultsMdl.empty();
      }

      return cardItemResults;
    }

    return Scaffold(
      appBar: AppBarPhoneWdgt(
        title: _c.state!.name,
        name: _c.user.nombreCompleto,
        medicalIdentifier: _c.user.codigoFiliacion,
      ),
      body: _c.obx(
        (state) => SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(color: Colors.transparent),

                /// header
                Text(
                  '''Se encontraron ${_c.totalResults} resultados Página ${_c.currentPage.value} de ${_c.nTotalPages} ''',
                ),

                /// Chips de filtros
                Wrap(
                  spacing: 10,
                  runSpacing: 1,
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
                            _c
                                .itemToSearch
                                .value
                                .circuloMedico['circuloMedico'] ??
                            'Todos',
                      ),

                    /// Dropdown especialidad
                    if (_c.itemToSearch.value.itemSelected.idPage == 'medicos')
                      _ThisFilterChips(
                        label:
                            _c.itemToSearch.value.especialidad['especialidad'],
                      ),

                    /// Filtros para Plan hospitalario
                    if (_c.itemToSearch.value.itemSelected.idPage ==
                        'hospitales')
                      _ThisFilterChips(
                        label:
                            _c.itemToSearch.value.planHospitalario['plan'] ??
                            'Todos',
                      ),

                    /// Filtros para clinicas
                    if (_c.itemToSearch.value.itemSelected.idPage == 'clinicas')
                      _ThisFilterChips(
                        label:
                            _c.itemToSearch.value.clinica['tipoClinica'] ??
                            'Todos',
                      ),

                    /// Filtros para otros servicios
                    if (_c.itemToSearch.value.itemSelected.idPage ==
                        'otros_servicios')
                      _ThisFilterChips(
                        label:
                            _c
                                .itemToSearch
                                .value
                                .otrosServicios['tipoProveedor'] ??
                            'Todos',
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

                /// Subtitle with the selected category
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('${_c.state!.name} seleccionado'.toUpperCase()),
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

                            final ItemResultsMdl item = setItem(
                              _c.itemToSearch.value.itemSelected.idPage,
                              _c.listToShow[i],
                            );

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                              ),
                              child: InkWell(
                                onTap: () async {
                                  await Get.toNamed(
                                    ItemMapPage.page.name,
                                    arguments: {
                                      'item': item,
                                      'titleAppBar': _c
                                          .itemToSearch
                                          .value
                                          .itemSelected
                                          .subtitle,
                                    },
                                  );
                                },
                                child: CardItemsResults(item: item),
                              ),
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
                      '''No se encontraron resultados con los filtros seleccionados.''',
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: Colors.black54,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
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
            title: msg.noResultsFound.value,
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
            title: msg.errorLoadingInfo.value,
            subtitle: msg.pleaseTryAgainLater.value,
          ),
        ),
      ),
    );
  }
}

class _ThisFilterChips extends StatelessWidget {
  const _ThisFilterChips({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Chip(
    label: Text(label),
    side: const BorderSide(
      color: Colors.transparent,
    ),
    backgroundColor: Get.theme.colorScheme.secondary.withValues(alpha: 0.15),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('label', label));
  }
}
