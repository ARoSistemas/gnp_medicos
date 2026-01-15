import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medicos/shared/constans/constans.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/utils/validators.dart';
import 'package:medicos/src/modules/login/login_controller.dart';

class ModalForgotPassword extends StatelessWidget {
  ModalForgotPassword({super.key});
  final LoginController _c = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) => ConstrainedBox(
    constraints: const BoxConstraints(
      maxWidth: 500,
    ),
    child: Padding(
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
                    msg.enterYourEmail.tr(),
                    style: context.textTheme.titleMedium,
                  ),
    
                  /// Input: Correo
                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: TextFormField(
                      maxLength: 100,
                      controller: _c.emailForgotPassController,
                      decoration: InputDecoration(
                        labelText: msg.email.tr(),
                        hintText: msg.email.tr(),
                        counterText: ''
                      ),
                      validator: Validators.email,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                            RegExp(regexFilterEmail)
                          ),
                        ]
                    ),
                  ),
    
                  if(!kIsWeb)
                    btnsMovil(),
                  if(kIsWeb)
                    btnsWeb()
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );


  Widget btnsMovil() => Column(
    children: [
      ElevatedButton(
        onPressed: 
        _c.isLoadingForgot.value ? null : _c.forgotPassword,
        child: _c.isLoadingForgot.value
            ? const CircularProgressIndicator(
                color: ColorPalette.primary,
              )
            : Text(msg.sendLink.tr()),
      ),

      Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 15),
        child: TextButton(
          onPressed: Get.back,
          child: Text(msg.cancel.tr()),
        ),
      ),
    ],
  );

  Widget btnsWeb() => Row(
    children: [
      ElevatedButton(
        style: Get.theme.elevatedButtonTheme.style?.copyWith(
          minimumSize: WidgetStateProperty.all(const Size(0, 48)),
        ),
        onPressed: 
        _c.isLoadingForgot.value ? null : _c.forgotPassword,
        child: _c.isLoadingForgot.value
            ? const CircularProgressIndicator(
                color: ColorPalette.primary,
              )
            : Text(msg.sendLink.tr()),
      ),

      const SizedBox(
        width: 10,
      ),
      
      TextButton(
        style: Get.theme.textButtonTheme.style?.copyWith(
          minimumSize: WidgetStateProperty.all(const Size(0, 48)),
        ),
        onPressed: Get.back,
        child: Text(msg.cancel.tr()),
      ),
    ],
  );
}
