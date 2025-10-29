import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        TextFormField(
          decoration: InputDecoration(
            labelText: esMessages.mx.name.value,
            hintText: esMessages.mx.name.value,
          ),
          controller: _c.nameController,
          validator: Validators.validateName,
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: TextFormField(
            controller: _c.firstNameController,
            validator: Validators.validateFirstName,
            decoration: InputDecoration(
              labelText: esMessages.mx.firstName.value,
              hintText: esMessages.mx.firstName.value,
            ),
          ),
        ),

        TextFormField(
          controller: _c.lastNameController,
          decoration: InputDecoration(
            labelText: esMessages.mx.lastName.value,
            hintText: esMessages.mx.lastName.value,
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: TextFormField(
            enabled: _c.isNewUser.value,
            controller: _c.emailController,
            validator: Validators.validateEmail,
            decoration: InputDecoration(
              labelText: esMessages.mx.email.value,
              hintText: esMessages.mx.email.value,
            ),
          ),
        ),

        TextFormField(
          enabled: _c.isNewUser.value,
          controller: _c.phoneNumberController,
          keyboardType: TextInputType.phone,
          validator: Validators.validatePhone,
          decoration: InputDecoration(
            labelText: esMessages.mx.phoneNumber.value,
            hintText: esMessages.mx.phoneNumber.value,
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: TextFormField(
            controller: _c.birthdateController,
            validator: Validators.validateDate,
            decoration: InputDecoration(
              labelText: esMessages.mx.birthdate.value,
              hintText: esMessages.mx.birthdate.value,
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () => _c.selectDateCalendar(context),
              ),
            ),
          ),
        ),

        DropdownButtonFormField(
          initialValue: _c.isNewUser.value ? null : _c.selectedItemType.value,
          validator: Validators.validateOption,
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

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: ElevatedButton(
            onPressed: _c.validForm,
            child: Text(
              esMessages.mx.continueB.value,
            ),
          ),
        ),
      ],
    ),
  );
}
