import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/wdgt_image_from_web.dart';

/// Data required to render a breadcrumb node inside [MenuWeb].
class MenuWebBreadcrumb {
  const MenuWebBreadcrumb(this.label, {this.route});

  final String label;
  final String? route;
}

/// Represents a single item displayed in the [MenuWeb] sidebar.
class MenuWebItem {
  const MenuWebItem({
    required this.label,
    required this.icon,
    this.route,
    this.tooltip,
    this.routeAliases = const <String>[],
    this.includeChildRoutes = true,
    this.breadcrumbs = const <MenuWebBreadcrumb>[],
    this.onTap,
    this.replaceRoute = true,
    this.isEnabled = true,
  });

  final String label;
  final String? route;
  final Widget icon;
  final String? tooltip;
  final List<String> routeAliases;
  final bool includeChildRoutes;
  final List<MenuWebBreadcrumb> breadcrumbs;
  final VoidCallback? onTap;
  final bool replaceRoute;
  final bool isEnabled;

  /// Returns a new instance with the provided values overridden.
  MenuWebItem copyWith({
    String? label,
    String? route,
    Widget? icon,
    String? tooltip,
    List<String>? routeAliases,
    bool? includeChildRoutes,
    List<MenuWebBreadcrumb>? breadcrumbs,
    VoidCallback? onTap,
    bool? replaceRoute,
    bool? isEnabled,
  }) => MenuWebItem(
    label: label ?? this.label,
    route: route ?? this.route,
    icon: icon ?? this.icon,
    tooltip: tooltip ?? this.tooltip,
    routeAliases: routeAliases != null
        ? _cloneList<String>(routeAliases)
        : _cloneList<String>(this.routeAliases),
    includeChildRoutes: includeChildRoutes ?? this.includeChildRoutes,
    breadcrumbs: breadcrumbs != null
        ? _cloneList<MenuWebBreadcrumb>(breadcrumbs)
        : _cloneList<MenuWebBreadcrumb>(this.breadcrumbs),
    onTap: onTap ?? this.onTap,
    replaceRoute: replaceRoute ?? this.replaceRoute,
    isEnabled: isEnabled ?? this.isEnabled,
  );

  static List<T> _cloneList<T>(List<T> source) =>
      List<T>.unmodifiable(List<T>.from(source));

  bool matchesRoute(String currentRoute) {
    if (route != null && _matchesValue(route!, currentRoute)) {
      return true;
    }
    for (final String alias in routeAliases) {
      if (_matchesValue(alias, currentRoute)) {
        return true;
      }
    }
    return false;
  }

  bool _matchesValue(String value, String currentRoute) {
    if (currentRoute == value) {
      return true;
    }
    if (includeChildRoutes && currentRoute.startsWith('$value/')) {
      return true;
    }
    return false;
  }
}

/// A reusable desktop layout that renders a collapsible sidebar menu,
/// breadcrumb trail, and a top bar with the GNP branding.
class MenuWeb extends StatelessWidget {
  const MenuWeb({
    required this.child,
    required this.menuItems,
    this.breadcrumbs,
    this.logoAssetPath = 'assets/logo-gnp.png',
    this.expandedWidth = 280,
    this.collapsedWidth = 90,
    this.topBarActions = const <Widget>[],
    this.contentBackgroundColor,
    super.key,
  });

  final Widget child;
  final List<MenuWebItem> menuItems;
  final List<MenuWebBreadcrumb>? breadcrumbs;
  final String logoAssetPath;
  final double expandedWidth;
  final double collapsedWidth;
  final List<Widget> topBarActions;
  final Color? contentBackgroundColor;

  AppStateController get _appState => Get.find<AppStateController>();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String currentRoute = Get.currentRoute;
    final List<MenuWebBreadcrumb> effectiveBreadcrumbs = _resolveBreadcrumbs(
      currentRoute,
    );

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          /// Barra superior con el logo y acciones.
          Obx(
            () => _TopBar(
              logoAssetPath: logoAssetPath,
              actions: topBarActions,
              onToggleMenu: _appState.toggleMenuExpansion,
              isExpandedMenu: _appState.isExpandedMenu,
            ),
          ),

