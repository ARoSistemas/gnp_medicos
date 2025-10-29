import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/font_size_extension.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
class WarningCard extends StatelessWidget {

  const WarningCard({
    required this.titulo,
    required this.mensaje,
    super.key
  });
  final String titulo;
  final String mensaje;

  @override
  Widget build(BuildContext context) => Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: ColorPalette.warningBackground
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 7, left: 5),
            width: MediaQuery.of(context).size.width * .07,
            child: Image.asset('assets/warning-icon.png'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 7, left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo.value(),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: ColorPalette.textWarning,
                    fontSize: context.fontSize(10),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.1,
                  )
                ),
                SizedBox(height: context.scale(1, axis: ScaleAxis.height)),
                Text(
                  mensaje.value(),
                  style: context.textTheme.titleMedium
                ),
                SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
              ],
            ),
          )
        ],
      ),
    );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(StringProperty('titulo', titulo))
    ..add(StringProperty('mensaje', mensaje));
  }
}
