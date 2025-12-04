import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

/// Data required to render a breadcrumb node inside [MenuWeb].
class MenuWebBreadcrumb {
  const MenuWebBreadcrumb(this.label, {this.route});

  final String label;
  final String? route;

  MenuWebBreadcrumb copyWith({
    String? label,
    String? route,
  }) => MenuWebBreadcrumb(
    label ?? this.label,
    route: route ?? this.route,
  );
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
          Obx(
            () => _TopBar(
              logoAssetPath: logoAssetPath,
              actions: topBarActions,
              onToggleMenu: _appState.toggleMenuExpansion,
              isExpandedMenu: _appState.isExpandedMenu,
            ),
          ),
          if (effectiveBreadcrumbs.isNotEmpty)
            Obx(
              () {
                final bool isExpanded = _appState.isExpandedMenu;
                final double menuWidth = isExpanded
                    ? expandedWidth
                    : collapsedWidth;
                return Container(
                  color: theme.colorScheme.surface,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: menuWidth),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: _BreadcrumbRow(
                            breadcrumbs: effectiveBreadcrumbs,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const SizedBox(height: 12),
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
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
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    );
                  },
                ),
                Expanded(
                  child: ColoredBox(
                    color:
                        contentBackgroundColor ??
                        theme.colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.2,
                        ),
                    child: child,
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

class _BreadcrumbRow extends StatelessWidget {
  const _BreadcrumbRow({required this.breadcrumbs});

  final List<MenuWebBreadcrumb> breadcrumbs;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle baseStyle = theme.textTheme.bodyMedium!.copyWith(
      color: ColorPalette.primary,
    );
    return Row(
      children: <Widget>[
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
