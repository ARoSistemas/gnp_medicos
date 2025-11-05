part of '../welcome_page.dart';

class _WelcomePhonePage extends StatelessWidget {
  _WelcomePhonePage();

  final WelcomeController _c = Get.find<WelcomeController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppbarWelcomePhone(nombre: _c.user.nombreCompleto),
    drawer: DrawerPhone(
      jwt: _c.jwt,
      permisos: _c.appState.userPermissions,
      banConvenio: _c.appState.user.banVerConvenio,
      version: _c.appState.version,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            thickness: 1.5,
            color: ColorPalette.textPrimary,
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              '''¡Buen día, ${_c.user.nombreCompleto.split(' ').first} !''',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: context.fontSize(18),
              ),
            ),
          ),

          ImageFromWeb(
            height: 300,
            width: double.infinity,
            borderRadius: BorderRadius.circular(10),
            imageName: 'imagen_inicio_bienvenida.png',
            jwt: _c.user.token.jwt,
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Text(
              '''Eres un pilar fundamental para GNP Seguros, gracias a tu compromiso y gran vocación de servicio, hemos respaldado y brindado tranquilidad a las familias mexicanas cuando más lo necesitan, por ello, queremos seguir haciendo equipo contigo y brindarte las herramientas que optimicen tus tiempos administrativos.''',
              style: context.textTheme.titleMedium,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: ColorPalette.backgroundCardTwo,
              ),
              child: Text(
                '''Ser aliados de nuestros médicos en convenio, y también de quienes no lo son, manteniéndonos comprometidos con la recuperación de la salud de los pacientes mientras cumplimos con los indicadores de eficiencia y servicio de GNP.''',
                style: context.textTheme.titleMedium,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
