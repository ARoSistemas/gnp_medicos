import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/null_extensions.dart';
import 'package:medicos/shared/constans/constans.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/utils/validators.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/add_user_controller.dart';

class UserGeneralData extends StatelessWidget {
  UserGeneralData({super.key});

  final AddUserController _c = Get.find<AddUserController>();

  @override
  Widget build(BuildContext context) => Form(
    key: _c.formKey,
    child: Column(
      children: [
        /// Name
        TextFormField(
          maxLength: 50,
          decoration: InputDecoration(
            labelText: esMessages.mx.name.value,
            hintText: esMessages.mx.name.value,
            counterText: ''
          ),
          controller: _c.nameController,
          validator: Validators.name,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(
              RegExp(regexNamesChar, unicode: true)
            ),
          ]
        ),

        /// Lastname
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: TextFormField(
            maxLength: 30,
            controller: _c.lastNameController,
            validator: Validators.lastName,
            decoration: InputDecoration(
              labelText: esMessages.mx.lastName.value,
              hintText: esMessages.mx.lastName.value,
              counterText: ''
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(
                RegExp(regexNamesChar, unicode: true)
              ),
            ]
          ),
        ),

        /// Second LastName
        TextFormField(
          maxLength: 30,
          controller: _c.secondLastNameController,
          validator: Validators.secondLastName,
          decoration: InputDecoration(
            labelText: esMessages.mx.secondLastName.value,
            hintText: esMessages.mx.secondLastName.value,
            counterText: ''
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(
              RegExp(regexNamesChar, unicode: true)
            ),
          ]
        ),

        /// Email
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: TextFormField(
            maxLength: 100,
            enabled: _c.isNewUser.value,
            controller: _c.emailController,
            validator: Validators.email,
            decoration: InputDecoration(
              labelText: esMessages.mx.email.value,
              hintText: esMessages.mx.email.value,
              counterText: ''
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),

        /// Phone Number
        TextFormField(
          maxLength: 10,
          enabled: _c.isNewUser.value,
          controller: _c.phoneNumberController,
          keyboardType: TextInputType.phone,
          validator: Validators.phone,
          decoration: InputDecoration(
            labelText: esMessages.mx.phoneNumber.value,
            hintText: esMessages.mx.phoneNumber.value,
            counterText: ''
          ),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),

        /// Birdthdate
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: TextFormField(
            controller: _c.birthdateController,
            validator: Validators.date,
            decoration: InputDecoration(
              labelText: esMessages.mx.birthdate.value,
              hintText: esMessages.mx.birthdate.value,
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _c.selectDateCalendar(context),
              ),
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),

        /// AsistantType
        DropdownButtonFormField(
          focusColor: ColorPalette.white,
          initialValue: _c.selectedItemType.value.value().isEmpty
              ? null
              : _c.selectedItemType.value,
          validator: Validators.option,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          hint: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              esMessages.mx.typeUser.value,
              style: context.textTheme.titleMedium?.copyWith(
                color: ColorPalette.labelText,
              ),
            ),
          ),
          isExpanded: true,
          onChanged: _c.selectTypeAssistant,
          items: _c.state!.assistanTypeList
              .map(
                (type) => DropdownMenuItem(
                  value: type.idTipoAsistente,
                  child: Text(
                    type.nombre,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: ColorPalette.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              )
              .toList(),
        ),

        /// Btn Continue
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: ElevatedButton(
            onPressed: _c.validForm,
            child: Text(
              esMessages.mx.continueB.value,
            ),
          ),
        ),

        ///
      ],
    ),
  );
}
