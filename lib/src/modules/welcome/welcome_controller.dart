import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
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
import 'package:medicos/src/modules/welcome/widgets/modal_acept_terms.dart';

part 'welcome_model.dart';

class WelcomeController extends GetxController with StateMixin<_WelcomeModel> {
  final AppStateController appState = Get.find();
  String get jwt => appState.user.token.jwt;
  UserModel get user => appState.user;

  /// Flags de visibilidad de modulos
  Map<String, dynamic> permisos = {};
  bool banConvenio = false;
  final List<MenuWebItem> _menuItems = <MenuWebItem>[];

  List<MenuWebItem> get menuItems => List.unmodifiable(_menuItems);

  @override
  void onInit() {
    super.onInit();
    const _WelcomeModel welcomeModel = _WelcomeModel();

    // permisos = appState.userPermissions;
    // banConvenio = appState.user.banConvenioVigente;

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
    change(welcomeModel, status: RxStatus.success());
  }

  void _buildMenu() {
    _menuItems
      ..clear()
      ..add(
        MenuWebItem(
          label: 'Inicio',
          route: WelcomePage.page.name,
          tooltip: 'Inicio',
          icon: ImageFromWeb(
            imageName: 'icono_modulo_convenio_medico.png',
            jwt: jwt,
          ),
          breadcrumbs: [
            const MenuWebBreadcrumb('Inicio'),
          ],
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
        MenuWebBreadcrumb(
          'Inicio',
          route: WelcomePage.page.name,
        ),
        MenuWebBreadcrumb(label),
      ];

  @override
  Future<void> onReady() async {
    super.onReady();
    await _showBottomSheet();
  }

  Future<void> _showBottomSheet() async {
    if (!kIsWeb) {
      await showModalBottomSheet(
        context: Get.context!,
        builder: (context) => const ModalAceptTerms(),
        isScrollControlled: true,
        isDismissible: false,
      );
    }
  }
}
