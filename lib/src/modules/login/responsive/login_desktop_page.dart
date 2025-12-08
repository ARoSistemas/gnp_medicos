part of '../login_page.dart';

class _LoginDesktopPage extends StatelessWidget {
  _LoginDesktopPage();

  final LoginController _c = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final double height = constraints.maxHeight;
      final double width = constraints.maxWidth;
      return Scaffold(
        body: Stack(
          children: [
            /// Header: Logo GNP
            Container(
              height: 64,
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: ColorPalette.textPrimary
                  )
                )
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                    child: LogoGnp(width: context.scale(85)),
                  ),
                ],
              ),
            ),

            /// background image
            Positioned(
              top: height * 0.1,
              child: Container(
                width: width,
                height: height * 0.8,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage(
                      'assets/home_medicos_banner.png',
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withValues(alpha: 0.85),
                      BlendMode.dstATop,
                    ),
                  ),
                ),
              ),
            ),

            /// Card: Login Form
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 24,
                  ),
                  width: 450,
                  height: height * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Form(
                    key: _c.formKey,
                    child: Obx(
                      () => SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Bienvenido, por favor inicia sesión',
                                style: Get.textTheme
                                    .copyWith(
                                      titleMedium: Get.textTheme.titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.15,
                                          ),
                                    )
                                    .titleMedium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const Divider(
                              color: ColorPalette.primary,
                            ),
                            const Divider(color: Colors.transparent),
                        
                            if (_c.userStored.value != null)
                              Container(
                                alignment: Alignment.center,
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: '¡Te damos la bienvenida!\n',
                                    style: context.textTheme.titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.15,
                                        ),
                                    children: [
                                      TextSpan(
                                        text: _c
                                            .userStored
                                            .value
                                            ?.token
                                            .jwtLogin
                                            .claims
                                            .givenName,
                                        style: context.textTheme.titleLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.15,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            if (_c.userStored.value != null)
                              TextButton(
                                onPressed: _c.changeUser,
                                child: Text(
                                  msg.changeUser.value,
                                  style: Get.textTheme.titleSmall?.copyWith(
                                    color: ColorPalette.primary,
                                    letterSpacing: 1.25,
                                  ),
                                ),
                              ),
                        
                            ///  Input: Correo Válido
                            if (_c.userStored.value == null)
                              Padding(
                                padding: const EdgeInsetsGeometry.only(
                                  bottom: 40,
                                ),
                                child: TextFormField(
                                  controller: _c.emailController,
                                  validator: Validators.email,
                                  decoration: InputDecoration(
                                    labelText: msg.email.value,
                                    hintText: msg.email.value,
                                  ),
                                ),
                              ),
                        
                            /// Input: Ingresa tu contraseña
                            Padding(
                              padding: const EdgeInsetsGeometry.only(
                                bottom: 20,
                              ),
                              child: TextFormField(
                                obscureText: !_c.isPasswordVisible.value,
                                decoration: InputDecoration(
                                  labelText: msg.password.value,
                                  hintText: msg.password.value,
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
                                  padding: WidgetStateProperty.all(
                                    EdgeInsets.zero,
                                  ),
                                  alignment: Alignment.centerLeft,
                                ),
                                onPressed: _c.isLoading.value
                                    ? null
                                    : () async {
                                        await showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            content: ModalForgotPassword(),
                                            contentPadding: EdgeInsets.zero,
                                            backgroundColor: Colors.transparent,
                                          ),
                                        );
                                      },
                                child: Text(
                                  msg.forgotPassword.value,
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
                                  : Text(msg.continueB.value),
                            ),
                        
                            Visibility(
                              visible:
                                  _c.canCheckBiometrics.value &&
                                  (_c.userStored.value?.biometric ?? false),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: TextButton(
                                  onPressed: _c.authenticateBiometric,
                                  child: Text(
                                    msg.loginBiometrics.value,
                                    style: Get.textTheme.titleSmall?.copyWith(
                                      color: ColorPalette.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        
                            /// Btn: Registrate
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 50,
                                bottom: 30,
                              ),
                              child: OutlinedButton(
                                onPressed: _c.navigateRegister,
                                child: Text(
                                  msg.registerNow.value,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
