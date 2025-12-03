import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/widgets/wdgt_image_from_web.dart';
import 'package:medicos/src/modules/anexos/anexos_page.dart';
import 'package:medicos/src/modules/benefits/benefits_page.dart';
import 'package:medicos/src/modules/convenio_medico/convenio_medico_page.dart';
import 'package:medicos/src/modules/directorio/directorio_page.dart';
import 'package:medicos/src/modules/evaluations/evaluations_page.dart';
import 'package:medicos/src/modules/formats/formats_page.dart';
import 'package:medicos/src/modules/payments/payments_page.dart';
import 'package:medicos/src/modules/procedures/procedures_page.dart';
import 'package:medicos/src/modules/solicitud_convenio_medico/solicitud_convenio_medico_page.dart';
import 'package:medicos/src/modules/tabuladores/tabuladores_page.dart';
import 'package:medicos/src/modules/welcome/widgets/modal_acept_terms.dart';
part 'welcome_model.dart';

class WelcomeController extends GetxController with StateMixin<_WelcomeModel> {
  final AppStateController appState = Get.find();
  String get jwt => appState.user.token.jwt;
  UserModel get user => appState.user;

  /// Side Menu
  PageController pageCtrler = PageController();
  SideMenuController sideMenuCtrler = SideMenuController();

  /// Menu completo: SideMenu + Pages
  List<Widget> bodyWithMenu = [];

  /// Control para expandir/colapsar el menu
  final Rx<SideMenuDisplayMode> menuDisplayMode = SideMenuDisplayMode.open.obs;

  /// Flags de visibilidad de modulos
  Map<String, dynamic> permisos = {};
  bool banConvenio = false;

  List<SideMenuItemType> itemsMenu = [];
  List<Widget> itemsPages = [];

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

    sideMenuCtrler.addListener((index) {
      pageCtrler.jumpToPage(index);
    });

