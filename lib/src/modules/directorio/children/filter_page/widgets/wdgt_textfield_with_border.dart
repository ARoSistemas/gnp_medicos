import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TextFieldWithBorderInBottom extends StatelessWidget {
  const TextFieldWithBorderInBottom({
    required this.title,
    required this.label,
    required this.colorBorde,
    required this.controller,
    super.key,
  });

  final String title;
  final String label;
  final Color colorBorde;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          title,
          style: const TextStyle(
            // color: colorTituloSeccion,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ),
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
      ),
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
      );
  }
}
