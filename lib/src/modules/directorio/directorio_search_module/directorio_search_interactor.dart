import 'package:flutter/material.dart';
import 'package:medicos/src/modules/directorio/entity/catalogos.dart';

class DirectorioSearchInteractor {
  static Future<List<CirculoMedico>> getCirculosMedicos(
    BuildContext context,
    List<CirculoMedico> list,
  ) => Future.value([]);
  // This method is problematic because it depends on BuildContext.
  // For now, we'll return an empty list.
  // TO DO: Refactor this to not depend on context.
}
