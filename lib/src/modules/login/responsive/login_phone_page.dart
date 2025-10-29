part of '../../login/login_page.dart';

class _LoginPhonePage extends StatelessWidget {
  _LoginPhonePage();

  final LoginController _c = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Form(
        key: _c.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(
            () => Column(
              children: [
                const Divider(color: Colors.transparent),
                Padding(
                  padding: const EdgeInsets.only(top: 100, bottom: 60),
                  child: LogoGnp(
                    width: context.pWidth(40, pxMin: 100, pxMax: 1000),
                  ),
                ),

                if (!_c.isEmailEntered.value)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        esMessages.mx.identify.value,
                        style: Get.textTheme.titleSmall,
                      ),
                    ),
                  ),

                if (_c.isEmailEntered.value) ...[
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      esMessages.mx.welcome.value,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _c.toggleInputFields,
                    child: Text(
                      esMessages.mx.changeUser.value,
                      style: Get.textTheme.titleSmall?.copyWith(
                        color: ColorPalette.primary,
                      ),
                    ),
                  ),
                ],

                /// Input: Ingresa tu contraseña
                if (_c.isEmailEntered.value)
                  TextFormField(
                    obscureText: !_c.isPasswordVisible.value,
                    decoration: InputDecoration(
                      labelText: esMessages.mx.password.value,
                      hintText: esMessages.mx.password.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _c.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: _c.togglePasswordVisibility,
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    controller: _c.passwordController,
                    validator: Validators.validatePassword,
                  ),

                ///  Input: Correo Válido
                if (!_c.isEmailEntered.value)
                  Padding(
                    padding: const EdgeInsetsGeometry.only(bottom: 40),
                    child: TextFormField(
                      controller: _c.emailController,
                      validator: Validators.validateEmail,
                      decoration: InputDecoration(
                        labelText: esMessages.mx.email.value,
                        hintText: esMessages.mx.email.value,
                      ),
                    ),
                  ),

                /// Btn: Olvidaste tu contraseña
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: TextButton(
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: _c.isLoading.value
                        ? null
                        : () async {
                            await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: ColorPalette.white,
                              builder: (context) => ModalForgotPassword(),
                            );
                          },
                    child: Text(
                      esMessages.mx.forgotPassword.value,
                    ),
                  ),
                ),

                /// Btn: Continuar
                Container(
                  color: Colors.amber,
                  height: context.pHeight(5),
                  child: ElevatedButton(
                    onPressed: _c.isLoading.value ? null : _c.doLogin,
                    child: _c.isLoading.value
                        ? const CircularProgressIndicator(
                            color: ColorPalette.primary,
                          )
                        : Text(esMessages.mx.continueB.value),
                  ),
                ),

                if (_c.isEmailEntered.value) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextButton(
                      child: Text(
                        esMessages.mx.loginBiometrics.value,
                        style: Get.textTheme.titleSmall?.copyWith(
                          color: ColorPalette.primary,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],

                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Divider(color: ColorPalette.textField),
                ),

                /// Btn: No tienes cuenta
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextButton(
                    onPressed: null,
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(
                        ColorPalette.textPrimary,
                      ),
                      textStyle: WidgetStateProperty.all(
                        Get.textTheme.titleMedium,
                      ),
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                      alignment: Alignment.center,
                    ),
                    child: Text(esMessages.mx.dontHaveAccount.value),
                  ),
                ),

                /// Btn: Registrate
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: OutlinedButton(
                    onPressed: _c.navigateRegister,
                    child: Text(esMessages.mx.registerNow.value),
                  ),
                ),

                /// Directorio page
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: OutlinedButton(
                    onPressed: () async {
                      await Get.toNamed(DirectorioPage.page.name);
                    },
                    child: const Text('Directorio Page'),
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
