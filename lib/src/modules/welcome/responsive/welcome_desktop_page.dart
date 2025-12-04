part of '../welcome_page.dart';

class _WelcomeDesktopPage extends StatelessWidget {
  const _WelcomeDesktopPage();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Bienvenido',
                  style: theme.textTheme.headlineMedium,
                ),
                const SizedBox(height: 12),
                Text(
                  'Selecciona una opción del menú lateral para comenzar.',
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
    );
  }
}
