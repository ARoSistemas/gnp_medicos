import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medicos/core/config/app_config.dart';

/// A widget that displays a cached network image from a predefined base URL,
/// authenticating the request with a JSON Web Token (JWT).
///
/// This widget uses [CachedNetworkImage] to efficiently load and cache images.
/// It handles cases where the [imageName] is empty by showing a [Placeholder],
/// and displays an error icon if the image fails to load.
///
/// The image URL is constructed by appending the [imageName] to a hardcoded
/// base URL: `https://admonproveedoressalud-services-qa.gnp.com.mx/gestor-medico/assets/`.
///
/// ### Example Usage:
///
/// ```dart
/// ImageFromWeb(
///   imageName: 'user_avatar.png',
///   jwt: 'your_jwt_token_here',
///   height: 100,
///   width: 100,
///   borderRadius: BorderRadius.circular(50),
/// )
/// ```
class ImageFromWeb extends StatelessWidget {
  /// Creates an [ImageFromWeb] widget.
  const ImageFromWeb({
    required this.imageName,
    required this.jwt,
    this.height = 24,
    this.width = 24,
    this.borderRadius = BorderRadius.zero,
    this.path = '/assets',
    this.fit = BoxFit.cover,
    super.key,
  });

  /// The name of the image file to be fetched from the server
  /// (e.g., 'image.png').
  final String imageName;

  /// The JSON Web Token (JWT) used for the 'Authorization' header.
  final String jwt;

  /// The target height of the image. Defaults to 24.
  final double height;

  /// The target width of the image. Defaults to 24.
  final double width;

  /// The border radius to clip the image. Defaults to [BorderRadius.zero].
  final BorderRadiusGeometry borderRadius;

  final String path;

  final BoxFit fit;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: borderRadius,
    child: imageName.isEmpty
        ? SizedBox(
            height: height,
            width: width,
            child: const Placeholder(),
          )
        : CachedNetworkImage(
            height: height,
            width: width,
            fit: fit,
            imageUrl: '${AppConfig.baseUrlMedicos}/gestor-medico$path/$imageName',
            httpHeaders: {'Authorization': 'Bearer $jwt'},
            errorWidget: (context, url, error) =>
                const Icon(Icons.question_mark_outlined),
            imageRenderMethodForWeb: ImageRenderMethodForWeb.HttpGet,
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
      )
      ..add(StringProperty('path', path))
      ..add(EnumProperty<BoxFit>('fit', fit));
  }
}
