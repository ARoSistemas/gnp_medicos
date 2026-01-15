import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/avatar_user.dart';
import 'package:medicos/shared/widgets/logo_gnp.dart';
import 'package:medicos/src/modules/profile/profile_page.dart';

class AppbarWelcomePhone extends StatelessWidget
    implements PreferredSizeWidget {
  const AppbarWelcomePhone({
    required this.name,
    required this.lastname,
    required this.rfc,
    required this.jwt,
    super.key,
  });

  final String name;
  final String lastname;
  final String rfc;
  final String jwt;

  @override
  Widget build(BuildContext context) => AppBar(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    leading: IconButton(
      icon: const Icon(Icons.menu, color: ColorPalette.primary),
      onPressed: () => Scaffold.of(context).openDrawer(),
    ),
    title: const LogoGnp(),
    centerTitle: false,
    actions: [
      Container(
        padding: const EdgeInsets.only(top: 10, bottom: 5),
        width: context.scale(50),
        child: AvatarUser(
          name: name,
          lastname: lastname,
          rfc: rfc,
          jwt: jwt,
          isPerfil: false,
          radius: 18,
          onTap: () => Get.toNamed(ProfilePage.page.name),
        ),
      ),
      SizedBox(width: context.scale(10)),
    ],
  );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties
      ..add(StringProperty('name', name))
      ..add(StringProperty('lastname', lastname))
      ..add(StringProperty('rfc', rfc))
      ..add(StringProperty('jwt', jwt));
  }
}
