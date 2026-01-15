part of '../change_password_page.dart';

class _ChangePasswordDesktopPage extends StatelessWidget {
  _ChangePasswordDesktopPage();

  final ChangePasswordController _c = Get.find<ChangePasswordController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Contraseña',
              style: Get.textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 20),
          const Text('Crear contraseña'),
          const Divider(),
          const SizedBox(height: 20),
          Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 600,
              ),
              child: Column(
                children: [
                  Obx(
                    () => TextField(
                      controller: _c.temporalCtrl,
                      obscureText: _c.hideActual.value,
                      decoration: InputDecoration(
                        labelText: 'Contraseña temporal*',
                        // Icono para mostrar/ocultar
                        suffixIcon: IconButton(
                          icon: Icon(
                            _c.hideActual.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () => _c.hideActual.toggle(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Focus(
                    onFocusChange: (val) => _c.showRules.value = val,
                    child: Obx(
                      () => TextField(
                        controller: _c.contrasenaCtrl,
                        obscureText: _c.hideNueva.value,
                        decoration: InputDecoration(
                          labelText: 'Nueva contraseña*',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _c.hideNueva.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () => _c.hideNueva.toggle(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Focus(
                    onFocusChange: (val) => _c.onFocusConfirmPassword(
                      hasFocus: val,
                    ),
                    child: Obx(
                      () => TextField(
                        controller: _c.confirmaContrasenaCtrl,
                        obscureText: _c.hideConfirma.value,
                        decoration: InputDecoration(
                          labelText: 'Confirmar contraseña*',
                          errorText: _c.showToolTip.value
                              ? _c.messageToolTip.value
                              : null,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _c.hideConfirma.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: _c.hideConfirma.toggle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Obx(
                    () => Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 300,
                        ),
                        child: ElevatedButton(
                          onPressed: _c.isLoading.value ? null : _c.ingresar,
                          child: _c.isLoading.isTrue
                              ? const CircularProgressIndicator()
                              : const Text('Continuar'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => Visibility(
                      visible: _c.showRules.value,
                      child: Column(
                        children: _c.checkItems
                            .map(
                              (item) => Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: SvgPicture.asset(
                                      item.image,
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                  // Texto de la regla
                                  Expanded(
                                    child: Text(item.name),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
