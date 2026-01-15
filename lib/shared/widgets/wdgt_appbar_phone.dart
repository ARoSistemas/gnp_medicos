import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/banner_medico.dart';

class AppBarPhoneWdgt extends StatelessWidget implements PreferredSizeWidget {
  const AppBarPhoneWdgt({
    required this.title,
    required this.name,
    required this.lastname,
    required this.medicalIdentifier,
    required this.rfc,
    required this.jwt,
    super.key,
    this.onBack,
    this.showBanner = true,
  });

  final String title;
  final String name;
  final String lastname;
  final String medicalIdentifier;
  final String rfc;
  final String jwt;
  final VoidCallback? onBack;
  final bool showBanner;

  @override
  Size get preferredSize => Size.fromHeight(showBanner ? 140 : kToolbarHeight);

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      AppBar(
        title: Text(
          title,
          style: Get.textTheme.titleLarge?.copyWith(
            fontSize: 20,
            color: ColorPalette.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorPalette.primary),
          onPressed: onBack ?? Get.back,
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      if (showBanner)
        BannerMedico(
          name: name,
          lastname: lastname,
          medicalIdentifier: medicalIdentifier,
          rfc: rfc,
          jwt: jwt,
        ),
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('title', title))
      ..add(StringProperty('name', name))
      ..add(StringProperty('lastname', lastname))
      ..add(StringProperty('medicalIdentifier', medicalIdentifier))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onBack', onBack))
      ..add(DiagnosticsProperty<bool>('showBanner', showBanner))
      ..add(StringProperty('rfc', rfc))
      ..add(StringProperty('jwt', jwt));
  }
}
