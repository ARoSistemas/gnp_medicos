import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/utils/validators.dart';
import 'package:medicos/src/modules/login/login_controller.dart';

class ModalForgotPassword extends StatelessWidget {
  ModalForgotPassword({super.key});
  final LoginController _c = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(
      bottom: MediaQuery.of(context).viewInsets.bottom,
    ),
    child: DecoratedBox(
      decoration: const BoxDecoration(
        color: ColorPalette.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _c.formKeyForgotPassword,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Title
                Text(
                  esMessages.mx.enterYourEmail.value,
                  style: context.textTheme.titleMedium,
                ),

                /// Input: Correo
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: TextFormField(
                    controller: _c.emailForgotPassController,
                    decoration: InputDecoration(
                      labelText: esMessages.mx.email.value,
                      hintText: esMessages.mx.email.value,
                    ),
                    validator: Validators.validateEmail,
                  ),
                ),

                /// Btn: Enviar Link
                ElevatedButton(
                  onPressed: _c.isLoading.value ? null : _c.forgotPassword,
                  child: _c.isLoading.value
                      ? const CircularProgressIndicator(
                          color: ColorPalette.white,
                        )
                      : Text(esMessages.mx.sendLink.value),
                ),

                /// Btn: Cancelar
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 15),
                  child: TextButton(
                    onPressed: Get.back,
                    child: Text(esMessages.mx.cancel.value),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
