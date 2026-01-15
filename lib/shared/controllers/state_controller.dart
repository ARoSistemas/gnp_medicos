import 'package:get/get.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/widgets/wdgt_image_from_web.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/annexes/annexes_page.dart';
import 'package:medicos/src/modules/benefits/benefits_page.dart';
import 'package:medicos/src/modules/contact/contact_page.dart';
import 'package:medicos/src/modules/convenio_medico/convenio_medico_page.dart';
import 'package:medicos/src/modules/directory/directory_page.dart';
import 'package:medicos/src/modules/evaluations/evaluations_page.dart';
import 'package:medicos/src/modules/formats/formats_page.dart';
import 'package:medicos/src/modules/payments/payments_page.dart';
import 'package:medicos/src/modules/procedures/procedures_page.dart';
import 'package:medicos/src/modules/request_medical_agreement/request_medical_agreement_page.dart';
import 'package:medicos/src/modules/tabulators/tabulators_page.dart';
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

  /// Resets all state variables to their initial empty state.
  ///
  /// This is typically called during a sign-out process to clear the
  /// user's session data.
  void reset() {
    _user.value = UserModel.empty();
    _isDoctor.value = true;
    _userPermissions.value = {};
  }

  /// A list of menu items to be displayed in the web application's side menu.
  final List<ItemForMenuWeb> menuWebOk = <ItemForMenuWeb>[];

  /// Returns `true` when the desktop side menu is expanded.
  bool get isExpandedMenu => _isExpandedMenu.value;

  /// Toggles the expanded state of the desktop side menu.
  void toggleMenuExpansion() => _isExpandedMenu.toggle();

  void buildMenuWeb(
    String rootLabel,
    List<BreadcrumbWeb> breadcrumbs, {
    Map<String, ItemForMenuWeb Function(ItemForMenuWeb base)>? overrides,
  }) {
    final Map<String, ItemForMenuWeb Function(ItemForMenuWeb base)>
    effectiveOverrides =
        overrides ?? <String, ItemForMenuWeb Function(ItemForMenuWeb base)>{};

    final List<BreadcrumbWeb> rootTrail = breadcrumbs.isNotEmpty
        ? _cloneBreadcrumbs(breadcrumbs)
        : const <BreadcrumbWeb>[];

    final List<ItemForMenuWeb> builtItems = <ItemForMenuWeb>[];

    itemsMenuWeb.forEach((key, definition) {
      if (!_shouldIncludeMenuRoute(definition.route)) {
        return;
      }

      final bool isRoot = definition.route == WelcomePage.page.name;
      final String baseLabel = isRoot ? rootLabel : definition.label;

      final List<BreadcrumbWeb> itemBreadcrumbs =
          definition.breadcrumbs.isNotEmpty
          ? _cloneBreadcrumbs(definition.breadcrumbs)
          : _buildBreadcrumbsForModule(
              isRoot: isRoot,
              moduleLabel: baseLabel,
              rootLabel: rootLabel,
              rootTrail: rootTrail,
            );

      ItemForMenuWeb item = ItemForMenuWeb(
        label: baseLabel,
        route: definition.route,
        tooltip: baseLabel,
        icon: ImageFromWeb(
          imageName: definition.iconName,
          jwt: user.token.jwt,
        ),
        breadcrumbs: itemBreadcrumbs,
      );

      

      final ItemForMenuWeb Function(ItemForMenuWeb base)? transform =
          effectiveOverrides[key] ?? effectiveOverrides[definition.route];

      if (transform != null) {
        item = transform(item);
      }

      builtItems.add(item);
    });

    menuWebOk
      ..clear()
      ..addAll(builtItems);
  }

  bool _shouldIncludeMenuRoute(String route) {
    if (route == WelcomePage.page.name) {
      return true;
    }
    if (route == ConvenioMedicoPage.page.name ||
        route == TabuladoresPage.page.name ||
        route == BeneficiosPage.page.name ||
        route == ProceduresPage.page.name) {
      return _hasPermission(route) && user.banConvenioVigenteEstatus;
    }
    if (route == ContactPage.page.name) {
      return true;
    }
    return _hasPermission(route);
  }

  bool _hasPermission(String route) => userPermissions[route] == true;

  List<BreadcrumbWeb> _buildBreadcrumbsForModule({
    required bool isRoot,
    required String moduleLabel,
    required String rootLabel,
    required List<BreadcrumbWeb> rootTrail,
  }) {
    if (isRoot) {
      if (rootTrail.isNotEmpty) {
        return _cloneBreadcrumbs(rootTrail);
      }
      return List<BreadcrumbWeb>.unmodifiable(
        <BreadcrumbWeb>[BreadcrumbWeb(moduleLabel)],
      );
    }

    final List<BreadcrumbWeb> baseTrail = _normalizeRootTrail(
      rootTrail,
      rootLabel,
    )..add(BreadcrumbWeb(moduleLabel));

    return List<BreadcrumbWeb>.unmodifiable(baseTrail);
  }

  List<BreadcrumbWeb> _normalizeRootTrail(
    List<BreadcrumbWeb> rootTrail,
    String rootLabel,
  ) {
    if (rootTrail.isEmpty) {
      return <BreadcrumbWeb>[
        BreadcrumbWeb(msg.home.tr(), route: WelcomePage.page.name),
      ];
    }

    return rootTrail
        .map(
          (crumb) => BreadcrumbWeb(
            crumb.label,
            route:
                crumb.route ??
                (crumb.label == rootLabel ? WelcomePage.page.name : null),
          ),
        )
        .toList();
  }

  List<BreadcrumbWeb> _cloneBreadcrumbs(
    Iterable<BreadcrumbWeb> breadcrumbs,
  ) => List<BreadcrumbWeb>.unmodifiable(
    breadcrumbs.map(
      (crumb) => BreadcrumbWeb(crumb.label, route: crumb.route),
    ),
  );

  Map<String, MenuWebModule> get itemsMenuWeb => {
    msg.home.key: MenuWebModule(
      label: msg.home.tr(),
      route: WelcomePage.page.name,
      iconName: 'icono_modulo_inicio.png',
    ),
    msg.agreement.key: MenuWebModule(
      label: msg.agreement.tr(),
      route: ConvenioMedicoPage.page.name,
      iconName: 'icono_modulo_convenio_medico.png',
    ),
    msg.tabulator.key: MenuWebModule(
      label: msg.tabulator.tr(),
      route: TabuladoresPage.page.name,
      iconName: 'icono_modulo_tabuladores.png',
    ),
    msg.myPayments.key: MenuWebModule(
      label: msg.myPayments.tr(),
      route: PaymentsPage.page.name,
      iconName: 'icono_modulo_mis_pagos.png',
    ),
    'solicitudconveniomedico': MenuWebModule(
      label: 'Solicitud convenio médico',
      route: RequestMedicalAgreementPage.page.name,
      iconName: 'icono_modulo_solicitud_convenio_medico.png',
    ),
    msg.myProcedures.key: MenuWebModule(
      label: msg.myProcedures.tr(),
      route: ProceduresPage.page.name,
      iconName: 'icono_modulo_mis_tramites.png',
    ),
    msg.benefits.key: MenuWebModule(
      label: msg.benefits.tr(),
      route: BeneficiosPage.page.name,
      iconName: 'icono_modulo_beneficios.png',
    ),
    msg.annexes.key: MenuWebModule(
      label: msg.annexes.tr(),
      route: AnnexesPage.page.name,
      iconName: 'icono_modulo_anexos.png',
    ),
    msg.formats.key: MenuWebModule(
      label: msg.formats.tr(),
      route: FormatsPage.page.name,
      iconName: 'icono_modulo_formatos.png',
    ),
    msg.evaluations.key: MenuWebModule(
      label: msg.evaluations.tr(),
      route: EvaluationsPage.page.name,
      iconName: 'icono_modulo_evaluacion.png',
    ),
    msg.directory.key: MenuWebModule(
      label: msg.directory.tr(),
      route: DirectoryPage.page.name,
      iconName: 'icono_modulo_directorio_medico.png',
    ),
    msg.gnpContact.key: MenuWebModule(
      label: msg.gnpContact.tr(),
      route: ContactPage.page.name,
      iconName: 'icono_modulo_contacto.png',
    ),
  };
}
