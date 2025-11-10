import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/core/utils/upper_case_text_formatter.dart';
import 'package:medicos/shared/constans/constans.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/utils/validators.dart';
import 'package:medicos/src/modules/registro/registro_controller.dart';

class FormContactoPhone extends StatelessWidget {
  FormContactoPhone({super.key});

  final RegistroController _c = Get.find<RegistroController>();

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Form(
      key: _c.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: false,
            child: Text(
              'Paso 1 de 2',
              style: Get.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          /// Name
          TextFormField(
            maxLength: 50,
            controller: _c.nameCtler,
            decoration: InputDecoration(
              labelText: esMessages.mx.name.pValue,
              hintText: esMessages.mx.name.pValue,
              counterText: ''
            ),
            validator: Validators.name,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(
                RegExp(regexNamesChar, unicode: true)
              ),
            ]
          ),
          SizedBox(height: context.scale(30, axis: ScaleAxis.height)),

          /// LastName
          TextFormField(
            maxLength: 30,
            controller: _c.lastNameCtler,
            decoration: InputDecoration(
              labelText: esMessages.mx.notLastName.value,
              hintText: esMessages.mx.notLastName.value,
              counterText: ''
            ),
            validator: Validators.lastName,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(
                RegExp(regexNamesChar, unicode: true)
              ),
            ]
          ),
          SizedBox(height: context.scale(30, axis: ScaleAxis.height)),

          /// second lastname
          TextFormField(
            maxLength: 30,
            controller: _c.secondLastNameCtler,
            decoration: InputDecoration(
              labelText: esMessages.mx.notSecondLastName.value,
              hintText: esMessages.mx.notSecondLastName.value,
              counterText: ''
            ),
            validator: Validators.secondLastName,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(
                RegExp(regexNamesChar, unicode: true)
              ),
            ]
          ),
          SizedBox(height: context.scale(30, axis: ScaleAxis.height)),

          /// email
          TextFormField(
            maxLength: 100,
            controller: _c.emailCtler,
            decoration: InputDecoration(
              labelText: esMessages.mx.email.value,
              hintText: esMessages.mx.email.value,
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
          SizedBox(height: context.scale(30, axis: ScaleAxis.height)),

          /// Phone Number
          TextFormField(
            controller: _c.phoneNumberCtler,
            maxLength: 10,
            decoration: InputDecoration(
              labelText: esMessages.mx.phoneNumber.value,
              hintText: esMessages.mx.phoneNumber.value,
              counterText: ''
            ),
            keyboardType: TextInputType.phone,
            validator: Validators.phone,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          SizedBox(height: context.scale(30, axis: ScaleAxis.height)),

          /// RFC
          TextFormField(
            maxLength: 13,
            controller: _c.rfcCtler,
            decoration: const InputDecoration(
              labelText: 'RFC',
              hintText: 'RFC',
              counterText: ''
            ),
            validator: _c.validaRfc,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(
              RegExp(regexAlphanumeric, unicode: true)
            ),
            UpperCaseTextFormatter(),
          ]
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 10),
            child: Text(
              'Con homoclave',
              style: Get.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          /// Btn Accept
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Obx(
              () => ElevatedButton(
                onPressed: _c.isLoading.value ? null : _c.registerService,
                child: _c.isLoading.value
                    ? const CircularProgressIndicator(
                        color: ColorPalette.primary,
                      )
                    : Text(esMessages.mx.signUp.value),
              ),
            ),
          ),

          /// Btn Cancel
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextButton(
              onPressed: Get.back,
              child: Text(esMessages.mx.cancel.value),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: RichText(
              text: TextSpan(
                style: context.textTheme.labelMedium,
                children: [
                  TextSpan(text: esMessages.mx.toRegisterYouAccept.value),
                  TextSpan(
                    text: esMessages.mx.termsAndConditions.value,
                    style: const TextStyle(color: ColorPalette.primary),
                  ),
                  TextSpan(text: esMessages.mx.fromGroupNational.value),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
