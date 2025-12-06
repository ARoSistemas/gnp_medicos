import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';

class LogoGnp extends StatelessWidget {
  const LogoGnp({this.width, super.key});
  final double? width;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: width ?? context.scale(115),
        child: Image.asset(
          'assets/logo-gnp.png',
          fit: BoxFit.cover,
        ),
      ),
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('width', width));
  }
}
