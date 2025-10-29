
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DirectorioSearchController.dart';

class DirectorioSearchPage extends GetView<DirectorioSearchController> {
  const DirectorioSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Directorio Search'),
      ),
      body: Center(
        child: Text('Servicio: ${controller.servicio.toString()}'),
      ),
    );
  }
}
