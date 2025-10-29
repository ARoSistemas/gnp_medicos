import 'package:flutter/material.dart';
import '../Entity/Catalogos.dart';

class DirectorioSearchInteractor {
  static Future<List<CirculoMedico>> getCirculosMedicos(
      BuildContext context, List<CirculoMedico> list) async {
    // This method is problematic because it depends on BuildContext.
    // For now, we'll return an empty list.
    // TODO: Refactor this to not depend on context.
    return Future.value([]);
  }
}