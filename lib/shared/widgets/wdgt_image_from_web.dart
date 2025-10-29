import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImageFromWeb extends StatelessWidget {
  const ImageFromWeb({
    required this.imageName,
    required this.jwt,
    this.height = 24,
    this.width = 24,
    this.borderRadius = BorderRadius.zero,
    super.key,
  });

  final String imageName;
  final String jwt;
  final double height;
  final double width;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: borderRadius,
    child: (imageName.isEmpty)
        ? SizedBox(height: height, width: width, child: const Placeholder())
        : CachedNetworkImage(
            height: height,
            width: width,
            fit: BoxFit.cover,
            imageUrl:
                'https://admonproveedoressalud-services-qa.gnp.com.mx/gestor-medico/assets/$imageName',
            httpHeaders: {'Authorization': 'Bearer $jwt'},
            errorWidget: (context, url, error) =>
                const Icon(Icons.question_mark_outlined),
          ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('imageName', imageName))
      ..add(StringProperty('jwt', jwt))
      ..add(DoubleProperty('height', height))
      ..add(DoubleProperty('width', width))
      ..add(
        DiagnosticsProperty<BorderRadiusGeometry>('borderRadius', borderRadius),
      );
  }
}
