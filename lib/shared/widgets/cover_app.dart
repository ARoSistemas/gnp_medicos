import 'package:flutter/material.dart';

class CoverApp extends StatelessWidget {
  const CoverApp({
    required this.child,
    super.key
  });

  final Widget child;

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: child,
  );
}
