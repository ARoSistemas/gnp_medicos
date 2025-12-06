import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/core/services/threads/threads_service.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/shared/services/alerts/notification_service.dart';
import 'package:medicos/shared/widgets/custom_notification.dart';
import 'package:medicos/shared/widgets/wdgt_menu_web.dart';
import 'package:medicos/src/modules/benefits/domain/remote/benefits_repository.dart';
import 'package:medicos/src/modules/benefits/entities/dtos/benefit_dto.dart';
import 'package:medicos/src/modules/welcome/welcome_page.dart';

part 'benefits_model.dart';

class BeneficiosController extends GetxController
    with StateMixin<_BeneficiosModel> {
  final ThreadsService threadsService = Get.find();
  final AppStateController appState = Get.find<AppStateController>();
  final BeneficiosRepository apiConn = Get.find();
  UserModel get user => appState.user;
  final NotificationServiceImpl _notification = AppService.i.notifications;
  final ScrollController scrollCtrl = ScrollController();

  List<BreadcrumbWeb> breadcrumbs = [
    BreadcrumbWeb('Inicio', route: WelcomePage.page.name),
    const BreadcrumbWeb('Beneficios'),
  ];

  @override
  Future<void> onInit() async {
    super.onInit();
    await getBeneficios();
  }

  Future<void> getBeneficios() async {
    await threadsService.execute(
      func: () async {
        final Map? dataFirebase = await appService.shared.realtimeService
            .getDataOnce('appConfig/modulos/beneficios');
        if (dataFirebase != null) {
          final List<BenefitDto> res = (dataFirebase['lista'] as List)
              .map(
                (bene) => BenefitDto.fromJson(Map<String, dynamic>.from(bene)),
              )
              .toList();
          final _BeneficiosModel newState = _BeneficiosModel.empty().copyWith(
            benefitsList: res,
          );
          if (newState.benefitsList.isEmpty) {
            change(newState, status: RxStatus.empty());
          } else {
            change(newState, status: RxStatus.success());
          }
        } else {
          change(
            _BeneficiosModel.empty(),
            status: RxStatus.empty(),
          );
        }
      },
      onError: () {
        change(
          _BeneficiosModel.empty(),
          status: RxStatus.error(),
        );
      },
    );
  }

  Future<void> downloadBeneficio(BenefitDto dto) async {
    if (dto.archivo.isEmpty) {
      return;
    }
    try {
      change(state, status: RxStatus.loading());
      final Uint8List? response = await apiConn.downloadBeneficio(dto.archivo);
      change(state, status: RxStatus.success());
      if (response != null) {
        await appService.fileStorage.downloadAndShareFile(
          data: response,
          fileName: dto.archivo,
        );
      } else {
        _notification.show(
          title: 'Error',
          message: 'No se logró obtener el beneficio.',
          type: AlertType.error,
        );
      }
    } on Exception catch (e) {
      change(state, status: RxStatus.success());
      _notification.show(
        title: 'Error',
        message: 'Ocurrió el detalle $e.',
        type: AlertType.error,
      );
    }
  }

  Future<void> moveRight() async {
    await scrollCtrl.animateTo(
      scrollCtrl.offset + 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> moveLeft() async {
    await scrollCtrl.animateTo(
      scrollCtrl.offset - 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
