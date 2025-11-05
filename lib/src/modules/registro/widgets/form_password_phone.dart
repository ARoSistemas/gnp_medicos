import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/src/modules/registro/registro_controller.dart';

class FormPasswordPhone extends StatelessWidget {
  const FormPasswordPhone({super.key});

  @override
  Widget build(BuildContext context) {
    final RegistroController c = Get.find<RegistroController>();
    const String avisoTerminos =
        'Términos y condiciones de uso de Medios Electrónicos ';

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Paso 2 de 2',
            style: Get.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
          Obx(
            () => TextFormField(
              controller: c.passwordCtler,
              obscureText: !c.isPasswordVisible.value,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                hintText: 'Contraseña',
                suffixIcon: IconButton(
                  icon: Icon(
                    c.isPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: c.togglePasswordVisibility,
                ),
              ),
              validator: (value) => '',
            ),
          ),
          SizedBox(height: context.scale(30, axis: ScaleAxis.height)),
          Obx(
            () => TextFormField(
              controller: c.passwordConfirmCtler,
              obscureText: !c.isConfirmPasswordVisible.value,
              decoration: InputDecoration(
                labelText: 'Confirmar contraseña',
                hintText: 'Confirmar contraseña',
                suffixIcon: IconButton(
                  icon: Icon(
                    c.isConfirmPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: c.toggleConfirmPasswordVisibility,
                ),
              ),
              validator: (value) => '',
            ),
          ),
          SizedBox(height: context.scale(30, axis: ScaleAxis.height)),
          ElevatedButton(
            onPressed: c.registerService,
            child: const Text(
              'Registrarme',
            ),
          ),
          SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
          TextButton(onPressed: () {}, child: const Text('Cancelar')),
          SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
          RichText(
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
        ],
      ),
    );
  }
}