          /// Contenido principal con el menú lateral y el área de contenido.
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                /// Menú lateral
                Obx(
                  () {
                    final bool isExpanded = _appState.isExpandedMenu;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      width: isExpanded ? expandedWidth : collapsedWidth,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: theme.shadowColor.withValues(alpha: 0.1),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        itemCount: menuItems.length,
                        itemBuilder: (_, index) {
                          final MenuWebItem item = menuItems[index];
                          final bool isActive = item.matchesRoute(
                            currentRoute,
                          );
                          return _MenuTile(
                            item: item,
                            isActive: isActive,
                            isExpanded: isExpanded,
                            onTap: () => _handleItemTap(
                              item,
                              currentRoute,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),

                /// Área de contenido principal
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      /// Los breadcrumbs
                      if (effectiveBreadcrumbs.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 24,
                            top: 16,
                            right: 24,
                            bottom: 16,
                          ),
                          child: _BreadcrumbRow(
                            breadcrumbs: effectiveBreadcrumbs,
                          ),
                        ),

                      /// El widget hijo que contiene el contenido principal
                      Expanded(
                        child: child,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleItemTap(MenuWebItem item, String currentRoute) async {
    if (!item.isEnabled) {
      return;
    }
    if (item.onTap != null) {
      item.onTap!();
      return;
    }
    final String? targetRoute = item.route;
    if (targetRoute == null || item.matchesRoute(currentRoute)) {
      return;
    }

    if (item.replaceRoute) {
      await Get.offNamed(targetRoute);
    } else {
      await Get.toNamed(targetRoute);
    }
  }

  List<MenuWebBreadcrumb> _resolveBreadcrumbs(String currentRoute) {
    if (breadcrumbs != null && breadcrumbs!.isNotEmpty) {
      return breadcrumbs!;
    }
    for (final MenuWebItem item in menuItems) {
      if (item.matchesRoute(currentRoute)) {
        return item.breadcrumbs;
      }
    }
    return const <MenuWebBreadcrumb>[];
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IterableProperty<MenuWebItem>('menuItems', menuItems))
      ..add(
        IterableProperty<MenuWebBreadcrumb>('breadcrumbs', breadcrumbs),
      )
      ..add(StringProperty('logoAssetPath', logoAssetPath))
      ..add(DoubleProperty('expandedWidth', expandedWidth))
      ..add(DoubleProperty('collapsedWidth', collapsedWidth))
      ..add(
        ColorProperty('contentBackgroundColor', contentBackgroundColor),
      );
  }
}

/// El appbar superior que contiene el logo y las acciones.
class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.logoAssetPath,
    required this.actions,
    required this.onToggleMenu,
    required this.isExpandedMenu,
  });

  final String logoAssetPath;
  final List<Widget> actions;
  final VoidCallback onToggleMenu;
  final bool isExpandedMenu;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(color: Colors.blue),
        ),
        color: theme.colorScheme.surface,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              onPressed: onToggleMenu,
              icon: const Icon(
                Icons.menu,
                color: ColorPalette.primary,
              ),
              // isExpandedMenu ? Icons.menu_open : Icons.menu,
              tooltip: isExpandedMenu ? 'Contraer menú' : 'Expandir menú',
            ),
          ),
          const SizedBox(width: 16),
          Image.asset(
            logoAssetPath,
            height: 48,
            fit: BoxFit.contain,
          ),
          const Spacer(),
          ...actions,
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('logoAssetPath', logoAssetPath))
      ..add(
        ObjectFlagProperty<VoidCallback>.has('onToggleMenu', onToggleMenu),
      )
      ..add(DiagnosticsProperty<bool>('isExpandedMenu', isExpandedMenu));
  }
}

/// Fila de breadcrumbs que muestra la ruta de navegación actual.
class _BreadcrumbRow extends StatelessWidget {
  const _BreadcrumbRow({required this.breadcrumbs});

  final List<MenuWebBreadcrumb> breadcrumbs;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle baseStyle = theme.textTheme.bodyMedium!.copyWith(
      color: ColorPalette.primary,
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            for (int index = 0; index < breadcrumbs.length; index++) ...[
              if (index > 0)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.chevron_right,
                    size: 18,
                    color: Colors.grey.shade300,
                  ),
                ),
              _BreadcrumbLabel(
                breadcrumb: breadcrumbs[index],
                style: baseStyle,
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      IterableProperty<MenuWebBreadcrumb>('breadcrumbs', breadcrumbs),
    );
  }
}

/// Los items de cada breadcrumb individual.
class _BreadcrumbLabel extends StatelessWidget {
  const _BreadcrumbLabel({
    required this.breadcrumb,
    required this.style,
  });

  final MenuWebBreadcrumb breadcrumb;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final TextStyle activeStyle = style.copyWith(
      fontWeight: FontWeight.w600,
      color: ColorPalette.textPrimary,
    );

