import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

class LoadingGnp extends StatelessWidget {
  const LoadingGnp({
    this.title,
    this.subtitle,
    this.icon,
    super.key,
  });

  final String? title;
  final String? subtitle;
  final Widget? icon;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      if (icon == null)
        const CircularProgressIndicator(color: ColorPalette.primary),
      if (icon != null) icon!,
      Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          title == null ? esMessages.mx.loadingData.value : title!,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      Text(
        subtitle == null ? esMessages.mx.pleaseWait.value : subtitle!,
        style: const TextStyle(fontSize: 20),
      ),
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('title', title))
      ..add(StringProperty('subtitle', subtitle));
  }
}
