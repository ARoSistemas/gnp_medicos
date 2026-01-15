import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/services/threads/threads_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/widgets/custom_alert.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/tabulators/repository/dtos/circulo_dto.dart';
import 'package:medicos/src/modules/tabulators/repository/dtos/estado_dto.dart';
import 'package:medicos/src/modules/tabulators/repository/dtos/tabulator_dto.dart';
import 'package:medicos/src/modules/tabulators/repository/tabulators_repository.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';

part 'tabulators_model.dart';

class TabulatorsController extends GetxController
    with StateMixin<_TabulatorsModel> {
  final AppStateController appState = Get.find<AppStateController>();
  final ThreadsService threadsService = Get.find();
  final TabulatorsRepository apiConn = Get.find();
  UserModel get user => appState.user;
  final TextEditingController cptController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Rx<List<String>> municipios = Rx([]);
  EstadoDto? estadoSelected;
  Rxn<String> municipioSelected = Rxn<String>();
  CirculoDto? circuloSelected;
  RxString procedimientoText = ''.obs;
  RxList<TabulatorDto> tabuladores = <TabulatorDto>[].obs;
  Rx<TabulatorDto?> tabuladorSelected = Rx<TabulatorDto?>(null);
  RxDouble costo = 0.00.obs;
  RxBool isSearch = false.obs;

  List<BreadcrumbWeb> breadcrumbs = [
    BreadcrumbWeb(msg.home.tr(), route: WelcomePage.page.name),
    BreadcrumbWeb(msg.tabulator.tr()),
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    await getCats();
    setDebounce();
  }
  
  void setDebounce() {
    debounce(
      procedimientoText,
      (_) async {
        if (procedimientoText.value.length >= 3) {
          final bool valid = formKey.currentState?.validate() ?? false;
          if (valid) {
            await getTabulators(procedimientoText.value);
          }
        }
      },
      time: const Duration(milliseconds: 500),
    );
  }


  Future<void> getTabulators(String cpt) async {
    final String filter = 
    'estado=${Uri.encodeQueryComponent((estadoSelected?.estado).value())}'
    '&municipio=${Uri.encodeQueryComponent(municipioSelected.value.value())}'
    '&circuloMedico=${Uri.encodeQueryComponent((circuloSelected?.circuloMedico)
    .value())}'
    '&procedimiento=${Uri.encodeQueryComponent(cpt)}'
    '&limit=40';
    await threadsService.execute(
      func: () async {
        final Response<List<TabulatorDto>> tabs = 
        await apiConn.getTabuladores(filter);
        final List<TabulatorDto> data = tabs.body ?? []
        ..sort((a, b) {
          String normalize(String s) =>
          s.replaceAll(RegExp(r'\s+'), ' ').trim();
          return normalize(a.dsCpt).compareTo(normalize(b.dsCpt));
        });
        tabuladores.value = data;
      },
    );
  }

  Future<void> getCats() async {
    await threadsService.execute(
      func: () async {
        final Response<List<EstadoDto>> edos = await apiConn.getEstados();
        final Response<List<CirculoDto>> circ = await apiConn.getCirculos();
        final _TabulatorsModel newState = _TabulatorsModel.empty().copyWith(
          estadosCat: edos.body,
          circulosCat: circ.body
        );
        change(newState, status: RxStatus.success());
      },
      onError: () {
        change(
          _TabulatorsModel.empty(),
          status: RxStatus.error(),
        );
      },
    );
  }

  void onChangeEstado(EstadoDto? estado) {
    estadoSelected = estado;
    municipioSelected.value = null;
    municipios.value = estado?.municipios ?? [];
    tabuladores.value = [];
    tabuladorSelected.value = null;
    costo.value = 0.00;
  }

  void onChangeMunicipio(String? municipio) {
    municipioSelected.value = municipio;
    tabuladores.value = [];
    tabuladorSelected.value = null;
    costo.value = 0.00;
  }

  void onChangeCirculo(CirculoDto? circulo) {
    circuloSelected = circulo;
    tabuladores.value = [];
    tabuladorSelected.value = null;
    costo.value = 0.00;
  }

  Future<void> onType(String? value) async {
    procedimientoText.value = value.value();
    tabuladorSelected.value = null;
    costo.value = 0.00;
  }

  Future<void> onSelectTabulator(TabulatorDto value) async {
    cptController.text = value.dsCpt;
    tabuladorSelected.value = value;
    tabuladores.value = [];
    costo.value = 0.00;
  }

  Future<void> onSearch() async {
    final bool? valid = formKey.currentState?.validate();
    if (valid.value()) {
      if (tabuladorSelected.value == null) {
        isSearch.value = true;
        await getTabulators(procedimientoText.value);
        isSearch.value = false;
        if (tabuladores.isNotEmpty) {
          tabuladorSelected.value = tabuladores.first;
          tabuladores.value = [];
        } else {
          appService.alert.show(
            type: AlertType.error,
            message: 'No hay tabulador en la zona solicitada.',
          );
        }
      }
      costo.value = (tabuladorSelected.value?.tabuladorHm).value();
    }
  }
}
