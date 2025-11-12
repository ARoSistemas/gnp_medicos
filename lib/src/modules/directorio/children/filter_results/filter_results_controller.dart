import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/utils/exception_manager.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/domain/entities/dtos/clinicas_dto.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/domain/entities/dtos/hospitales_dto.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/domain/entities/dtos/medico_dto.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/domain/entities/dtos/otros_servicios_dto.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/domain/repositories/filter_results_repository.dart';
import 'package:medicos/src/modules/directorio/domain/entities/filter_directory_mdl.dart';

part 'filter_results_model.dart';

class FilterResultsController extends GetxController
    with StateMixin<_FilterResultsModel>, WidgetsBindingObserver {
  final AppStateController appState = Get.find();
  final FilterResultsRepository _apiConn = Get.find();

  UserModel get user => appState.user;

  /// Item selected to search
  Rx<ItemToSearchDirectoryMdl> itemToSearch =
      ItemToSearchDirectoryMdl.empty().obs;

  /// Scroll controller for pagination
  final ScrollController scrollController = ScrollController();

  /// Indicates if more data is being fetched for pagination
  RxBool isFetchingMore = false.obs;

  /// Current page for pagination
  RxInt currentPage = 1.obs;

  /// Total number of pages for pagination
  int nTotalPages = 0;

  /// Filter string built based on selected filters
  String filterString = '';

  /// Total results obtained from the search
  int totalResults = 0;

  /// List of items to show in the results
  RxList<dynamic> listToShow = <dynamic>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    /// Get type of search, if nothing comes, it is assumed empty
    itemToSearch.value =
        Get.arguments as ItemToSearchDirectoryMdl? ??
        ItemToSearchDirectoryMdl.empty();

    final _FilterResultsModel tmp = _FilterResultsModel.empty().copyWith(
      name: itemToSearch.value.itemSelected.subtitle,
    );

    /// Listen to scroll events for pagination
    scrollController.addListener(_onScroll);

    change(tmp, status: RxStatus.loading());

    /// Set initial values according to the type of search
    await setTypeSearch(itemToSearch.value);

    change(tmp, status: RxStatus.success());
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    super.onClose();
  }

  /// Load next page for pagination
  Future<void> loadNextPage() async {
    if (currentPage.value >= nTotalPages) {
      return;
    }

    if (isFetchingMore.value) {
      return;
    }

    isFetchingMore.value = true;
    currentPage.value++;

    switch (itemToSearch.value.idPage) {
      case 'medicos':
        await fetchMedicosFiltered(filterString, currentPage.value);
      case 'hospitales':
        await fetchHospitalesFiltered(filterString, currentPage.value);
      case 'clinicas':
        await fetchClinicasFiltered(filterString, currentPage.value);
      case 'otros_servicios':
        await fetchOtrosServiciosFiltered(filterString, currentPage.value);
    }

    isFetchingMore.value = false;
  }

  /// Listen to scroll events for pagination
  Future<void> _onScroll() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      await loadNextPage();
    }
  }

  /// Set initial values according to the type of search
  Future<void> setTypeSearch(ItemToSearchDirectoryMdl itemSelected) async {
    switch (itemSelected.idPage) {
      case 'medicos':
        filterString = buildFilterString();
        await fetchMedicosFiltered(filterString, currentPage.value);
      case 'hospitales':
        filterString = buildFilterString();
        await fetchHospitalesFiltered(filterString, currentPage.value);
      case 'clinicas':
        filterString = buildFilterString();
        await fetchClinicasFiltered(filterString, currentPage.value);
      case 'otros_servicios':
        filterString = buildFilterString();
        await fetchOtrosServiciosFiltered(filterString, currentPage.value);
      default:
        await fetchMedicosFiltered('origen=corporativo', currentPage.value);
    }

    /// Inform that we are loading the data
    change(state, status: RxStatus.loading());
  }

  /// Build filter string based on selected filters
  String buildFilterString() {
    switch (itemToSearch.value.idPage) {
      case 'medicos':

        /// Filtros completos del medico. En caso de no seleccionar un filtro
        /// se omite en la petición.
        ///
        /// En el input especialidad se puede mandar como texto a buscar:
        /// ?especialidad=Urologia
        ///
        /// Filtros disponibles en medicos
        /// ?
        /// claveEstado=01 &
        /// claveMunicipio=01004 &
        /// claveCirculoMedico=0003 &
        /// claveEspecialidad=116 &
        /// nombreMedico=Nombre%20Opcional &
        /// origen=corporativo &
        /// pagina=1

        String filtros = itemToSearch.value.searchBy.isNotEmpty
            ? 'nombreMedico=${itemToSearch.value.searchBy}'
            : '';

        filtros += itemToSearch.value.circuloMedico['claveCirculoMedico'] != '0'
            ? '''${filtros.isEmpty ? '' : '&'}claveCirculoMedico=${itemToSearch.value.circuloMedico['claveCirculoMedico']}'''
            : '';

        filtros += itemToSearch.value.especialidad['claveEspecialidad'] != '0'
            ? '''${filtros.isEmpty ? '' : '&'}claveEspecialidad=${itemToSearch.value.especialidad['claveEspecialidad']}'''
            : '';

        filtros += itemToSearch.value.estado['claveEstado'] != '0'
            ? '''${filtros.isEmpty ? '' : '&'}claveEstado=${itemToSearch.value.estado['claveEstado']}'''
            : '';

        filtros +=
            (itemToSearch.value.municipio['claveMunicipio'] ?? '0') != '0'
            ? '''${filtros.isEmpty ? '' : '&'}claveMunicipio=${itemToSearch.value.municipio['claveMunicipio']}'''
            : '';

        filtros += filtros.isNotEmpty
            ? '&origen=corporativo'
            : 'origen=corporativo';
        return filtros;
      case 'hospitales':

        /// ?
        /// claveEstado=01 &
        /// claveMunicipio=01004 &
        /// claveLineaNegocio=P &
        /// clavePlan=RVER &
        /// paramBusqueda=Angeles &
        /// origen=corporativo &
        /// pagina=1
        ///
        /// ?paramBusqueda=angeles&origen=corporativo&pagina=1
        /// ?nombreComercial=angeles&origen=corporativo

        String filtros = itemToSearch.value.searchBy.isNotEmpty
            ? 'paramBusqueda=${itemToSearch.value.searchBy}'
            : '';

        filtros += itemToSearch.value.planHospitalario['clavePlan'] != '0'
            ? '''${filtros.isEmpty ? '' : '&'}clavePlan=${itemToSearch.value.planHospitalario['clavePlan']}'''
            : '';

        filtros += itemToSearch.value.estado['claveEstado'] != '0'
            ? '''${filtros.isEmpty ? '' : '&'}claveEstado=${itemToSearch.value.estado['claveEstado']}'''
            : '';

        filtros +=
            (itemToSearch.value.municipio['claveMunicipio'] ?? '0') != '0'
            ? '''${filtros.isEmpty ? '' : '&'}claveMunicipio=${itemToSearch.value.municipio['claveMunicipio']}'''
            : '';

        filtros += filtros.isNotEmpty
            ? '&origen=corporativo'
            : 'origen=corporativo';

        return filtros;
      case 'clinicas':

        ///  ?
        /// claveEstado=AGUASCALIENTES &
        /// claveMunicipio= EL%20LLANO &
        /// lineaNegocio=LP &
        /// claveTipoClinica=CE &
        /// paramBusqueda=Maternidad &
        ///
        /// pagina=1 &
        /// banClinicaCE=CE
        String filtros = itemToSearch.value.searchBy.isNotEmpty
            ? 'paramBusqueda=${itemToSearch.value.searchBy}'
            : '';

        filtros += itemToSearch.value.clinica['claveTipoClinica'] != '0'
            ? '''${filtros.isEmpty ? '' : '&'}claveTipoClinica=${itemToSearch.value.clinica['claveTipoClinica']}'''
            : '';

        filtros += itemToSearch.value.estado['claveEstado'] != '0'
            ? '''${filtros.isEmpty ? '' : '&'}claveEstado=${itemToSearch.value.estado['claveEstado']}'''
            : '';

        filtros +=
            (itemToSearch.value.municipio['claveMunicipio'] ?? '0') != '0'
            ? '''${filtros.isEmpty ? '' : '&'}claveMunicipio=${itemToSearch.value.municipio['claveMunicipio']}'''
            : '';

        filtros += filtros.isNotEmpty ? '&banClinicaCE=CE' : 'banClinicaCE=CE';

        return filtros;
      case 'otros_servicios':

        /// ?
        /// paramBusqueda=TipoServicio &
        /// claveEstado=01 &
        /// claveMunicipio=01002 &
        /// claveTipoProveedor=7 &
        /// pagina=1 &
        /// claveTipoServicio=7
        String filtros = itemToSearch.value.searchBy.isNotEmpty
            ? 'paramBusqueda=${itemToSearch.value.searchBy}'
            : '';

        filtros += itemToSearch.value.clinica['claveTipoProveedor'] != '0'
            ? '''${filtros.isEmpty ? '' : '&'}claveTipoProveedor=${itemToSearch.value.clinica['claveTipoProveedor']}'''
            : '';

        filtros += itemToSearch.value.clinica['claveTipoServicio'] != '0'
            ? '''${filtros.isEmpty ? '' : '&'}claveTipoProveedor=${itemToSearch.value.clinica['claveTipoProveedor']}'''
            : '';

        filtros += itemToSearch.value.estado['claveEstado'] != '0'
            ? '''${filtros.isEmpty ? '' : '&'}claveEstado=${itemToSearch.value.estado['claveEstado']}'''
            : '';

        filtros +=
            (itemToSearch.value.municipio['claveMunicipio'] ?? '0') != '0'
            ? '''${filtros.isEmpty ? '' : '&'}claveMunicipio=${itemToSearch.value.municipio['claveMunicipio']}'''
            : '';

        return filtros;
      default:
        return '';
    }
  }

  /// Get filtered medicos
  Future<void> fetchMedicosFiltered(String filter, int page) =>
      appService.threads.execute(
        customExceptionMessages: {
          Exception(): ExceptionAlertProperties(
            message:
                '''Error al obtener medicos. Inténtalo de nuevo más tarde''',
          ),
        },
        func: () async {
          /// Se obtienen los datos de los planes hospitalarios
          final Response<MedicosDto> hasData = await _apiConn
              .fetchItemMedicosFiltered('?$filter&pagina=$page');

          /// Get the first element of the Medicos group and
          /// build the list
          if (hasData.body!.gruposMedicos.isNotEmpty) {
            if (page == 1) {
              listToShow.clear();
            }
            listToShow.addAll(hasData.body!.gruposMedicos.first.medicos);
            nTotalPages = hasData.body!.pagTotales;
            totalResults = hasData.body!.registrosTotales;
          } else {
            if (page == 1) {
              listToShow.value = [];
            }
          }

          /// Se informa que la carga fue exitosa
          change(state, status: RxStatus.success());
        },
        onError: () => change(state, status: RxStatus.error()),
      );

  /// Get filtered hospitales
  Future<void> fetchHospitalesFiltered(String filter, int page) =>
      appService.threads.execute(
        customExceptionMessages: {
          Exception(): ExceptionAlertProperties(
            message:
                '''Error al obtener hospitales. Inténtalo de nuevo más tarde''',
          ),
        },
        func: () async {
          final Response<HospitalesDto> hasData = await _apiConn
              .fetchItemHospitalesFiltered('?$filter&pagina=$page');

          /// Get the first element of the Hospitales group and
          /// build the list
          if (hasData.body!.gruposHospitalarios.isNotEmpty) {
            if (page == 1) {
              listToShow.clear();
            }
            listToShow.addAll(
              hasData.body!.gruposHospitalarios.first.hospitales,
            );
            nTotalPages = hasData.body!.pagTotales;
            totalResults = hasData.body!.registrosTotales;
          } else {
            if (page == 1) {
              listToShow.value = [];
            }
          }

          /// Se informa que la carga fue exitosa
          change(state, status: RxStatus.success());
        },
        onError: () => change(state, status: RxStatus.error()),
      );

  /// Get filtered clinicas
  Future<void> fetchClinicasFiltered(String filter, int page) =>
      appService.threads.execute(
        customExceptionMessages: {
          Exception(): ExceptionAlertProperties(
            message:
                '''Error al obtener clínicas. Inténtalo de nuevo más tarde''',
          ),
        },
        func: () async {
          final Response<ClinicasDto> hasData = await _apiConn
              .fetchItemClinicasFiltered('?$filter&pagina=$page');

          /// Se obtiene el primer elemento del grupo de Clinicas y
          /// se construye la lista
          if (hasData.body!.gruposClinicas.isNotEmpty) {
            if (page == 1) {
              listToShow.clear();
            }
            listToShow.addAll(hasData.body!.gruposClinicas.first.clinicas);
            nTotalPages = hasData.body!.pagTotales;
            totalResults = hasData.body!.registrosTotales;
          } else {
            if (page == 1) {
              listToShow.value = [];
            }
          }

          /// Se informa que la carga fue exitosa
          change(state, status: RxStatus.success());
        },
        onError: () => change(state, status: RxStatus.error()),
      );

  /// Get filtered otros servicios
  Future<void> fetchOtrosServiciosFiltered(
    String filter,
    int page,
  ) => appService.threads.execute(
    customExceptionMessages: {
      Exception(): ExceptionAlertProperties(
        message:
            '''Error al obtener otros servicios.. Inténtalo de nuevo más tarde''',
      ),
    },
    func: () async {
      final Response<OtrosServiciosDto> hasData = await _apiConn
          .fetchItemOtrosServiciosFiltered('$filter?&pagina=$page');

      /// Get the first element of the Clinicas group and
      /// build the list
      if (hasData.body!.gruposSauxs.isNotEmpty) {
        if (page == 1) {
          listToShow.clear();
        }
        listToShow.addAll(hasData.body!.gruposSauxs.first.sauxs);
        nTotalPages = hasData.body!.pagTotales;
        totalResults = hasData.body!.registrosTotales;
      } else {
        if (page == 1) {
          listToShow.value = [];
        }
      }

      /// Inform that the load was successful
      change(state, status: RxStatus.success());
    },
    onError: () => change(state, status: RxStatus.error()),
  );
}
