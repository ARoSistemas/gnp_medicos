part of '../contact_page.dart';

class _ContactPhonePage extends StatelessWidget {
  _ContactPhonePage();

  final ContactController _c = Get.find<ContactController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhone(title: msg.gnpContact.tr()),
    body: _c.obx(
      (state) => SingleChildScrollView(
        child: Column(
          children: <Widget>[
            /// Banner
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: BannerMedico(
                name: _c.user.nombreCompleto,
                lastname: _c.user.apePaterno,
                rfc: _c.user.rfc,
                jwt: _c.user.token.jwt,
                medicalIdentifier: _c.user.codigoFiliacion,
              ),
            ),

            /// Links
            ..._c.items.map(
              (e) => Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  bottom: 15,
                  left: 10,
                  right: 10,
                ),
                child: ItemMenu(
                  title: e.title,
                  contact: e.contact,
                  img: e.img,
                  isLink: e.isLink,
                  jwt: e.jwt,
                  onTap: e.onTap,
                ),
              ),
            ),

            const Divider(color: Colors.transparent),

            /// Re Tabulaciones...
            ThisTitles(
              title: '${msg.reTabulationsTitle.tr()}:',
              subtitle: msg.reTabulationsSubtitle.tr(),
            ),
            LastItems(
              title: (_c.contacto!['aclaraciones'] as Map)['telefono'],
              subtitle: (_c.contacto!['aclaraciones'] as Map)['correo'],
              leading: 'icono_contactanos_phone.png',
              jwt: _c.items[2].jwt,
              onTapTitle: () async {
                await _c.launchPhoneContact(
                  (_c.contacto!['aclaraciones'] as Map)['telefono'],
                );
              },
              onTapSubTitle: () async {
                await _c.launchEmail(
                  (_c.contacto!['aclaraciones'] as Map)['correo'],
                  subject: msg.reTabulationsTitle.tr(),
                );
              },
            ),

            /// Información bancaria...
            ThisTitles(
              title: '${msg.bankingInfoTitle.tr()}:',
              subtitle: msg.bankingInfoSubtitle.tr(),
            ),
            LastItems(
              leading: 'icono_contactanos_mail.png',
              title: (_c.contacto!['informacionBancaria'] as Map)['correo'],
              jwt: _c.items[2].jwt,
              onTapTitle: () async {
                await _c.launchEmail(
                  (_c.contacto!['informacionBancaria'] as Map)['correo'],
                  subject: msg.bankingInfoTitle.tr(),
                );
              },
            ),

            /// Asistencia ...
            ThisTitles(
              title: '${msg.personalizedAssistanceTitle.tr()}:',
              subtitle: msg.personalizedAssistanceSubtitle.tr(),
            ),
            LastItems(
              leading: 'icono_contactanos_mail.png',
              title:
                  (_c.contacto!['asistenciaPersonalizada'] as Map)['correo'],
              jwt: _c.items[2].jwt,
              onTapTitle: () async {
                await _c.launchEmail(
                  (_c.contacto!['asistenciaPersonalizada'] as Map)['correo'],
                  subject: msg.personalizedAssistanceTitle.tr()
                );
              },
            ),
          ],
        ),
      ),
      onLoading: const Center(child: LoadingGnp()),
      onEmpty: Center(
        child: LoadingGnp(
          icon: const Icon(
            Icons.error,
            size: 70,
            color: ColorPalette.primary,
          ),
          title: msg.noDataAvailable.tr(
            args: [msg.contact.tr().toLowerCase()],
          ),
          subtitle: '',
        ),
      ),
      onError: (_) => Center(
        child: LoadingGnp(
          isError: true,
          title: msg.errorLoadingContact.tr(),
          subtitle: msg.pleaseTryAgainLater.tr(),
        ),
      ),
    ),
  );
}

class ItemsContacts {
  ItemsContacts({
    required this.title,
    required this.isLink,
    required this.onTap,
    this.img = '',
    this.jwt = '',
    this.contact = '',
  });

