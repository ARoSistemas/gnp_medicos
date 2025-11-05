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
                const Padding(
                  padding: EdgeInsets.only(top: 100, bottom: 60),
                  child: LogoGnp(),
                ),
                if (_c.userStored.value == null)
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

                if (_c.userStored.value != null)
                Container(
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '¡Te damos la bienvenida!\n',
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.15,
                      ),
                      children: [
                        TextSpan(
                          text: 
                          _c.userStored.value?.token.jwtLogin.claims.givenName,
                          style: context.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.15,
                          ),
                        )
                      ]
                    ),
                  ),
                ),
                if (_c.userStored.value != null)
                TextButton(
                  onPressed: _c.changeUser,
                  child: Text(
                    esMessages.mx.changeUser.value,
                    style: Get.textTheme.titleSmall?.copyWith(
                      color: ColorPalette.primary,
                      letterSpacing: 1.25
                    ),
                  ),
                ),

                ///  Input: Correo Válido
                if (_c.userStored.value == null)
                Padding(
                  padding: const EdgeInsetsGeometry.only(bottom: 40),
                  child: TextFormField(
                    controller: _c.emailController,
                    validator: Validators.email,
                    decoration: InputDecoration(
                      labelText: esMessages.mx.email.value,
                      hintText: esMessages.mx.email.value,
                    ),
                  ),
                ),

                /// Input: Ingresa tu contraseña
                Padding(
                  padding: const EdgeInsetsGeometry.only(bottom: 20),
                  child: TextFormField(
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
                    validator: Validators.password,
                  ),
                ),

                /// Btn: Olvidaste tu contraseña
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
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
                ElevatedButton(
                  onPressed: _c.isLoading.value ? null : _c.doLogin,
                  child: _c.isLoading.value
                      ? const CircularProgressIndicator(
                          color: ColorPalette.primary,
                        )
                      : Text(esMessages.mx.continueB.value),
                ),

                Visibility(
                  visible: _c.canCheckBiometrics.value && 
                  (_c.userStored.value?.biometric ??  false),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextButton(
                      onPressed:_c.authenticateBiometric,
                      child: Text(
                        esMessages.mx.loginBiometrics.value,
                        style: Get.textTheme.titleSmall?.copyWith(
                          color: ColorPalette.primary,
                        ),
                      ),
                    ),
                  ),
                ),

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
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
