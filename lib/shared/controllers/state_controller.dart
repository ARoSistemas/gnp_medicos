import 'package:get/get.dart';
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

/// A GetX controller that manages the global application state.
///
/// This class holds essential user-related data that needs to be accessible
/// throughout the app, such as the authenticated user's profile, their role,
/// and their specific permissions for different parts of the application.
/// It is intended to be a single source of truth for the user's session state.
class AppStateController extends GetxController {
  final Rx<UserModel> _user = UserModel.empty().obs;
  final Rx<UserModel> _userLogued = UserModel.empty().obs;
  final Rx<bool> _isDoctor = true.obs;
  final RxMap<String, dynamic> _userPermissions = <String, dynamic>{}.obs;
  final Rx<String> _version = ''.obs;

  final RxBool _isExpandedMenu = true.obs;
  /// *******************************************************
  /// Setters
  /// *******************************************************

  /// Sets the user's permissions map.
  set userPermissions(Map<String, dynamic> newPermisosMap) =>
      _userPermissions.value = newPermisosMap;

  /// Sets the currently authenticated user model.
  set user(UserModel newUser) => _user.value = newUser;

  set userLogued(UserModel newUser) => _userLogued.value = newUser;

  /// Sets whether the current user has a doctor role.
  set isDoctor(bool value) => _isDoctor.value = value;

  set version(String value) => _version.value = value;

  /// Sets whether the desktop side menu is currently expanded.
  set isExpandedMenu(bool value) => _isExpandedMenu.value = value;

  final List<MenuWebItem> menuItems = <MenuWebItem>[];

  /// *******************************************************
  /// Getters
  /// *******************************************************

  /// The currently authenticated user's data.
  UserModel get user => _user.value;

  UserModel get userLogued => _userLogued.value;

  /// Returns `true` if the user is a doctor, `false` otherwise.
  bool get isDoctor => _isDoctor.value;

  /// Returns `true` if the user's JWT is empty.
  ///
  /// **Note:** The logic for this getter is inverted. It returns `true` when
  /// the user is effectively logged out (i.e., has no token).
  bool get isLoggedIn => _user.value.token.jwt.isEmpty;

  /// A map containing the user's permissions, where keys are feature/page
  /// names and values determine access.
  Map<String, dynamic> get userPermissions => _userPermissions;

  String get version => _version.value;

  /// Returns `true` when the desktop side menu is expanded.
  bool get isExpandedMenu => _isExpandedMenu.value;

  /// Toggles the expanded state of the desktop side menu.
  void toggleMenuExpansion() => _isExpandedMenu.toggle();

  /// Resets all state variables to their initial empty state.
  ///
  /// This is typically called during a sign-out process to clear the
  /// user's session data.
  void reset() {
    _user.value = UserModel.empty();
    _isDoctor.value = true;
    _userPermissions.value = {};
    _isExpandedMenu.value = true;
  }

  void buildMenuWeb(
    String rootLabel,
    List<MenuWebBreadcrumb> breadcrumbs, {
    Map<String, MenuWebItem Function(MenuWebItem base)>? overrides,
  }) {
    final Map<String, MenuWebItem Function(MenuWebItem base)>
    effectiveOverrides =
        overrides ?? <String, MenuWebItem Function(MenuWebItem base)>{};

    final List<MenuWebBreadcrumb> rootTrail = breadcrumbs.isNotEmpty
        ? _cloneBreadcrumbs(breadcrumbs)
        : const <MenuWebBreadcrumb>[];

    final List<MenuWebItem> builtItems = <MenuWebItem>[];

    itemsMenuWeb.forEach((key, definition) {
      if (!_shouldIncludeMenuRoute(definition.route)) {
        return;
      }

      final bool isRoot = definition.route == WelcomePage.page.name;
      final String baseLabel = isRoot ? rootLabel : definition.label;

      final List<MenuWebBreadcrumb> itemBreadcrumbs =
          definition.breadcrumbs.isNotEmpty
          ? _cloneBreadcrumbs(definition.breadcrumbs)
          : _buildBreadcrumbsForModule(
              isRoot: isRoot,
              moduleLabel: baseLabel,
              rootLabel: rootLabel,
              rootTrail: rootTrail,
            );

      MenuWebItem item = MenuWebItem(
        label: baseLabel,
        route: definition.route,
        tooltip: baseLabel,
        icon: ImageFromWeb(
          imageName: definition.iconName,
          jwt: user.token.jwt,
        ),
        breadcrumbs: itemBreadcrumbs,
      );

      final MenuWebItem Function(MenuWebItem base)? transform =
          effectiveOverrides[key] ?? effectiveOverrides[definition.route];
      if (transform != null) {
        item = transform(item);
      }

      builtItems.add(item);
    });

    menuItems
      ..clear()
      ..addAll(builtItems);
  }

  bool _shouldIncludeMenuRoute(String route) {
    if (route == WelcomePage.page.name) {
      return true;
    }
    if (route == ConvenioMedicoPage.page.name ||
        route == TabuladoresPage.page.name) {
      return _hasPermission(route) && user.banConvenioVigente;
    }
    if (route == ContactoPage.page.name) {
      return true;
    }
    return _hasPermission(route);
  }

  bool _hasPermission(String route) => userPermissions[route] == true;

