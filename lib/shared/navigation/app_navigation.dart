import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:medicos/src/modules/annexes/annexes_page.dart';
import 'package:medicos/src/modules/benefits/benefits_page.dart';
import 'package:medicos/src/modules/change_password/change_password_page.dart';
import 'package:medicos/src/modules/contact/contact_page.dart';
import 'package:medicos/src/modules/convenio_medico/convenio_medico_page.dart';
import 'package:medicos/src/modules/directory/children/filter_page/filterpage_page.dart';
import 'package:medicos/src/modules/directory/children/filter_results/filter_results_page.dart';
import 'package:medicos/src/modules/directory/children/item_map/item_map_page.dart';
import 'package:medicos/src/modules/directory/directory_page.dart';
import 'package:medicos/src/modules/formats/formats_page.dart';
import 'package:medicos/src/modules/home/home_page.dart';
import 'package:medicos/src/modules/login/login_page.dart';
import 'package:medicos/src/modules/payments/payments_page.dart';
import 'package:medicos/src/modules/procedures/procedures_page.dart';
import 'package:medicos/src/modules/profile/children/academic_data/academic_data_page.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/add_user_page.dart';
import 'package:medicos/src/modules/profile/children/assistants/assistants_page.dart';
import 'package:medicos/src/modules/profile/children/fiscal_data/fiscal_data_page.dart';
import 'package:medicos/src/modules/profile/children/personal_data/personal_data_page.dart';
import 'package:medicos/src/modules/profile/profile_page.dart';
import 'package:medicos/src/modules/registro/registro_page.dart';
import 'package:medicos/src/modules/request_medical_agreement/children/new_request/new_request_page.dart';
import 'package:medicos/src/modules/request_medical_agreement/children/upload_documents/children/request_documents/request_documents_page.dart';
import 'package:medicos/src/modules/request_medical_agreement/children/upload_documents/upload_documents_page.dart';
import 'package:medicos/src/modules/request_medical_agreement/request_medical_agreement_page.dart';
import 'package:medicos/src/modules/tabulators/tabulators_page.dart';
import 'package:medicos/src/modules/view_pdf/view_pdf_page.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';

final class AppNavigation {
  static final List<GetPage> pages = [
    ConvenioMedicoPage.page,
    HomePage.page,
    LoginPage.page,
    ProfilePage.page,
    RequestMedicalAgreementPage.page,
    ViewPdfPage.page,
    WelcomePage.page,
    DatosPersonalesPage.page,
    DatosAcademicosPage.page,
    DatosFiscalesPage.page,
    AddUserPage.page,
    TabuladoresPage.page,
    AnnexesPage.page,
    FormatsPage.page,
    BeneficiosPage.page,
    RegistroPage.page,
    AssistantsPage.page,
    DirectoryPage.page,
    FilterPage.page,
    FilterResultsPage.page,
    ItemMapPage.page,
    ContactPage.page,
    NewRequestPage.page,
    UploadDocumentsPage.page,
    RequestDocumentsPage.page,
    ProceduresPage.page,
    PaymentsPage.page,
    ChangePasswordPage.page,
    ChangePasswordPage.activarPage,
  ];
}
