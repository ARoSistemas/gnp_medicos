import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/domain/entities/models/items_results_mdl.dart';
import 'package:medicos/src/modules/directorio/domain/entities/filter_directory_mdl.dart';

part 'filter_results_model.dart';

class FilterResultsController extends GetxController
    with StateMixin<_FilterResultsModel>, WidgetsBindingObserver {
  final AppStateController appState = Get.find<AppStateController>();

  Rx<ItemToSearchDirectoryMdl> itemToSearch =
      ItemToSearchDirectoryMdl.empty().obs;

  final List<ItemsResultsMdl> items = [
    ItemsResultsMdl(
      title: 'SASS MEXICO POTOSI 100 UAT',
      subtitle: 'Nivel 100 - Premium - Nivel A',
      desc:
          '''CERRO DE LAS TORRES 395, CAMPESTRE CHURUBUSCO, 04200, COYOACAN, CIUDAD DE MEXICO''',
      gps: '19.313998,-99.150635',
    ),

    ItemsResultsMdl(
      title: 'CEMAIN',
      subtitle: 'Nivel 100 - Flexible Indigo - Nivel C ',
      desc:
          '''CERRO DE LAS TORRES 395, ALTAVISTA, 89240, TAMPICO, TAMAULIPAS''',
      gps: '22.231123,-97.861005',
    ),

    ItemsResultsMdl(
      title: 'HOSPITAL ANGELES DEL PEDREGAL',
      subtitle: 'Nivel 100 - Premium - Nivel A',
      desc:
          '''CERRO DE LAS TORRES 395, HEROES DE PADIERNA, 10700, LA MAGDALENA CONTRERAS, DISTRITO FEDERAL''',
      gps: '19.313998,-99.150635',
    ),

    ItemsResultsMdl(
      title: 'HOSPITAL ABC',
      subtitle: 'Nivel 100 - Premium - Nivel A',
      desc:
          '''CERRO DE LAS TORRES 395, LAS AMERICAS, 01120, ALVARO OBREGON, DISTRITO FEDERAL''',
      gps: '19.313998,-99.150635',
    ),

    ItemsResultsMdl(
      title: 'CENTRO OFTALMOLOGICO SAN PABLO',
      subtitle: 'Nivel 100 - Premium - Nivel A',
      desc:
          '''CERRO DE LAS TORRES 395, LAS AMERICAS, 01120, ALVARO OBREGON, DISTRITO FEDERAL''',
      gps: '19.313998,-99.150635',
    ),

    ItemsResultsMdl(
      title: 'CENTRO OFTALMOLOGICO SAN PABLO',
      subtitle: 'Nivel 100 - Flexible Cuarzo - Nivel D',
      desc:
          '''CERRO DE LAS TORRES 395, SAN MIGUEL DE LA COLINA,45160, ZAPOPAN, JALISCO''',
      gps: '20.723567,-103.384987',
    ),

    ItemsResultsMdl(
      title: 'CENTRO DE ESTUDIOS OFTALMOLOGICOS LASER DE SALTILLO SA DE CV',
      subtitle:
          'Nivel 100 - Premium - Nivel A Nivel 100 - Flexible Indigo - Nivel C',
      desc:
          '''CERRO DE LAS TORRES 395, CAMPESTRE CHURUBUSCO, 04200, COYOACAN, DISTRITO FEDERAL''',
      gps: '19.313998,-99.150635',
    ),
  ];

  @override
  Future<void> onInit() async {
    super.onInit();

    /// Recibimos el tipo de búsqueda caso no venga nada, se asume vacío
    itemToSearch.value =
        Get.arguments as ItemToSearchDirectoryMdl? ??
        ItemToSearchDirectoryMdl.empty();

    await fetchResultsList();

    change(
      _FilterResultsModel.empty().copyWith(
        name: itemToSearch.value.itemSelected.title,
      ),
      status: RxStatus.success(),
    );
  }

  Future<void> fetchResultsList() async {
    await Future.delayed(const Duration(milliseconds: 750), () {});
  }
}
