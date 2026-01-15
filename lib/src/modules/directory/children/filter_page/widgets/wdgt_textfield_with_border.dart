import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

class TextFieldWithBorderInBottom extends StatelessWidget {
  const TextFieldWithBorderInBottom({
    required this.title,
    required this.label,
    required this.colorBorde,
    required this.controller,
    required this.onSubmitted,
    this.isWeb = false,
    super.key,
  });

  final String title;
  final String label;
  final Color colorBorde;
  final TextEditingController controller;
  final bool isWeb;
  final VoidCallback onSubmitted;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      /// Show title only when is mobile
      if (!isWeb) ...[
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),

        /// TextField with bottom border
        TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.grey[600]),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorBorde),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: colorBorde, width: 2),
            ),
          ),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          onSubmitted: (_) => onSubmitted,
          onEditingComplete: onSubmitted,
        ),
      ],

      /// Show alternative TextField when is web
      if (isWeb) ...[
        SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.grey[600]),
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: label,
                    labelStyle: TextStyle(color: Colors.grey[600]),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: ColorPalette.borderInput),
                    ),
                  ),
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  onSubmitted: (_) => onSubmitted(),
                  onEditingComplete: onSubmitted,
                ),
              ),
            ],
          ),
        ),
      ],
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('title', title))
      ..add(StringProperty('label', label))
      ..add(ColorProperty('colorBorde', colorBorde))
      ..add(
        DiagnosticsProperty<TextEditingController>('controller', controller),
      )
      ..add(DiagnosticsProperty<bool>('isWeb', isWeb))
      ..add(
        DiagnosticsProperty<VoidCallback>('onSubmitted', onSubmitted),
      );
  }
}
