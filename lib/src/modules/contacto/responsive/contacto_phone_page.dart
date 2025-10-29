part of '../contacto_page.dart';

class _ContactoPhonePage extends StatelessWidget {
  _ContactoPhonePage();

  final ContactoController _c = Get.find<ContactoController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhone(title: esMessages.mx.gnpContact.value),
    body: Column(
      children: <Widget>[
        /// Banner
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: BannerMedico(
            name: _c.user.nombreCompleto,
            medicalIdentifier: _c.user.codigoFiliacion,
          ),
        ),

        /// Body
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView.builder(
              itemCount: _c.items.length,
              itemBuilder: (context, i) => Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  bottom: 15,
                  left: 10,
                  right: 10,
                ),
                child: ItemMenu(
                  title: _c.items[i].title,
                  contact: _c.items[i].contact,
                  img: _c.items[i].img,
                  isLink: _c.items[i].isLink,
                  jwt: _c.items[i].jwt,
                  onTap: _c.items[i].onTap,
                ),
              ),
            ),
          ),
        ),
      ],
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
