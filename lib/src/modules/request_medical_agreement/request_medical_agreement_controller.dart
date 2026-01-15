import 'package:get/get.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/services/threads/threads_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/models/incoming/solicitudes_model.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/shared/widgets/wdgt_table_web.dart';
import 'package:medicos/src/modules/request_medical_agreement/children/new_request/domain/repositories/request_medical_agreement_repository.dart';
import 'package:medicos/src/modules/request_medical_agreement/children/new_request/new_request_page.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';
import 'package:medicos/src/modules/welcome/widgets/modal_informative.dart';

part 'request_medical_agreement_model.dart';

class RequestMedicalAgreementController extends GetxController
    with StateMixin<_RequestMedicalAgreementModel> {
  final RequestMedicalAgreementRepository _requestAgreementRepository = Get.put(
    RequestMedicalAgreementRepository(),
  );
  final AppStateController appState = Get.find<AppStateController>();
  UserModel get user => appState.user;

  final RxBool isLoading = false.obs;
  List<SolicitudModel> requestsAgreement = [];
  List<SolicitudModel> requestsAgreementWeb = [];
  // Define los headers de la tabla
  List<TableHeader> get tableHeaders => [
    TableHeader(
      title: msg.doctorsName.tr(),
      columnKey: msg.doctorsName.key,
      sortable: false,
      flex: 3
    ),
    TableHeader(
      title: msg.folio.tr(),
      columnKey: msg.folio.key,
      flex: 4
    ),
    TableHeader(
      title: msg.dateRequest.tr(),
      columnKey: msg.dateRequest.key,
    ),
    TableHeader(
      title: msg.status.tr(),
      columnKey: msg.status.key,
    ),
    TableHeader(
      title: msg.actions.tr(),
      columnKey: msg.actions.key,
      sortable: false
    ),
  ];
  Map<String,List<SolicitudModel>> agreementpages = {};
  final ThreadsService threadsService = Get.find();
  RxInt currentPage = 1.obs;
  int totalPage = 1;

  /// Sorting
  RxString sortColumn = msg.doctorsName.key.obs;
  RxBool sortAscending = true.obs;

  List<BreadcrumbWeb> breadcrumbs = [
    BreadcrumbWeb(msg.home.tr(), route: WelcomePage.page.name),
    BreadcrumbWeb(msg.requestAgreement.tr()),
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    change(null, status: RxStatus.loading());

    const _RequestMedicalAgreementModel nuevaSolicitudModel =
        _RequestMedicalAgreementModel();
    await getRequestsAgreement();

    change(nuevaSolicitudModel, status: RxStatus.success());
  }

  Future<void> getRequestsAgreement() async {
    await threadsService.execute(
      func: () async {
        isLoading.value = true;
        requestsAgreement = await _requestAgreementRepository
          .getRequestsAgreement(user.uid,user.token.jwt);
        agreementpages = paginateList(requestsAgreement);
        if(agreementpages.isNotEmpty) {
          requestsAgreementWeb = agreementpages['1'] ?? [];
          totalPage = agreementpages.keys.length;
        }
        isLoading.value = false;
      },
      onError: () {
        isLoading.value = false;
      },
    );
  }

  Future<void> goToNewRequest() async {
    final bool result = await Get.toNamed(NewRequestPage.page.name);

    if (result) {
      change(null, status: RxStatus.loading());
      requestsAgreement = [];
      requestsAgreementWeb = [];
      const _RequestMedicalAgreementModel nuevaSolicitudModel =
        _RequestMedicalAgreementModel();
      await getRequestsAgreement();

    change(nuevaSolicitudModel, status: RxStatus.success());
      //update();
    }
  }

  Future<void> getComment(String idRequest) async {
    await threadsService.execute(
      func: () async {
        isLoading.value = true;
        final Response<String> comments = await _requestAgreementRepository
            .getCommentsRequest(idRequest, user.token.jwt);
        isLoading.value = false;
        await appService.alert.showAlert(
          child: ModalInformative(
            message: comments.body.value(),
            okMessage: msg.accept.tr(),
          )
        );
      },
      onError: () {
        isLoading.value = false;
      },
    );
  }

  Future<void> onSort(String column) async {
    if (sortColumn.value == column) {
      sortAscending.value = !sortAscending.value;
    } else {
      sortColumn.value = column;
      sortAscending.value = true;
    }

    await _sortByColumn(column, ascending: sortAscending.value);
  }

  Future<void> _sortByColumn(String column, {bool ascending = true}) async {
    requestsAgreementWeb.sort((a, b) {
      int result;

      if (column == msg.doctorsName.key) {
        result = a.nombreMedico.compareTo(b.nombreMedico);
      } else if (column == msg.folio.key) {
        result = a.cveSolicitud.compareTo(b.cveSolicitud);
      } else if (column == msg.dateRequest.key) {
        result = _compareDates(
          a.fechaSolicitud,
          b.fechaSolicitud,
        );
      } else if (column == msg.status.key) {
        result = a.descripcionEstatus.compareTo(b.descripcionEstatus);
      } else if (column == msg.actions.key) {
        result = a.cveEstatus.compareTo(b.cveEstatus);
      } else {
        result = 0;
      }

      return ascending ? result : -result;
    });

    update();
  }

  int _compareDates(String a, String b) {
    final DateTime dateA = DateTime.parse(a.replaceAll('/', '-'));
    final DateTime dateB = DateTime.parse(b.replaceAll('/', '-'));
    return dateA.compareTo(dateB);
  }


  void onChangePage(int index){
    if(index <= agreementpages.keys.length){
      requestsAgreementWeb = agreementpages[index.toString()] ?? [];
      currentPage.value = index;
    }  
  }
  
  Map<String, List<SolicitudModel>> paginateList(List<SolicitudModel> list) {
    const int pageSize = 10;
    final Map<String, List<SolicitudModel>> pages = {};

    for (int i = 0; i < list.length; i += pageSize) {
      final int end = (i + pageSize < list.length) ? i + pageSize : list.length;
      final int pageNumber = (i ~/ pageSize) + 1;
      pages[pageNumber.toString()] = list.sublist(i, end);
    }

    return pages;
  }

}
