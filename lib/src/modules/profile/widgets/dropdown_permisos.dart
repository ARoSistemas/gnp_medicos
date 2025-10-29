import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';

class DropdownPermission extends StatelessWidget {
  const DropdownPermission({
    required this.title,
    required this.items,
    required this.onChanged,
    super.key,
  });

  final String title;
  final List<DropdownMenuItem> items;
  final ValueChanged<dynamic>? onChanged;

  @override
  Widget build(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: DropdownButtonFormField(
          isExpanded: true,
          items: items,
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: esMessages.mx.selectOneOrMoreOptions.value,
            labelStyle: Get.textTheme.labelMedium?.copyWith(
              color: ColorPalette.textTertiary,
              fontWeight: FontWeight.w500,
            ),
            floatingLabelStyle: Get.textTheme.labelMedium?.copyWith(
              color: ColorPalette.hintText,
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: ColorPalette.textField,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(
                color: ColorPalette.textField,
              ),
            ),
            focusColor: ColorPalette.white
          ),
        ),
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('title', title))
      ..add(ObjectFlagProperty<ValueChanged?>.has('onChanged', onChanged));
  }
}
