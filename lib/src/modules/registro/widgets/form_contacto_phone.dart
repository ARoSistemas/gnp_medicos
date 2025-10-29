import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/utils/validators.dart';
import 'package:medicos/src/modules/registro/registro_controller.dart';

class FormContactoPhone extends StatelessWidget {
  FormContactoPhone({super.key});

  final RegistroController _c = Get.find<RegistroController>();

  @override
  Widget build(BuildContext context) {
    const String avisoTerminos =
        'Termino y condiciones de uso de Medios Electrónicos ';

    return SingleChildScrollView(
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
            TextFormField(
              controller: _c.nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre(s)',
                hintText: 'Nombre(s)',
              ),
              validator: Validators.validateName,
            ),
            SizedBox(height: context.scale(30, axis: ScaleAxis.height)),
            TextFormField(
              controller: _c.firstNameController,
              decoration: const InputDecoration(
                labelText: 'Primer apellido',
                hintText: 'Primer apellido',
              ),
              validator: Validators.validateFirstName,
            ),
            SizedBox(height: context.scale(30, axis: ScaleAxis.height)),
            TextFormField(
              controller: _c.lastNameController,
              decoration: const InputDecoration(
                labelText: 'Segundo apellido',
                hintText: 'Segundo apellido',
              ),
            ),
            SizedBox(height: context.scale(30, axis: ScaleAxis.height)),
            TextFormField(
              controller: _c.emailController,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                hintText: 'Correo electrónico',
              ),
              validator: Validators.validateEmail,
            ),
            SizedBox(height: context.scale(30, axis: ScaleAxis.height)),
            TextFormField(
              controller: _c.phoneNumberController,
              decoration: const InputDecoration(
                labelText: 'Número celular',
                hintText: 'Número celular',
              ),
              keyboardType: TextInputType.phone,
              validator: Validators.validatePhone,
            ),
            SizedBox(height: context.scale(30, axis: ScaleAxis.height)),
            TextFormField(
              controller: _c.rfcController,
              decoration: const InputDecoration(
                labelText: 'RFC',
                hintText: 'RFC',
              ),
              validator: _c.validaRfc
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
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Obx(
                () => ElevatedButton(
                  onPressed: _c.isLoading.value ? null : _c.registerService,
                  child: _c.isLoading.value
                      ? const CircularProgressIndicator(
                          color: ColorPalette.primary,
                        )
                      : const Text('Registrarme'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextButton(
                onPressed: Get.back,
                child: const Text('Cancelar'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: RichText(
                text: TextSpan(
                  style: context.textTheme.labelMedium,
                  children: const [
                    TextSpan(text: 'Al registrarse aceptas nuestros '),
                    TextSpan(
                      text: avisoTerminos,
                      style: TextStyle(color: ColorPalette.primary),
                    ),
                    TextSpan(text: 'de Grupo Nacional Provincial S.A.B'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
