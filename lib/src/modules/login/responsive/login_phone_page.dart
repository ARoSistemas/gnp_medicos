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
                  padding: EdgeInsets.only(top: 60, bottom: 60),
                  child: LogoGnp(),
                ),
                if (_c.userStored.value == null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      msg.identify.tr(),
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
                    msg.changeUser.tr(),
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
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email,
                    decoration: InputDecoration(
                      labelText: msg.email.tr(),
                      hintText: msg.email.tr(),
                    ),
                  ),
                ),

                /// Input: Ingresa tu contraseña
                Padding(
                  padding: const EdgeInsetsGeometry.only(bottom: 20),
                  child: TextFormField(
                    obscureText: !_c.isPasswordVisible.value,
                    decoration: InputDecoration(
                      labelText: msg.password.tr(),
                      hintText: msg.password.tr(),
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
                        : _c.showDilaogPassword,
                    child: Text(
                      msg.forgotPassword.tr(),
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
                      : Text(msg.continueB.tr()),
                ),

                Visibility(
                  visible: _c.canCheckBiometrics.value && 
                  (_c.userStored.value?.biometric ??  false),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextButton(
                      onPressed:_c.authenticateBiometric,
                      child: Text(
                        msg.loginBiometrics.tr(),
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
                    child: Text(msg.dontHaveAccount.tr()),
                  ),
                ),

                /// Btn: Registrate
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: OutlinedButton(
                    onPressed: _c.navigateRegister,
                    child: Text(msg.registerNow.tr()),
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
