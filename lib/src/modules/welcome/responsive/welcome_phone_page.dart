part of '../welcome_page.dart';

class _WelcomePhonePage extends StatelessWidget {
  _WelcomePhonePage();

  final WelcomeController _c = Get.find<WelcomeController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppbarWelcomePhone(
      name: _c.user.nombreCompleto,
      lastname: _c.user.apePaterno,
      rfc: _c.user.rfc,
      jwt: _c.user.token.jwt,
    ),
    drawer: DrawerPhone(
      jwt: _c.jwt,
      permisos: _c.appState.userPermissions,
      banConvenio: _c.appState.user.banConvenioVigenteEstatus,
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
              msg.goodDay.tr(
                args: [_c.user.nombreCompleto.trim().split(' ').first],
              ),
              style: Get.textTheme.titleMedium?.copyWith(
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
              msg.welcomeMessageBody.tr(),
              style: Get.textTheme.titleMedium,
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
                msg.welcomeMessageFooter.tr(),
                style: Get.textTheme.titleMedium,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
