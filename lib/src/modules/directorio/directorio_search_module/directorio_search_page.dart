import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/src/modules/directorio/directorio_search_module/directorio_search_controller.dart';

class DirectorioSearchPage extends GetView<DirectorioSearchController> {
  const DirectorioSearchPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Directorio Search'),
    ),
    body: Center(
      child: Text('Servicio: ${controller.servicio}'),
    ),
  );
}
