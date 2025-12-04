import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/widgets/layout/menu_web/menu_web.dart';
import 'package:medicos/shared/widgets/wdgt_image_from_web.dart';
import 'package:medicos/src/modules/anexos/anexos_page.dart';
import 'package:medicos/src/modules/benefits/benefits_page.dart';
import 'package:medicos/src/modules/contacto/contacto_page.dart';
import 'package:medicos/src/modules/convenio_medico/convenio_medico_page.dart';
import 'package:medicos/src/modules/directorio/directorio_page.dart';
import 'package:medicos/src/modules/evaluations/evaluations_page.dart';
import 'package:medicos/src/modules/formats/formats_page.dart';
import 'package:medicos/src/modules/payments/payments_page.dart';
import 'package:medicos/src/modules/procedures/procedures_page.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/solicitud_convenio_medico_page.dart';
import 'package:medicos/src/modules/tabuladores/tabuladores_page.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';
import 'package:url_launcher/url_launcher.dart';

part 'contacto_model.dart';

class ContactoController extends GetxController
    with StateMixin<_ContactoModel> {
  final AppStateController appState = Get.find<AppStateController>();
  UserModel get user => appState.user;
  String get jwt => appState.user.token.jwt;

  /// Flags de visibilidad de modulos
  Map<String, dynamic> permisos = {};
  bool banConvenio = false;
  final List<MenuWebItem> _menuItems = <MenuWebItem>[];

  List<MenuWebItem> get menuItems => List.unmodifiable(_menuItems);

  List<ItemsContacts> items = [];
  Map? redes;
  Map? contacto;

  @override
  Future<void> onInit() async {
    super.onInit();
    change(const _ContactoModel(), status: RxStatus.loading());

    /// *******************************************************************
    /// permisos TMP
    ///
    permisos = {
      '/convenio-medico': true,
      '/tabuladores': true,
      '/mis-pagos': true,
      '/solicitar-convenio': true,
      '/mis-tramites': true,
      '/beneficios': true,
      '/anexos': true,
      '/formatos': true,
      '/evaluaciones': true,
      '/directorio-medico': true,
    };

    ///
    /// banConvenio TMP
    ///
    banConvenio = true;

    ///
    ///
    /// *******************************************************************

    _buildMenu();
    await getData();
  }

  void _buildMenu() {
    _menuItems
      ..clear()
      ..add(
        MenuWebItem(
          label: 'Inicio',
          route: '/welcome',
          tooltip: 'Inicio',
          icon: ImageFromWeb(
            imageName: 'icono_modulo_convenio_medico.png',
            jwt: jwt,
          ),
          breadcrumbs: _buildBreadcrumbs('Inicio'),
        ),
      );

    /// Menu Convenio Medico
    if ((permisos[ConvenioMedicoPage.page.name] ?? false) && banConvenio) {
      _menuItems.add(
        MenuWebItem(
          label: 'Convenio Médico',
          route: ConvenioMedicoPage.page.name,
          tooltip: 'Convenio Médico',
          icon: ImageFromWeb(
            imageName: 'icono_modulo_convenio_medico.png',
            jwt: jwt,
          ),
          breadcrumbs: _buildBreadcrumbs('Convenio Médico'),
        ),
      );
    }

    /// Menu Tabuladores
    if ((permisos[TabuladoresPage.page.name] ?? false) && banConvenio) {
      _menuItems.add(
        MenuWebItem(
          label: 'Tabuladores',
          route: TabuladoresPage.page.name,
          tooltip: 'Tabuladores',
          icon: ImageFromWeb(
            imageName: 'icono_modulo_tabuladores.png',
            jwt: jwt,
          ),
          breadcrumbs: _buildBreadcrumbs('Tabuladores'),
        ),
      );
    }

    /// Menu  Mis Pagos
    if (permisos[PaymentsPage.page.name] ?? false) {
      _menuItems.add(
        MenuWebItem(
          label: 'Mis Pagos',
          route: PaymentsPage.page.name,
          tooltip: 'Mis Pagos',
          icon: ImageFromWeb(
            imageName: 'icono_modulo_mis_pagos.png',
            jwt: jwt,
          ),
          breadcrumbs: _buildBreadcrumbs('Mis Pagos'),
        ),
      );
    }

    /// Menu Nueva solicitud
    if (permisos[SolicitudConvenioMedicoPage.page.name] ?? false) {
      _menuItems.add(
        MenuWebItem(
          label: 'Solicitud convenio médico',
          route: SolicitudConvenioMedicoPage.page.name,
          tooltip: 'Solicitud convenio médico',
          icon: ImageFromWeb(
            imageName: 'icono_modulo_solicitud_convenio_medico.png',
            jwt: jwt,
          ),
          breadcrumbs: _buildBreadcrumbs('Solicitud convenio médico'),
        ),
      );
    }

    /// Menu Mis Tramites
    if (permisos[ProceduresPage.page.name] ?? false) {
      _menuItems.add(
        MenuWebItem(
          label: 'Mis Trámites',
          route: ProceduresPage.page.name,
          tooltip: 'Mis Trámites',
          icon: ImageFromWeb(
            imageName: 'icono_modulo_mis_tramites.png',
            jwt: jwt,
          ),
          breadcrumbs: _buildBreadcrumbs('Mis Trámites'),
        ),
      );
    }

    /// Menu Beneficios
    if (permisos[BeneficiosPage.page.name] ?? false) {
      _menuItems.add(
        MenuWebItem(
          label: 'Beneficios',
          route: BeneficiosPage.page.name,
          tooltip: 'Beneficios',
          icon: ImageFromWeb(
            imageName: 'icono_modulo_beneficios.png',
            jwt: jwt,
          ),
          breadcrumbs: _buildBreadcrumbs('Beneficios'),
        ),
      );
    }

    /// Menu Anexos
    if (permisos[AnexosPage.page.name] ?? false) {
      _menuItems.add(
        MenuWebItem(
          label: 'Anexos',
          route: AnexosPage.page.name,
          tooltip: 'Anexos',
          icon: ImageFromWeb(
            imageName: 'icono_modulo_anexos.png',
            jwt: jwt,
          ),
          breadcrumbs: _buildBreadcrumbs('Anexos'),
        ),
      );
    }

    /// Menu Formatos
    if (permisos[FormatsPage.page.name] ?? false) {
      _menuItems.add(
        MenuWebItem(
          label: 'Formatos',
          route: FormatsPage.page.name,
          tooltip: 'Formatos',
          icon: ImageFromWeb(
            imageName: 'icono_modulo_formatos.png',
            jwt: jwt,
          ),
          breadcrumbs: _buildBreadcrumbs('Formatos'),
        ),
      );
    }

    /// Menu Evaluación
    if (permisos[EvaluationsPage.page.name] ?? false) {
      _menuItems.add(
        MenuWebItem(
          label: 'Evaluación',
          route: EvaluationsPage.page.name,
          tooltip: 'Evaluación',
          icon: ImageFromWeb(
            imageName: 'icono_modulo_evaluacion.png',
            jwt: jwt,
          ),
          breadcrumbs: _buildBreadcrumbs('Evaluación'),
        ),
      );
    }

    /// Menu Directorio Medico
    if (permisos[DirectorioPage.page.name] ?? false) {
      _menuItems.add(
        MenuWebItem(
          label: 'Directorio médico',
          route: DirectorioPage.page.name,
          tooltip: 'Directorio médico',
          icon: ImageFromWeb(
            imageName: 'icono_modulo_directorio_medico.png',
            jwt: jwt,
          ),
          breadcrumbs: _buildBreadcrumbs('Directorio médico'),
        ),
      );
    }

    /// Menu Contacto GNP
    _menuItems.add(
      MenuWebItem(
        label: 'Contacto GNP',
        route: ContactoPage.page.name,
        tooltip: 'Contacto GNP',
        icon: ImageFromWeb(
          imageName: 'icono_modulo_contacto.png',
          jwt: jwt,
        ),
        breadcrumbs: _buildBreadcrumbs('Contacto GNP'),
      ),
    );
  }

  List<MenuWebBreadcrumb> _buildBreadcrumbs(String label) =>
      <MenuWebBreadcrumb>[
        MenuWebBreadcrumb('Inicio', route: WelcomePage.page.name),
        MenuWebBreadcrumb(label),
      ];

  Future<void> getData() async {
    final Map? dataFirebase = await appService.shared.firebaseService
        .getDataOnce('appConfig/modulos/contactanos');
    if (dataFirebase != null) {
      change(const _ContactoModel(), status: RxStatus.success());
    } else {
      change(const _ContactoModel(), status: RxStatus.error());
      return;
    }
    redes = dataFirebase['redes'] as Map;
    contacto = dataFirebase['contacto'] as Map;

    items = [
      ItemsContacts(
        title: msg.webSite.value,
        contact: 'gnp.com.mx',
        isLink: true,
        onTap: () => launchWeb(dataFirebase['pagina']),
      ),
      ItemsContacts(
        title: msg.gnpLine.value,
        contact: '5552279000',
        isLink: true,
        onTap: () => launchPhoneContact(dataFirebase['telefono']),
      ),
      ItemsContacts(
        title: '@GNPSeguros',
        contact: '+525552279000',
        isLink: false,
        img: 'icono_contactanos_facebook.png',
        jwt: jwt,
        onTap: () => launchWeb(redes!['facebook']),
      ),
      ItemsContacts(
        title: '@GNPSeguros',
        img: 'icono_contactanos_x.png',
        isLink: false,
        jwt: jwt,
        onTap: () => launchWeb(redes!['x']),
      ),
      ItemsContacts(
        title: '@GNPSeguros',
        img: 'icono_contactanos_instagram.png',
        isLink: false,
        jwt: jwt,
        onTap: () => launchWeb(redes!['instagram']),
      ),
    ];
  }

  Future<void> launchPhoneContact(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> launchWeb(String socialNetwork) async {
    final Uri url = Uri.parse(socialNetwork);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> launchEmail(String email, {String? subject}) async {
    String? encodeQueryParameters(Map<String, String> params) => params.entries
        .map(
          (e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters(<String, String>{
        'subject': subject ?? '',
      }),
    );

    // launchUrl(emailLaunchUri);
    await launchUrl(emailLaunchUri);
  }
}
