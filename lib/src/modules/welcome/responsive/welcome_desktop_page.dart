part of '../welcome_page.dart';

class _WelcomeDesktopPage extends StatelessWidget {
  _WelcomeDesktopPage();

  final WelcomeController _c = Get.find<WelcomeController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: 32, horizontal: MediaQuery.of(context).size.width * .15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    '''¡Buen día, ${_c.user.nombreCompleto.trim().split(' ').first}!''',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: context.fontSize(18),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    '''Eres un pilar fundamental para GNP Seguros, gracias a tu compromiso y gran vocación de servicio, hemos respaldado y brindado tranquilidad a las familias mexicanas cuando más lo necesitan, por ello, queremos seguir haciendo equipo contigo y brindarte las herramientas que optimicen tus tiempos administrativos.''',
                    style: context.textTheme.titleMedium,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: ColorPalette.backgroundCardTwo,
                  ),
                  child: Text(
                    '''Ser aliados de nuestros médicos en convenio, y también de quienes no lo son, manteniéndonos comprometidos con la recuperación de la salud de los pacientes mientras cumplimos con los indicadores de eficiencia y servicio de GNP.''',
                    style: context.textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 40),
          Expanded(
            child: ImageFromWeb(
              height: 300,
              width: double.infinity,
              borderRadius: BorderRadius.circular(10),
              imageName: 'imagen_inicio_bienvenida.png',
              jwt: _c.user.token.jwt,
            ),
          ),
        ],
      ),
    ),
  );
}