    if (breadcrumb.route == null) {
      return Text(
        breadcrumb.label,
        style: breadcrumb.label == 'Inicio' ? style : activeStyle,
      );
    }
    return InkWell(
      onTap: () async {
        await Get.offNamed(breadcrumb.route!);
      },
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Text(
          breadcrumb.label,
          style: style,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        DiagnosticsProperty<MenuWebBreadcrumb>('breadcrumb', breadcrumb),
      )
      ..add(DiagnosticsProperty<TextStyle>('style', style));
  }
}

/// Tile individual del menú lateral.
class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.item,
    required this.isActive,
    required this.isExpanded,
    required this.onTap,
  });

  final MenuWebItem item;
  final bool isActive;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Color highlightColor = ColorPalette.primary.withValues(
      alpha: isActive ? 0.16 : 0.1,
    );

    final TextStyle labelStyle = theme.textTheme.bodyMedium!.copyWith(
      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
      color: isActive
          ? ColorPalette.primary
          : theme.colorScheme.onSurface.withValues(
              alpha: item.isEnabled ? 0.8 : 0.4,
            ),
    );

    Widget tile = Material(
      color: isActive ? highlightColor : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: item.isEnabled ? onTap : null,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          child: Row(
            children: <Widget>[
              // Container(
              //   width: 4,
              //   height: 40,
              //   decoration: BoxDecoration(
              //     color: ColorPalette.primary,
              //     borderRadius: BorderRadius.circular(2),
              //   ),
              // )
              // else
              // if (!isActive) const SizedBox(width: 4),
              // const SizedBox(width: 12),
              SizedBox(
                height: 32,
                width: 32,
                child: Center(child: item.icon),
              ),
              if (isExpanded) ...[
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: labelStyle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );

    if (!isExpanded) {
      tile = Tooltip(
        message: item.tooltip ?? item.label,
        child: tile,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: tile,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<MenuWebItem>('item', item))
      ..add(DiagnosticsProperty<bool>('isActive', isActive))
      ..add(DiagnosticsProperty<bool>('isExpanded', isExpanded))
      ..add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap));
  }
}

/// Custom transition that keeps the slide animation on narrow screens
/// (phones) but removes it on wider layouts such as tablet or desktop.
class MenuWebAdaptiveTransition extends CustomTransition {
  MenuWebAdaptiveTransition();

  bool _shouldAnimate(BuildContext context) {
    final MediaQueryData? mediaQuery = MediaQuery.maybeOf(context);
    if (mediaQuery == null) {
      return !(kIsWeb || GetPlatform.isDesktop);
    }
    return mediaQuery.size.width < 900;
  }

  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (!_shouldAnimate(context)) {
      return child;
    }

    final Animation<double> curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve ?? Curves.linear,
    );

    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(curvedAnimation),
      child: child,
    );
  }
}

class MenuWebModule {
  const MenuWebModule({
    required this.label,
    required this.route,
    required this.iconName,
    this.breadcrumbs = const <MenuWebBreadcrumb>[],
  });

  final String label;
  final String route;
  final String iconName;
  final List<MenuWebBreadcrumb> breadcrumbs;

  MenuWebModule copyWith({
    String? label,
    String? route,
    String? iconName,
    List<MenuWebBreadcrumb>? breadcrumbs,
  }) => MenuWebModule(
    label: label ?? this.label,
    route: route ?? this.route,
    iconName: iconName ?? this.iconName,
    breadcrumbs: breadcrumbs ?? this.breadcrumbs,
  );

  MenuWebItem toMenuItem(String jwt) => MenuWebItem(
    label: label,
    route: route,
    tooltip: label,
    icon: ImageFromWeb(imageName: iconName, jwt: jwt),
    breadcrumbs: breadcrumbs,
  );
}

// class MenuWebDefinition {
//   const MenuWebDefinition({
//     required this.label,
//     required this.route,
//     required this.iconName,
//     this.breadcrumbs = const <MenuWebBreadcrumb>[],
//   });

//   final String label;
//   final String route;
//   final String iconName;
//   final List<MenuWebBreadcrumb> breadcrumbs;

//   MenuWebDefinition copyWith({
//     String? label,
//     String? route,
//     String? iconName,
//     List<MenuWebBreadcrumb>? breadcrumbs,
//   }) => MenuWebDefinition(
//     label: label ?? this.label,
//     route: route ?? this.route,
//     iconName: iconName ?? this.iconName,
//     breadcrumbs: breadcrumbs != null
//         ? List<MenuWebBreadcrumb>.unmodifiable(breadcrumbs)
//         : List<MenuWebBreadcrumb>.unmodifiable(this.breadcrumbs),
//   );
// }
