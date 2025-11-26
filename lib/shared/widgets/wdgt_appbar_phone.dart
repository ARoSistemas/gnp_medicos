import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/banner_medico.dart';

class AppBarPhoneWdgt extends StatelessWidget implements PreferredSizeWidget {
  const AppBarPhoneWdgt({
    required this.title,
    required this.name,
    required this.medicalIdentifier,
    super.key,
    this.photo = '',
    this.onBack,
    this.showBanner = true,
  });

  final String title;
  final String name;
  final String medicalIdentifier;
  final String photo;
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
          medicalIdentifier: medicalIdentifier,
          photo: photo,
        ),
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('title', title))
      ..add(StringProperty('name', name))
      ..add(StringProperty('medicalIdentifier', medicalIdentifier))
      ..add(StringProperty('photo', photo))
      ..add(ObjectFlagProperty<VoidCallback?>.has('onBack', onBack))
      ..add(DiagnosticsProperty<bool>('showBanner', showBanner));
  }
}
