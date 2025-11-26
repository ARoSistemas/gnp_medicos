import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:medicos/src/modules/anexos/anexos_page.dart';
import 'package:medicos/src/modules/benefits/benefits_page.dart';
import 'package:medicos/src/modules/contacto/contacto_page.dart';
import 'package:medicos/src/modules/convenio_medico/children/view_pdf/view_pdf_page.dart';
import 'package:medicos/src/modules/convenio_medico/convenio_medico_page.dart';
import 'package:medicos/src/modules/directorio/children/filter_page/filterpage_page.dart';
import 'package:medicos/src/modules/directorio/children/filter_results/filter_results_page.dart';
import 'package:medicos/src/modules/directorio/children/item_map/item_map_page.dart';
import 'package:medicos/src/modules/directorio/directorio_page.dart';
import 'package:medicos/src/modules/formats/formats_page.dart';
import 'package:medicos/src/modules/home/home_page.dart';
import 'package:medicos/src/modules/login/login_page.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/add_user_page.dart';
import 'package:medicos/src/modules/profile/children/assistants/assistants_page.dart';
import 'package:medicos/src/modules/profile/children/datos_academicos/datos_academicos_page.dart';
import 'package:medicos/src/modules/profile/children/datos_fiscales/datos_fiscales_page.dart';
import 'package:medicos/src/modules/profile/children/datos_personales/datos_personales_page.dart';
import 'package:medicos/src/modules/profile/profile_page.dart';
import 'package:medicos/src/modules/registro/registro_page.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/nueva_solicitud/nueva_solicitud_page.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/upload_documents/children/request_documents/request_documents_page.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/children/upload_documents/upload_documents_page.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/solicitud_convenio_medico_page.dart';
import 'package:medicos/src/modules/tabuladores/tabuladores_page.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';

final class AppNavigation {
  static final List<GetPage> pages = [
    ConvenioMedicoPage.page,
    HomePage.page,
    LoginPage.page,
    ProfilePage.page,
    SolicitudConvenioMedicoPage.page,
    ViewPdfPage.page,
    WelcomePage.page,
    DatosPersonalesPage.page,
    DatosAcademicosPage.page,
    DatosFiscalesPage.page,
    AddUserPage.page,
    TabuladoresPage.page,
    AnexosPage.page,
    FormatsPage.page,
    BeneficiosPage.page,
    RegistroPage.page,
    AssistantsPage.page,
    ViewPdfPage.page,
    DirectorioPage.page,
    FilterPage.page,
    FilterResultsPage.page,
    ItemMapPage.page,
    ContactoPage.page,
    NuevaSolicitudPage.page,
    UploadDocumentsPage.page,
    RequestDocumentsPage.page,
  ];
}
