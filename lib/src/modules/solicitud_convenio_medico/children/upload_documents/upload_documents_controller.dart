import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';

part 'upload_documents_model.dart';

class UploadDocumentsController extends GetxController
  with StateMixin<_UploadDocumentsModel> {
   final AppStateController appState = Get.find<AppStateController>();
  UserModel get user => appState.user;

  final RxInt selectedIndex = 0.obs;
  final Rx<String?> selectedItem = Rx<String?>(null);

  final List<String> items = ['Carta de adhesión', 'Opción 2', 'Opción 3'];

  List<Map<String, String>> documentCardsWithoutOnTap = [
    {
      'title': 'Cédula CURP vigente',
      'description': 'Descripción del documento',
    },
    {
      'title': 'Cédula de la especialidad',
      'description': 'ambos lados',
    },
    {
      'title': 'Cédula profesinal',
      'description': 'ambos lados',
    },
    {
      'title': 'Cédula RFC',
      'description': 'ambos lados',
    },
    {
      'title': 'Certificación recertificación vigente o ...',
      'description': 'ambos lados',
    },
    {
      'title': 'Estado de Cuenta Bancario Actualizado',
      'description': 'Descripción del documento',
    },
    {
      'title': 'Identificación Oficial vigente por ambos ...',
      'description': 'Descripción del documento',
    },
    {
      'title': 'Póliza de responsabilidad profesional vi...',
      'description': 'Descripción del documento',
    },
    {
      'title': 'Título Profesional',
      'description': 'Descripción del documento',
    },
    {
      'title': 'Título especialidad(Opcional)',
      'description': 'Descripción del documento',
    },
    {
      'title': 'Título subespecialidad(Opcional)',
      'description': 'Descripción del documento',
    },
    {
      'title': 'Cédula subespecialidad(Opcional)',
      'description': 'Descripción del documento',
    },
  ];

  void updateSelectedValue(String? newValue) {
    if (newValue != null) {
      selectedItem.value = newValue;
    }
  }

  @override
  void onInit() {
    super.onInit();
    const _UploadDocumentsModel solicitudDocumentacionModel =
        _UploadDocumentsModel();
    change(solicitudDocumentacionModel, status: RxStatus.success());
  }
}
