// part of '../filter_results_page.dart';

// class _FilterResultsTabletPage extends StatelessWidget {
//   _FilterResultsTabletPage();

//   final FilterResultsController _c = Get.find<FilterResultsController>();

//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(
//       leading: const SizedBox.shrink(),
//       title: Text(_c.state?.name ?? msg.searchResults.tr()),
//       backgroundColor: Colors.white,
//       surfaceTintColor: Colors.white,
//     ),
//     body: _c.obx(
//       (state) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Divider(color: Colors.transparent),

//           /// header
//           Obx(
//             () => Text(
//               msg.resultsFoundPage.tr(
//                 args: [
//                   _c.totalResults.toString(),
//                   _c.currentPage.value.toString(),
//                   _c.nTotalPages.toString(),
//                 ],
//               ),
//             ),
//           ),

//           /// Chips de filtros
//           Wrap(
//             spacing: 10,
//             runSpacing: 1,
//             children: [
//               /// only show searchBy if not empty
//               if (_c.itemToSearch.value.searchBy.isNotEmpty)
//                 _ThisFilterChips(
//                   label: _c.itemToSearch.value.searchBy,
//                 ),

//               /// Filtros para medicos
//               if (_c.itemToSearch.value.itemSelected.idPage == 'medicos')
//                 /// Dropdown Circulo
//                 _ThisFilterChips(
//                   label:
//                       _c.itemToSearch.value.circuloMedico['circuloMedico'] ??
//                       msg.all.tr(),
//                 ),

//               /// Dropdown especialidad
//               if (_c.itemToSearch.value.itemSelected.idPage == 'medicos')
//                 _ThisFilterChips(
//                   label: _c.itemToSearch.value.especialidad['especialidad'],
//                 ),

//               /// Filtros para Plan hospitalario
//               if (_c.itemToSearch.value.itemSelected.idPage == 'hospitales')
//                 _ThisFilterChips(
//                   label:
//                       _c.itemToSearch.value.planHospitalario['plan'] ??
//                       msg.all.tr(),
//                 ),

//               /// Filtros para clinicas
//               if (_c.itemToSearch.value.itemSelected.idPage == 'clinicas')
//                 _ThisFilterChips(
//                   label:
//                       _c.itemToSearch.value.clinica['tipoClinica'] ??
//                       msg.all.tr(),
//                 ),

//               /// Filtros para otros servicios
//               if (_c.itemToSearch.value.itemSelected.idPage ==
//                   'otros_servicios')
//                 _ThisFilterChips(
//                   label:
//                       _c.itemToSearch.value.
//otrosServicios['tipoProveedor'] ??
//                       msg.all.tr(),
//                 ),

//               /// Estados (Es general para todos)
//               _ThisFilterChips(
//                 label: _c.itemToSearch.value.estado['estado'],
//               ),

//               /// Filtros para Municipios
//               if (_c.itemToSearch.value.
//itemSelected.idPage != 'modulos_gnp' &&
//                   _c.itemToSearch.value.municipio.isNotEmpty)
//                 _ThisFilterChips(
//                   label: _c.itemToSearch.value.municipio['municipio'],
//                 ),
//             ],
//           ),

//           /// Subtitle with the selected category
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: Text('${_c.state!.name}
// ${msg.selected.tr()}'.toUpperCase()),
//           ),

//           /// if there are results, show the list
//           if (_c.listToShow.isNotEmpty)
//             Expanded(
//               child: Scrollbar(
//                 controller: _c.scrollController,
//                 child: Obx(
//                   () => ListView.builder(
//                     controller: _c.scrollController,
//                     itemCount:
//                         _c.listToShow.length +
//                         (_c.isFetchingMore.value ? 1 : 0),
//                     itemBuilder: (context, i) {
//                       if (i == _c.listToShow.length) {
//                         return const Center(
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(vertical: 20),
//                             child: LoadingGnp(),
//                           ),
//                         );
//                       }

//                       final ItemResultsMdl item = _c.setItem(
//                         _c.itemToSearch.value.itemSelected.idPage,
//                         _c.listToShow[i],
//                       );

//                       return Padding(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 5,
//                         ),
//                         child: InkWell(
//                           onTap: () =>
//                               Get.find<DirectoryController>()
// .showItemOnMapWeb(
//                                 item,
//                                 _c.itemToSearch.value.itemSelected.subtitle,
//                               ),
//                           child: CardItemsResults(item: item, isWeb: true),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),

//           /// if there are no results, show a message
//           if (_c.listToShow.isEmpty)
//             Container(
//               height: context.pHeight(40),
//               width: context.pWidth(90),
//               alignment: Alignment.bottomCenter,
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 msg.noResultsWithFilters.tr(),
//                 style: Get.textTheme.bodyMedium?.copyWith(
//                   color: Colors.black54,
//                   fontSize: 20,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//         ],
//       ),
//       onLoading: const Center(child: LoadingGnp()),
//       onEmpty: Center(
//         child: LoadingGnp(
//           icon: const Icon(
//             Icons.warning,
//             size: 70,
//             color: ColorPalette.primary,
//           ),
//           title: msg.noResultsFound.tr(),
//           subtitle: '',
//         ),
//       ),
//       onError: (_) => Center(
//         child: LoadingGnp(
//           icon: const Icon(
//             Icons.error,
//             size: 70,
//             color: ColorPalette.primary,
//           ),
//           title: msg.errorLoadingInfo.tr(),
//           subtitle: msg.pleaseTryAgainLater.tr(),
//         ),
//       ),
//     ),
//   );
// }
