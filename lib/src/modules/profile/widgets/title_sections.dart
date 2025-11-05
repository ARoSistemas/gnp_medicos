import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';

class TitleSections extends StatelessWidget {
  const TitleSections({
    required this.id,
    required this.title,
    required this.value,
    required this.onChanged,
    this.showCheckbox = true,
    super.key,
  });

  final String id;
  final String title;
  final bool value;
  final bool showCheckbox;
  final ValueChanged<bool?>? onChanged;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      SizedBox(
        width: 20,
        height: 20,
        child: showCheckbox
            ? Checkbox(
                value: value,
                onChanged: onChanged,
              )
            : const SizedBox.shrink(),
      ),
      SizedBox(width: context.scale(15)),
      Flexible(
        child: Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: Get.textTheme.titleMedium,
        ),
      ),
    ],
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('id', id))
      ..add(StringProperty('title', title))
      ..add(DiagnosticsProperty<bool>('value', value))
      ..add(DiagnosticsProperty<bool>('showCheckbox', showCheckbox))
      ..add(
        ObjectFlagProperty<ValueChanged<bool?>?>.has('onChanged', onChanged),
      )
      ..add(StringProperty('id', id));
  }
}
