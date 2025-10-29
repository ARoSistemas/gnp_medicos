import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:medicos/src/modules/directorio/directorio_binding.dart';
import 'package:medicos/src/modules/directorio/directorio_controller.dart';
import 'package:medicos/src/modules/directorio/stubs/app_colors.dart';

class DirectorioPage extends GetView<DirectorioController> {
  const DirectorioPage({super.key});

  static final GetPage page = GetPage(
    name: '/directorio',
    page: () => const DirectorioPage(),
    binding: DirectorioBinding(),
  );

  @override
  Widget build(BuildContext context) => DefaultTabController(
    length: 5,
    child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.orange),
        title: const Text(
          'Directorio',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.dirTextColor,
          ),
        ),
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            controller.backToHome();
          },
        ),
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) {
            return;
          }
          Get.back();
        },
        child: getBody(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    ),
  );

  ListView getBody(BuildContext context) => ListView(
    children: [
      Obx(
        () => DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: controller.colorM.value
                    ? AppColors.secondary900
                    : AppColors.boxShadow,
                blurRadius: 10,
                spreadRadius: -22,
                offset: const Offset(0, 1.5),
              ),
            ],
          ),
          child: Card(
            margin: const EdgeInsets.all(16),
            child: ListTile(
              onTap: () => controller.onMedicosTapped(),
              contentPadding: const EdgeInsets.only(
                left: 10,
                top: 10,
                bottom: 10,
              ),
              leading: Image.asset(
                'assets/directorio-medico.png',
                width: 60,
                height: 60,
              ),
              title: Text(
                'Médicos',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  color: controller.colorM.value
                      ? AppColors.secondary900
                      : AppColors.gnpTextSystem,
                ),
              ),
            ),
          ),
        ),
      ),
      Obx(
        () => DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: controller.colorH.value
                    ? AppColors.secondary900
                    : AppColors.boxShadow,
                blurRadius: 10,
                spreadRadius: -22,
                offset: const Offset(0, 1.5),
              ),
            ],
          ),
          child: Card(
            margin: const EdgeInsets.all(16),
            child: ListTile(
              onTap: () => controller.onHospitalesTapped(),
              contentPadding: const EdgeInsets.only(
                left: 10,
                top: 10,
                bottom: 10,
              ),
              leading: Image.asset(
                'assets/convenio-medico-icon.png',
                width: 60,
                height: 60,
              ),
              title: Text(
                'Hospitales',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  color: controller.colorH.value
                      ? AppColors.secondary900
                      : AppColors.gnpTextSystem,
                ),
              ),
            ),
          ),
        ),
      ),
      Obx(
        () => DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: controller.colorC.value
                    ? AppColors.secondary900
                    : AppColors.boxShadow,
                blurRadius: 10,
                spreadRadius: -22,
                offset: const Offset(0, 1.5),
              ),
            ],
          ),
          child: Card(
            margin: const EdgeInsets.all(16),
            child: ListTile(
              onTap: () => controller.onClinicasTapped(),
              contentPadding: const EdgeInsets.only(
                left: 10,
                top: 10,
                bottom: 10,
              ),
              leading: Image.asset(
                'assets/beneficios-icon.png',
                width: 60,
                height: 60,
              ),
              title: Text(
                'Clínicas',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  color: controller.colorC.value
                      ? AppColors.secondary900
                      : AppColors.gnpTextSystem,
                ),
              ),
            ),
          ),
        ),
      ),
      Obx(
        () => DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: controller.colorOt.value
                    ? AppColors.secondary900
                    : AppColors.boxShadow,
                blurRadius: 10,
                spreadRadius: -22,
                offset: const Offset(0, 1.5),
              ),
            ],
          ),
          child: Card(
            margin: const EdgeInsets.all(16),
            child: ListTile(
              onTap: () => controller.onOtrosServTapped(),
              contentPadding: const EdgeInsets.only(
                left: 10,
                top: 10,
                bottom: 10,
              ),
              leading: Image.asset(
                'assets/tabuladores-icon.png',
                width: 60,
                height: 60,
              ),
              title: Text(
                'Otros servicios de salud',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  color: controller.colorOt.value
                      ? AppColors.secondary900
                      : AppColors.gnpTextSystem,
                ),
              ),
            ),
          ),
        ),
      ),
      Obx(
        () => DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: controller.colorMod.value
                    ? AppColors.secondary900
                    : AppColors.boxShadow,
                blurRadius: 10,
                spreadRadius: -22,
                offset: const Offset(0, 1.5),
              ),
            ],
          ),
          child: Card(
            margin: const EdgeInsets.all(16),
            child: ListTile(
              onTap: () => controller.onModulosTapped(),
              contentPadding: const EdgeInsets.only(
                left: 10,
                top: 10,
                bottom: 10,
              ),
              leading: Image.asset(
                'assets/mis-tramites-icon.png',
                width: 60,
                height: 60,
              ),
              title: Text(
                'Módulos GNP',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  color: controller.colorMod.value
                      ? AppColors.secondary900
                      : AppColors.gnpTextSystem,
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
