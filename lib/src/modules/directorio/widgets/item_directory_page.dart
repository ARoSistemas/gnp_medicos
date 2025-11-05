import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ItemDirectoryPage extends StatelessWidget {
  const ItemDirectoryPage({required this.type, super.key});
  final String type;

  @override
  Widget build(BuildContext context) => const SizedBox();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('type', type));
  }
}
