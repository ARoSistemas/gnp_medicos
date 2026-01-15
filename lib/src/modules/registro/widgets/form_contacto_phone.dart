import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/core/utils/upper_case_text_formatter.dart';
import 'package:medicos/shared/constans/constans.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
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
              labelText: msg.name.pValue,
              hintText: msg.name.pValue,
              counterText: '',
            ),
            validator: (value) => Validators.inputText(value ?? ''),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(
                RegExp(regexNamesChar, unicode: true),
              ),
            ],
          ),
          SizedBox(height: context.scale(30, axis: ScaleAxis.height)),

          /// LastName
          TextFormField(
            maxLength: 30,
            controller: _c.lastNameCtler,
            decoration: InputDecoration(
              labelText: msg.notLastName.tr(),
              hintText: msg.notLastName.tr(),
              counterText: '',
            ),
            validator: (value) => Validators.inputText(value ?? ''),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(
                RegExp(regexNamesChar, unicode: true),
              ),
            ],
          ),
          SizedBox(height: context.scale(30, axis: ScaleAxis.height)),

          /// second lastname
          TextFormField(
            maxLength: 30,
            controller: _c.secondLastNameCtler,
            decoration: InputDecoration(
              labelText: msg.notSecondLastName.tr(),
              hintText: msg.notSecondLastName.tr(),
              counterText: '',
            ),
            validator: (value) => Validators.inputText(value ?? ''),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(
                RegExp(regexNamesChar, unicode: true),
              ),
            ],
          ),
          SizedBox(height: context.scale(30, axis: ScaleAxis.height)),

          /// email
          TextFormField(
            maxLength: 100,
            controller: _c.emailCtler,
            decoration: InputDecoration(
              labelText: msg.email.tr(),
              hintText: msg.email.tr(),
              counterText: '',
            ),
            validator: Validators.email,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(regexFilterEmail)),
            ],
          ),
          SizedBox(height: context.scale(30, axis: ScaleAxis.height)),

          /// Phone Number
          TextFormField(
            controller: _c.phoneNumberCtler,
            maxLength: 10,
            decoration: InputDecoration(
              labelText: msg.phoneNumber.tr(),
              hintText: msg.phoneNumber.tr(),
              counterText: '',
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
              counterText: '',
            ),
            validator: _c.validaRfc,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(
                RegExp(regexAlphanumeric, unicode: true),
              ),
              UpperCaseTextFormatter(),
            ],
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

          SizedBox(height: context.scale(30, axis: ScaleAxis.height)),
          /// Professional License
          TextFormField(
            controller: _c.cedProfesionalCtler,
            maxLength: 10,
            decoration: InputDecoration(
              labelText: msg.professionalLicense.tr(),
              hintText: msg.professionalLicense.tr(),
              counterText: '',
            ),
            validator: (val) => Validators.cedule(val, required: true),
            keyboardType: TextInputType.number,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          SizedBox(height: context.scale(30, axis: ScaleAxis.height)),

          /// Speciality
          TextFormField(
            controller: _c.cedEspecialidadCtler,
            maxLength: 10,
            decoration: InputDecoration(
              labelText: msg.speciality.tr(),
              hintText: msg.speciality.tr(),
              counterText: '',
            ),
            validator: (val) => Validators.cedule(val, required: true),
            keyboardType: TextInputType.number,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          SizedBox(height: context.scale(30, axis: ScaleAxis.height)),

          /// Subspeciality
          TextFormField(
            controller: _c.cedSubespecialidadCtler,
            maxLength: 10,
            decoration: InputDecoration(
              labelText: msg.subspeciality.tr(),
              hintText: msg.subspeciality.tr(),
              counterText: '',
            ),
            keyboardType: TextInputType.number,
            validator: Validators.cedule,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          SizedBox(height: context.scale(30, axis: ScaleAxis.height)),

          /// Btn Accept
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Obx(
              () => ElevatedButton(
                style: kIsWeb ? Get.theme.elevatedButtonTheme.style?.copyWith(
                  minimumSize: WidgetStateProperty.all(
                    const Size(0, 48),
                  ),
                ) : null,
                onPressed: _c.isLoading.value ? null : _c.registerService,
                child: _c.isLoading.value
                    ? const CircularProgressIndicator(
                        color: ColorPalette.primary,
                      )
                    : Text(msg.signUp.tr()),
              ),
            ),
          ),

          /// Btn Cancel
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextButton(
              onPressed: Get.back,
              style: kIsWeb ? Get.theme.textButtonTheme.style?.copyWith(
                minimumSize: WidgetStateProperty.all(
                  const Size(0, 48),
                ),
                padding: WidgetStateProperty.all(
                  EdgeInsets.zero,
                ),
              ) : null,
              child: Text(msg.cancel.tr()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: RichText(
              text: TextSpan(
                style: context.textTheme.labelMedium,
                children: [
                  TextSpan(text: msg.toRegisterYouAccept.tr()),
                  TextSpan(
                    text: msg.termsAndConditions.tr(),
                    style: const TextStyle(color: ColorPalette.primary),
                  ),
                  TextSpan(text: msg.fromGroupNational.tr()),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
