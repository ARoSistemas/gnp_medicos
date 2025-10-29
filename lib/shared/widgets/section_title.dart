import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';

class SectionTitle extends StatelessWidget {

  const SectionTitle({
    required this.title,
    this.widget,
    super.key
  });
  final String title;
  final Widget? widget;

  @override
  Widget build(BuildContext context) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: context.scale(5),
              height: context.scale(30, axis: ScaleAxis.height),
              decoration: const BoxDecoration(
                color: Colors.orange,
              ),
            ),
            SizedBox(width: context.scale(10)),
            Text(
              title,
              style: Get.textTheme.titleSmall
            ),
          ],
        ),
        if(widget != null)
          Container(
            child: widget,
          ),
      ],
    );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(StringProperty('title', title))
    ..add(DiagnosticsProperty<Widget?>('widget', widget));
  }
}