    change(welcomeModel, status: RxStatus.success());
  }

  void _buildMenu() {
    itemsMenu.clear();
    itemsPages.clear();

    itemsMenu.add(
      SideMenuItem(
        title: 'Inicio',
        onTap: (index, _) => sideMenuCtrler.changePage(index),
        iconWidget: ImageFromWeb(
          imageName: 'icono_modulo_convenio_medico.png',
          jwt: jwt,
        ),
        tooltipContent: 'Inicio',
      ),
    );
    itemsPages.add(
      ColoredBox(
        color: Colors.amber.shade100,
        child: const Center(
          child: Text('Inicio Page'),
        ),
      ),
    );

    /// Menu Convenio Medico
    if ((permisos[ConvenioMedicoPage.page.name] ?? false) && banConvenio) {
      itemsMenu.add(
        SideMenuItem(
          title: 'Convenio Medico',
          onTap: (index, _) => sideMenuCtrler.changePage(index),
          iconWidget: ImageFromWeb(
            imageName: 'icono_modulo_convenio_medico.png',
            jwt: jwt,
          ),
          tooltipContent: 'Convenio Medico',
        ),
      );
      itemsPages.add(
        ColoredBox(
          color: Colors.amber.shade100,
          child: const Center(
            child: Text('Convenio MedicoPage'),
          ),
        ),
      );
    }

    /// Menu Tabuladores
    if ((permisos[TabuladoresPage.page.name] ?? false) && banConvenio) {
      itemsMenu.add(
        SideMenuItem(
          title: 'Tabuladores',
          onTap: (index, _) => sideMenuCtrler.changePage(index),
          iconWidget: ImageFromWeb(
            imageName: 'icono_modulo_tabuladores.png',
            jwt: jwt,
          ),
          tooltipContent: 'Tabuladores',
        ),
      );
      itemsPages.add(
        ColoredBox(
          color: Colors.amber.shade100,
          child: const Center(
            child: Text('Tabuladores Page'),
          ),
        ),
      );
    }

    /// Menu  Mis Pagos
    if (permisos[PaymentsPage.page.name] ?? false) {
      itemsMenu.add(
        SideMenuItem(
          title: 'Mis Pagos',
          onTap: (index, _) => sideMenuCtrler.changePage(index),
          iconWidget: ImageFromWeb(
            imageName: 'icono_modulo_mis_pagos.png',
            jwt: jwt,
          ),
          tooltipContent: 'Mis Pagos',
        ),
      );
      itemsPages.add(
        ColoredBox(
          color: Colors.amber.shade100,
          child: const Center(
            child: Text('Mis Pagos Page'),
          ),
        ),
      );
    }

    /// Menu Nueva solicitud
    if (permisos[SolicitudConvenioMedicoPage.page.name] ?? false) {
      itemsMenu.add(
        SideMenuItem(
          title: 'Solicitud convenio médico',
          onTap: (index, _) => sideMenuCtrler.changePage(index),
          iconWidget: ImageFromWeb(
            imageName: 'icono_modulo_solicitud_convenio_medico.png',
            jwt: jwt,
          ),
          tooltipContent: 'Solicitud convenio médico',
        ),
      );
      itemsPages.add(
        ColoredBox(
          color: Colors.amber.shade100,
          child: const Center(
            child: Text('Nueva solicitud Page'),
          ),
        ),
      );
    }

    /// Menu Mis Tramites
    if (permisos[ProceduresPage.page.name] ?? false) {
      itemsMenu.add(
        SideMenuItem(
          title: 'Mis Trámites',
          onTap: (index, _) => sideMenuCtrler.changePage(index),
          iconWidget: ImageFromWeb(
            imageName: 'icono_modulo_mis_tramites.png',
            jwt: jwt,
          ),
          tooltipContent: 'Mis Trámites',
        ),
      );
      itemsPages.add(
        ColoredBox(
          color: Colors.amber.shade100,
          child: const Center(
            child: Text('Mis Tramites Page'),
          ),
        ),
      );
    }

    /// Menu Beneficios
    if (permisos[BeneficiosPage.page.name] ?? false) {
      itemsMenu.add(
        SideMenuItem(
          title: 'Beneficios',
          onTap: (index, _) => sideMenuCtrler.changePage(index),
          iconWidget: ImageFromWeb(
            imageName: 'icono_modulo_beneficios.png',
            jwt: jwt,
          ),
          tooltipContent: 'Beneficios',
        ),
      );
      itemsPages.add(
        ColoredBox(
          color: Colors.amber.shade100,
          child: const Center(
            child: Text('Beneficios Page'),
          ),
        ),
      );
    }

    /// Menu Anexos
    if (permisos[AnexosPage.page.name] ?? false) {
      itemsMenu.add(
        SideMenuItem(
          title: 'Anexos',
          onTap: (index, _) => sideMenuCtrler.changePage(index),
          iconWidget: ImageFromWeb(
            imageName: 'icono_modulo_anexos.png',
            jwt: jwt,
          ),
          tooltipContent: 'Anexos',
        ),
      );
      itemsPages.add(
        ColoredBox(
          color: Colors.amber.shade100,
          child: const Center(
            child: Text('Anexos Page'),
          ),
        ),
      );
    }

    /// Menu Formatos
    if (permisos[FormatsPage.page.name] ?? false) {
      itemsMenu.add(
        SideMenuItem(
          title: 'Formatos',
          onTap: (index, _) => sideMenuCtrler.changePage(index),
          iconWidget: ImageFromWeb(
            imageName: 'icono_modulo_formatos.png',
            jwt: jwt,
          ),
          tooltipContent: 'Formatos',
        ),
      );
      itemsPages.add(
        ColoredBox(
          color: Colors.amber.shade100,
          child: const Center(
            child: Text('Formatos Page'),
          ),
        ),
      );
    }

    /// Menu Evaluación
    if (permisos[EvaluationsPage.page.name] ?? false) {
      itemsMenu.add(
        SideMenuItem(
          title: 'Evaluación',
          onTap: (index, _) => sideMenuCtrler.changePage(index),
          iconWidget: ImageFromWeb(
            imageName: 'icono_modulo_evaluacion.png',
            jwt: jwt,
          ),
          tooltipContent: 'Evaluación',
        ),
      );
      itemsPages.add(
        ColoredBox(
          color: Colors.amber.shade100,
          child: const Center(
            child: Text('Evaluación Page'),
          ),
        ),
      );
    }

    /// Menu Directorio Medico
    if (permisos[DirectorioPage.page.name] ?? false) {
      itemsMenu.add(
        SideMenuItem(
          title: 'Directorio médico',
          onTap: (index, _) => sideMenuCtrler.changePage(index),
          iconWidget: ImageFromWeb(
            imageName: 'icono_modulo_directorio_medico.png',
            jwt: jwt,
          ),
          tooltipContent: 'Directorio médico',
        ),
      );
      itemsPages.add(
        ColoredBox(
          color: Colors.amber.shade100,
          child: const Center(
            child: Text('Directorio Medico Page'),
          ),
        ),
      );
    }

    /// Menu Contacto GNP
    itemsMenu.add(
      SideMenuItem(
        title: 'Contacto GNP',
        onTap: (index, _) => sideMenuCtrler.changePage(index),
        iconWidget: ImageFromWeb(
          imageName: 'icono_modulo_contacto.png',
          jwt: jwt,
        ),
        tooltipContent: 'Contacto GNP',
      ),
    );
    itemsPages.add(
      ColoredBox(
        color: Colors.amber.shade100,
        child: const Center(
          child: Text('Contacto GNP Page'),
        ),
      ),
    );
  }

  void toggleMenu() {
    menuDisplayMode.value = menuDisplayMode.value == SideMenuDisplayMode.open
        ? SideMenuDisplayMode.compact
        : SideMenuDisplayMode.open;
  }

  void onDispose() {
    pageCtrler.dispose();
    sideMenuCtrler.dispose();
    super.onClose();
  }

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