  final String title;
  final String contact;
  final bool isLink;
  final String img;
  final String jwt;
  final Function() onTap;
}

class ItemMenu extends StatelessWidget {
  const ItemMenu({
    required this.title,
    required this.contact,
    required this.isLink,
    required this.onTap,
    this.img = '',
    this.jwt = '',
    super.key,
  });

  final String title;
  final String contact;
  final bool isLink;
  final String img;
  final String jwt;
  final Function() onTap;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      /// Leading
      if (!isLink)
        Padding(
          padding: const EdgeInsets.only(right: 18),
          child: ImageFromWeb(
            height: 45,
            width: 45,
            imageName: img,
            jwt: jwt,
          ),
        ),

      /// Title
      Text(
        title,
        style: Get.textTheme.titleMedium?.copyWith(
          color: ColorPalette.contacto,
        ),
      ),
      const Spacer(),

      /// Trailing
      if (isLink)
        TextButton(
          onPressed: onTap,
          style: ButtonStyle(
            padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.zero,
            ),
            minimumSize: WidgetStateProperty.all<Size>(Size.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            contact,
            style: Get.textTheme.titleMedium?.copyWith(
              color: ColorPalette.primary,
              decoration: TextDecoration.underline,
              decorationColor: ColorPalette.primary,
            ),
          ),
        ),

      if (!isLink)
        IconButton(
          onPressed: onTap,
          icon: const Icon(
            Icons.arrow_forward_ios,
            color: ColorPalette.primary,
          ),
        ),
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('title', title))
      ..add(StringProperty('contact', contact))
      ..add(ObjectFlagProperty<Function()>.has('onTap', onTap))
      ..add(DiagnosticsProperty<bool>('isLink', isLink))
      ..add(StringProperty('img', img))
      ..add(StringProperty('jwt', jwt));
  }
}

class ThisTitles extends StatelessWidget {
  const ThisTitles({
    super.key,
    this.title = '',
    this.subtitle = '',
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Text.rich(
      TextSpan(
        text: title,
        style: Get.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: ColorPalette.contacto,
        ),
        children: [
          const WidgetSpan(child: SizedBox(width: 5)),
          TextSpan(
            text: subtitle,
            style: Get.textTheme.titleMedium?.copyWith(
              color: ColorPalette.contacto,
            ),
          ),
        ],
      ),
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('title', title))
      ..add(StringProperty('subtitle', subtitle));
  }
}

class LastItems extends StatelessWidget {
  const LastItems({
    required this.title,
    this.onTapTitle,
    this.onTapSubTitle,
    this.subtitle,
    this.leading = '',
    this.jwt = '',
    super.key,
  });

  final String title;
  final String? subtitle;
  final String leading;
  final String jwt;
  final VoidCallback? onTapTitle;
  final VoidCallback? onTapSubTitle;

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
    horizontalTitleGap: 10,
    leading: ImageFromWeb(
      height: 45,
      width: 45,
      imageName: leading,
      jwt: jwt,
    ),
    title: InkWell(
      onTap: onTapTitle,
      child: SizedBox(
        width: context.pWidth(70),
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Get.textTheme.titleMedium?.copyWith(
            color: ColorPalette.primary,
            decoration: TextDecoration.underline,
            decorationColor: ColorPalette.primary,
          ),
        ),
      ),
    ),
    subtitle: subtitle == null
        ? null
        : InkWell(
            onTap: onTapSubTitle,
            child: SizedBox(
              width: context.pWidth(70),
              child: Text(
                subtitle!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Get.textTheme.titleMedium?.copyWith(
                  color: ColorPalette.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: ColorPalette.primary,
                ),
              ),
            ),
          ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('title', title))
      ..add(StringProperty('subtitle', subtitle))
      ..add(StringProperty('leading', leading))
      ..add(StringProperty('jwt', jwt))
      ..add(
        ObjectFlagProperty<VoidCallback?>.has('onPressedTitle', onTapTitle),
      )
      ..add(
        ObjectFlagProperty<VoidCallback?>.has('onPressedMail', onTapSubTitle),
      );
  }
}
