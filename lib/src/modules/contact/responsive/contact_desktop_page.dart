part of '../contact_page.dart';

class _ContactDesktopPage extends StatelessWidget {
  _ContactDesktopPage();

  final ContactController _c = Get.find<ContactController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarWeb(title: msg.gnpContact.tr()),
    body: _c.obx(
      (state) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            spacing: 48,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: context.pWidth(35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Conecta con nosotros',
                      style: Get.textTheme.headlineSmall?.copyWith(
                        color: ColorPalette.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
              'Estamos a un mensaje de distancia. Síguenos en nuestras redes '
              'sociales para mantenerte al día, resolver dudas o ponerte en '
              'contacto directamente con nuestro equipo.',
                      style: Get.textTheme.bodyLarge?.copyWith(
                        color: ColorPalette.textSecondary,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),
          
                    Center(
                      child: ImageFromWeb(
                        height: 400,
                        width: 400,
                        imageName: 'imagen_contactanos_app.png',
                        jwt: _c.jwt,
                      ),
                    ),
                  ],
                ),
              ),
          
              /// Right Column
              SizedBox(
                width: context.pWidth(35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _contactItem(
                      title: msg.webSite.tr(),
                      value: 'gnp.com.mx',
                      isLink: true,
                      onTap: _c.items[0].onTap,
                    ),
                    const SizedBox(height: 20),
                    _contactItem(
                      title: msg.gnpLine.tr(),
                      value: '5552279000',
                      isLink: true,
                      onTap: _c.items[1].onTap,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'REDES SOCIALES',
                      style: Get.textTheme.titleMedium?.copyWith(
                        color: ColorPalette.textPrimary,
                        fontSize: 16,
                      ),
                    ),
                    const Divider(color: ColorPalette.primary),
                    const SizedBox(height: 20),
                    _socialMediaItem(
                      icon: 'icono_contactanos_facebook.png',
                      handle: '@GNPSeguros',
                      onTap: () => _c.launchWeb(_c.redes!['facebook']),
                    ),
                    const SizedBox(height: 15),
                    _socialMediaItem(
                      icon: 'icono_contactanos_instagram.png',
                      handle: '@GNPSeguros',
                      onTap: () => _c.launchWeb(_c.redes!['instagram']),
                    ),
                    const SizedBox(height: 15),
                    _socialMediaItem(
                      icon: 'icono_contactanos_x.png',
                      handle: '@gnpseguros',
                      onTap: () => _c.launchWeb(_c.redes!['x']),
                    ),
                    const SizedBox(height: 30),
                    _socialMediaItem(
                      icon: 'icono_contactanos_mail.png',
                      handle: msg.reTabulationsTitle.tr(),
                      onTap: () => _c.launchEmail(
                        (_c.contacto!['aclaraciones'] as Map)['correo'],
                        subject: msg.reTabulationsTitle.tr(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _socialMediaItem(
                      icon: 'icono_contactanos_mail.png',
                      handle: msg.bankingInfoTitle.tr(),
                      onTap: () => _c.launchEmail(
                      (_c.contacto!['informacionBancaria'] as Map)['correo'],
                      subject: msg.bankingInfoTitle.tr(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _socialMediaItem(
                      icon: 'icono_contactanos_phone.png',
                      handle: msg.personalizedAssistanceTitle.tr(),
                      onTap: () => _c.launchPhoneContact(
                        (_c.contacto!['asistenciaPersonalizada']
                            as Map)['telefono'],
                      ),
                    ),
                  ],
                ),
              ),
            
            ],
          ),
        ),
      ),
      onLoading: const Center(child: LoadingGnp()),
      onError: (_) => Center(
        child: LoadingGnp(
          isError: true,
          title: msg.errorLoadingContact.tr(),
          subtitle: msg.pleaseTryAgainLater.tr(),
        ),
      ),
    ),
  );

  Widget _contactItem({
    required String title,
    required String value,
    required bool isLink,
    required VoidCallback onTap,
  }) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: Get.textTheme.titleMedium?.copyWith(
          color: ColorPalette.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
      InkWell(
        onTap: onTap,
        child: Text(
          value,
          style: Get.textTheme.titleMedium?.copyWith(
            color: ColorPalette.primary,
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.underline,
            decorationColor: ColorPalette.primary,
          ),
        ),
      ),
    ],
  );

  Widget _socialMediaItem({
    required String icon,
    required String handle,
    required VoidCallback onTap,
  }) => InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorPalette.borderCardFormat),
      ),
      child: Row(
        children: [
          ImageFromWeb(
            height: 30,
            width: 30,
            imageName: icon,
            jwt: _c.jwt,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              handle,
              style: Get.textTheme.titleMedium?.copyWith(
                color: ColorPalette.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: ColorPalette.primary,
            size: 18,
          ),
        ],
      ),
    ),
  );
}