  List<MenuWebBreadcrumb> _buildBreadcrumbsForModule({
    required bool isRoot,
    required String moduleLabel,
    required String rootLabel,
    required List<MenuWebBreadcrumb> rootTrail,
  }) {
    if (isRoot) {
      if (rootTrail.isNotEmpty) {
        return _cloneBreadcrumbs(rootTrail);
      }
      return List<MenuWebBreadcrumb>.unmodifiable(
        <MenuWebBreadcrumb>[MenuWebBreadcrumb(moduleLabel)],
      );
    }

    final List<MenuWebBreadcrumb> baseTrail = _normalizeRootTrail(
      rootTrail,
      rootLabel,
    )..add(MenuWebBreadcrumb(moduleLabel));

    return List<MenuWebBreadcrumb>.unmodifiable(baseTrail);
  }

  List<MenuWebBreadcrumb> _normalizeRootTrail(
    List<MenuWebBreadcrumb> rootTrail,
    String rootLabel,
  ) {
    if (rootTrail.isEmpty) {
      return <MenuWebBreadcrumb>[
        MenuWebBreadcrumb(rootLabel, route: WelcomePage.page.name),
      ];
    }

    return rootTrail
        .map(
          (crumb) => MenuWebBreadcrumb(
            crumb.label,
            route:
                crumb.route ??
                (crumb.label == rootLabel ? WelcomePage.page.name : null),
          ),
        )
        .toList();
  }

  List<MenuWebBreadcrumb> _cloneBreadcrumbs(
    Iterable<MenuWebBreadcrumb> breadcrumbs,
  ) => List<MenuWebBreadcrumb>.unmodifiable(
    breadcrumbs.map(
      (crumb) => MenuWebBreadcrumb(crumb.label, route: crumb.route),
    ),
  );

  Map<String, MenuWebModule> get itemsMenuWeb {
    /// Menus fijos
    final Map<String, MenuWebModule> items = <String, MenuWebModule>{
      'inicio': MenuWebModule(
        label: 'Inicio',
        route: WelcomePage.page.name,
        iconName: 'icono_modulo_convenio_medico.png',
      ),
    };

    /// Menus condicionales
    if ((userPermissions[ConvenioMedicoPage.page.name] ?? false) &&
        user.banConvenioVigente) {
      items['convenio'] = MenuWebModule(
        label: 'Convenio Médico',
        route: ConvenioMedicoPage.page.name,
        iconName: 'icono_modulo_convenio_medico.png',
      );
    }
    if ((userPermissions[TabuladoresPage.page.name] ?? false) &&
        user.banConvenioVigente) {
      items['tabuladores'] = MenuWebModule(
        label: 'Tabuladores',
        route: TabuladoresPage.page.name,
        iconName: 'icono_modulo_tabuladores.png',
      );
    }
    if (userPermissions[PaymentsPage.page.name] ?? false) {
      items['mispagos'] = MenuWebModule(
        label: 'Mis Pagos',
        route: PaymentsPage.page.name,
        iconName: 'icono_modulo_mis_pagos.png',
      );
    }
    if (userPermissions[PaymentsPage.page.name] ?? false) {
      items['solicitudconveniomedico'] = MenuWebModule(
        label: 'Solicitud convenio médico',
        route: SolicitudConvenioMedicoPage.page.name,
        iconName: 'icono_modulo_solicitud_convenio_medico.png',
      );
    }
    if (userPermissions[ProceduresPage.page.name] ?? false) {
      items['mistramites'] = MenuWebModule(
        label: 'Mis Trámites',
        route: ProceduresPage.page.name,
        iconName: 'icono_modulo_mis_tramites.png',
      );
    }
    if (userPermissions[BeneficiosPage.page.name] ?? false) {
      items['beneficios'] = MenuWebModule(
        label: 'Beneficios',
        route: BeneficiosPage.page.name,
        iconName: 'icono_modulo_beneficios.png',
      );
    }
    if (userPermissions[AnexosPage.page.name] ?? false) {
      items['anexos'] = MenuWebModule(
        label: 'Anexos',
        route: AnexosPage.page.name,
        iconName: 'icono_modulo_anexos.png',
      );
    }
    if (userPermissions[FormatsPage.page.name] ?? false) {
      items['formatos'] = MenuWebModule(
        label: 'Formatos',
        route: FormatsPage.page.name,
        iconName: 'icono_modulo_formatos.png',
      );
    }
    if (userPermissions[EvaluationsPage.page.name] ?? false) {
      items['evaluacion'] = MenuWebModule(
        label: 'Evaluación',
        route: EvaluationsPage.page.name,
        iconName: 'icono_modulo_evaluacion.png',
      );
    }
    if (userPermissions[EvaluationsPage.page.name] ?? false) {
      items['directorio'] = MenuWebModule(
        label: 'Directorio médico',
        route: DirectorioPage.page.name,
        iconName: 'icono_modulo_directorio_medico.png',
      );
    }

    items['contacto'] = MenuWebModule(
      label: 'Contacto GNP',
      route: ContactoPage.page.name,
      iconName: 'icono_modulo_contacto.png',
    );
    return items;
  }

  // List<MenuWebBreadcrumb> _buildBreadcrumbs(String label) => [
  //   MenuWebBreadcrumb('Inicio', route: WelcomePage.page.name),
  //   MenuWebBreadcrumb(label),
  // ];
}
