part of '../welcome_page.dart';

class _WelcomeDesktopPage extends StatelessWidget {
  _WelcomeDesktopPage();

  final WelcomeController _c = Get.find<WelcomeController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: 32,
        horizontal: context.pWidth(8),
      ),
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
                    msg.goodDay.tr(
                      args: [_c.user.nombreCompleto.trim().split(' ').first],
                    ),
                    style: Get.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: context.fontSize(18),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    msg.welcomeMessageBody.tr(),
                    style: Get.textTheme.titleMedium,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: ColorPalette.backgroundCardTwo,
                  ),
                  child: Text(
                    msg.welcomeMessageFooter.tr(),
                    style: Get.textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 40),
          Expanded(
            child: ImageFromWeb(
              height: 329,
              width: double.infinity,
              imageName: 'imagen_inicio_bienvenida.png',
              jwt: _c.user.token.jwt,
            ),
          ),
        ],
      ),
    ),
  );
}
