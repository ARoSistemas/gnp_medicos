part of '../login_page.dart';

class _LoginDesktopPage extends StatelessWidget {
  _LoginDesktopPage();

  final LoginController _c = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => Scaffold(
      body: Column(
        children: [
          Container(
            height: 64,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: ColorPalette.textPrimary),
              ),
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
          Expanded(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                /// background image
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage(
                          'assets/home_medicos_banner.jpeg',
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
                Positioned(
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      width: 450,
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
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      'Bienvenido, por favor inicia sesión',
                                      style: Get.textTheme
                                          .copyWith(
                                            titleMedium: Get
                                                .textTheme
                                                .titleMedium
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
                                              style: context
                                                  .textTheme
                                                  .titleLarge
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
                                        msg.changeUser.tr(),
                                        style: Get.textTheme.titleSmall
                                            ?.copyWith(
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
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          labelText: '${msg.email.tr()}*',
                                          hintText: msg.email.tr(),
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
                                        labelText: '${msg.password.tr()}*',
                                        hintText: msg.password.tr(),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _c.isPasswordVisible.value
                                                ? Icons.visibility
                                                : Icons.visibility_off_outlined,
                                          ),
                                          onPressed:
                                              _c.togglePasswordVisibility,
                                        ),
                                      ),
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      controller: _c.passwordController,
                                      validator: Validators.password,
                                    ),
                                  ),

                                  CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Text(msg.rememberUser.tr()),
                                    value: _c.rememberUser.value,
                                    onChanged: (v) => _c.onRemember(value: v),
                                  ),

                                  /// Btn: Olvidaste tu contraseña
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: TextButton(
                                      style: Get.theme.textButtonTheme.style
                                          ?.copyWith(
                                            padding: WidgetStateProperty.all(
                                              EdgeInsets.zero,
                                            ),
                                            minimumSize:
                                                WidgetStateProperty.all(
                                                  const Size(0, 48),
                                                ),
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
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: ElevatedButton(
                                      style: Get.theme.elevatedButtonTheme.style
                                          ?.copyWith(
                                            minimumSize:
                                                WidgetStateProperty.all(
                                                  const Size(0, 48),
                                                ),
                                          ),
                                      onPressed: _c.isLoading.value
                                          ? null
                                          : _c.doLogin,
                                      child: _c.isLoading.value
                                          ? const CircularProgressIndicator(
                                              color: ColorPalette.primary,
                                            )
                                          : Text(msg.login.tr()),
                                    ),
                                  ),

                                  /// Btn: Registrate
                                  TextButton(
                                    style: Get.theme.textButtonTheme.style
                                        ?.copyWith(
                                          padding: WidgetStateProperty.all(
                                            EdgeInsets.zero,
                                          ),
                                          minimumSize: WidgetStateProperty.all(
                                            const Size(0, 48),
                                          ),
                                        ),
                                    onPressed: _c.navigateRegister,
                                    child: Text(
                                      msg.createRegister.tr(),
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
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
