part of '../login_page.dart';

class _LoginTabletPage extends StatelessWidget {
  _LoginTabletPage();

  final LoginController _c = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Form(
          key: _c.formKey,
          child: Obx(
            () => SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LogoGnp(),
                  const SizedBox(height: 32),
                  
                  Text(
                    'Bienvenido, por favor inicia sesión',
                    style: Get.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 32),
                  
                  if (_c.userStored.value != null)
                    Container(
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: '¡Te damos la bienvenida!\n',
                          style: Get.textTheme.titleMedium?.copyWith(
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
                              style: Get.textTheme.titleLarge?.copyWith(
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
                        esMessages.mx.changeUser.value,
                        style: Get.textTheme.titleSmall?.copyWith(
                          color: ColorPalette.primary,
                          letterSpacing: 1.25,
                        ),
                      ),
                    ),
                  
                  if (_c.userStored.value == null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: TextFormField(
                        controller: _c.emailController,
                        validator: Validators.email,
                        decoration: InputDecoration(
                          labelText: esMessages.mx.email.value,
                          hintText: esMessages.mx.email.value,
                        ),
                      ),
                    ),
                  
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
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
                  
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(EdgeInsets.zero),
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
                          esMessages.mx.forgotPassword.value,
                        ),
                      ),
                    ),
                  ),
                  
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
                        (_c.userStored.value?.biometric ?? false),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: TextButton(
                        onPressed: _c.authenticateBiometric,
                        child: Text(
                          esMessages.mx.loginBiometrics.value,
                          style: Get.textTheme.titleSmall?.copyWith(
                            color: ColorPalette.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  OutlinedButton(
                    onPressed: _c.navigateRegister,
                    child: Text(esMessages.mx.registerNow.value),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

//   @override
//   Widget build(BuildContext context) => Scaffold(
//     backgroundColor: Colors.white,
//     body: Stack(
//       children: [
//         Container(
//           alignment: Alignment.center,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/beneficio1.png'),
//               fit: BoxFit.cover,
//               opacity: 0.5,
//             ),
//           ),
//         ),

//         Align(
//           alignment: Alignment.centerRight,
//           child: Container(
//             height: context.pHeight(99, pxMin: 600, pxMax: 800),
//             width: context.pWidth(50, pxMin: 400, pxMax: 600),
//             alignment: Alignment.centerLeft,
//             child: GestureDetector(
//               onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//               child: Form(
//                 key: _c.formKey,
//                 child: SingleChildScrollView(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Obx(
//                     () => Column(
//                       children: [
//                         const Divider(color: Colors.transparent),
//                         const Padding(
//                           padding: EdgeInsets.only(top: 100, bottom: 60),
//                           child: LogoGnp(),
//                         ),
//                         Text(
//                           'Texto de ejemplo',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: context.pText(40),
//                           ),
//                         ),
//                         Text(
//                           'Texto de ejemplo delimitado',
//                           style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             // fontSize: context.pText(13),
//                             fontSize: 
//context.pText(30, pxMin: 30, pxMax: 40),
//                           ),
//                         ),
//                         if (!_c.isEmailEntered.value)
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 20),
//                             child: Container(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 esMessages.mx.identify.value,
//                                 style: Get.textTheme.titleSmall,
//                               ),
//                             ),
//                           ),

//                         if (_c.isEmailEntered.value) ...[
//                           Container(
//                             alignment: Alignment.center,
//                             child: Text(
//                               esMessages.mx.welcome.value,
//                               style: context.textTheme.titleMedium?.copyWith(
//                                 fontWeight: FontWeight.w600,
//                                 letterSpacing: 1.2,
//                               ),
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: _c.toggleInputFields,
//                             child: Text(
//                               esMessages.mx.changeUser.value,
//                               style: Get.textTheme.titleSmall?.copyWith(
//                                 color: ColorPalette.primary,
//                               ),
//                             ),
//                           ),
//                         ],

//                         /// Input: Ingresa tu contraseña
//                         if (_c.isEmailEntered.value)
//                           TextFormField(
//                             obscureText: !_c.isPasswordVisible.value,
//                             decoration: InputDecoration(
//                               labelText: esMessages.mx.password.value,
//                               hintText: esMessages.mx.password.value,
//                               suffixIcon: IconButton(
//                                 icon: Icon(
//                                   _c.isPasswordVisible.value
//                                       ? Icons.visibility
//                                       : Icons.visibility_off_outlined,
//                                 ),
//                                 onPressed: _c.togglePasswordVisibility,
//                               ),
//                             ),
//                             keyboardType: TextInputType.visiblePassword,
//                             controller: _c.passwordController,
//                             validator: Validators.password,
//                           ),

//                         ///  Input: Correo Válido
//                         if (!_c.isEmailEntered.value)
//                           Padding(
//                             padding: 
//const EdgeInsetsGeometry.only(bottom: 40),
//                             child: TextFormField(
//                               controller: _c.emailController,
//                               validator: Validators.email,
//                               decoration: InputDecoration(
//                                 labelText: esMessages.mx.email.value,
//                                 hintText: esMessages.mx.email.value,
//                               ),
//                             ),
//                           ),

//                         /// Btn: Olvidaste tu contraseña
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 30),
//                           child: TextButton(
//                             style: ButtonStyle(
//                               padding: 
// WidgetStateProperty.all(EdgeInsets.zero),
//                               alignment: Alignment.centerLeft,
//                             ),
//                             onPressed: _c.isLoading.value
//                                 ? null
//                                 : () async {
//                                     await showModalBottomSheet(
//                                       context: context,
//                                       isScrollControlled: true,
//                                       backgroundColor: ColorPalette.white,
//                                       builder: (context) =>
//                                           ModalForgotPassword(),
//                                     );
//                                   },
//                             child: Text(
//                               esMessages.mx.forgotPassword.value,
//                             ),
//                           ),
//                         ),

//                         /// Btn: Continuar
//                         Container(
//                           color: Colors.amber,
//                           height: context.pHeight(5),
//                           child: ElevatedButton(
//                             onPressed: 
//_c.isLoading.value ? null : _c.doLogin,
//                             child: _c.isLoading.value
//                                 ? const CircularProgressIndicator(
//                                     color: ColorPalette.primary,
//                                   )
//                                 : Text(esMessages.mx.continueB.value),
//                           ),
//                         ),

//                         if (_c.isEmailEntered.value) ...[
//                           Padding(
//                             padding: const EdgeInsets.only(top: 10),
//                             child: TextButton(
//                               child: Text(
//                                 esMessages.mx.loginBiometrics.value,
//                                 style: Get.textTheme.titleSmall?.copyWith(
//                                   color: ColorPalette.primary,
//                                 ),
//                               ),
//                               onPressed: () {},
//                             ),
//                           ),
//                         ],

//                         const Padding(
//                           padding: EdgeInsets.only(top: 20, bottom: 10),
//                           child: Divider(color: ColorPalette.textField),
//                         ),

//                         /// Btn: No tienes cuenta
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 10),
//                           child: TextButton(
//                             onPressed: null,
//                             style: ButtonStyle(
//                               foregroundColor: WidgetStateProperty.all(
//                                 ColorPalette.textPrimary,
//                               ),
//                               textStyle: WidgetStateProperty.all(
//                                 Get.textTheme.titleMedium,
//                               ),
//                               padding: 
// WidgetStateProperty.all(EdgeInsets.zero),
//                               alignment: Alignment.center,
//                             ),
//                             child: Text(esMessages.mx.dontHaveAccount.value),
//                           ),
//                         ),

//                         /// Btn: Registrate
//                         Padding(
//                           padding: const EdgeInsets.only(bottom: 30),
//                           child: OutlinedButton(
//                             onPressed: _c.navigateRegister,
//                             child: Text(esMessages.mx.registerNow.value),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
