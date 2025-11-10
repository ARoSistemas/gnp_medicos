import 'package:get/get.dart';
import 'package:medicos/core/services/threads/threads_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/upload_documents/children/request_documents/domain/dtos/tipye_documents_dto.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/upload_documents/children/request_documents/domain/repositories/request_documents_repository.dart';

part 'request_documents_model.dart';

class RequestDocumentsController extends GetxController
    with StateMixin<_RequestDocumentsModel> {
  final ThreadsService threadsService = Get.find();
  final RequestDocumentsRepository apiConn = Get.find();

  final AppStateController appState = Get.find<AppStateController>();
  UserModel get user => appState.user;

  final Rx<String?> selectedDocumentType = Rx<String?>(null);

  @override
  Future<void> onInit() async{
    super.onInit();
    change(null, status: RxStatus.loading());
    await getTypeDocuments();
  }

  /*  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  } */

  Future<void> getTypeDocuments() async {
    change(state, status: RxStatus.loading());
    await threadsService.execute(
      func: () async {
        final List<TypeDocumentModel> typeDocuments = await apiConn
            .getTypeDocuments(user.token.jwt);
        change(
          _RequestDocumentsModel.empty().copyWith(
            listTypeDocuments: typeDocuments,
          ),
          status: RxStatus.success(),
        );
      },
    );
  }

  Future<void> onDocumentTypeChanged(String? value) async {
    selectedDocumentType.value = value;
  }
}
