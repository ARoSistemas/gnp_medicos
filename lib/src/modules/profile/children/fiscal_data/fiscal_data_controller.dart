import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/controllers/state_controller.dart';
import 'package:medicos/shared/models/entities/user_mdl.dart';
import 'package:medicos/src/modules/profile/domain/entities/dtos/profile_dto.dart';
import 'package:url_launcher/url_launcher.dart';

part 'fiscal_data_model.dart';

class DatosFiscalesController extends GetxController
    with StateMixin<_DatosFiscalesModel> {
  final AppStateController appState = Get.find<AppStateController>();

  UserModel get user => appState.user;
  String get jwt => appState.user.token.jwt;

  final TextEditingController rfcCtrler = TextEditingController(
    text: '',
  );
  final TextEditingController domicilioFiscalCtrler = TextEditingController(
    text: '',
  );
  final TextEditingController metodoPagoCtrler = TextEditingController(
    text: '',
  );
  DatosFiscalesDto data = DatosFiscalesDto.empty();
  BankingDataDto dataBank = BankingDataDto.empty();

  @override
  void onInit() {
    super.onInit();
    change(const _DatosFiscalesModel(), status: RxStatus.loading());

    if (Get.arguments != null) {
      final args = Get.arguments as ProfileDto;
      data = args.datosFiscales;
      dataBank = args.bankingData;
    }

    rfcCtrler.text = data.rfc;
    domicilioFiscalCtrler.text = data.domicilioFiscal;
    metodoPagoCtrler.text = data.metodoPago;

    change(const _DatosFiscalesModel(), status: RxStatus.success());
  }

  @override
  void onClose() {
    rfcCtrler.dispose();
    domicilioFiscalCtrler.dispose();
    metodoPagoCtrler.dispose();
    super.onClose();
  }

  Future<void> goToSovos() async {
    final Uri url = Uri.parse('https://security.go.reachcore.com/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
