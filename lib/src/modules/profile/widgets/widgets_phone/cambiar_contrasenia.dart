// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:medicos/core/extensions/responsive_extension.dart';
// import 'package:medicos/shared/widgets/appbar_phone.dart';
// import 'package:medicos/shared/widgets/banner_medico.dart';
// import 'package:medicos/src/modules/profile/profile_controller.dart';

// class ChangePassword extends StatelessWidget {
//   ChangePassword({super.key});

//   static final GetPage page = GetPage(
//     name: '/cambiar-contrasenia',
//     page: ChangePassword.new,
//     transition: Transition.rightToLeft,
//   );

//   final ProfileController _c = Get.find();

//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: const AppBarPhone(
//       title: 'Cambiar contraseña',
//     ),
//     body: Column(
//       children: [
//         SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
//         BannerMedico(
//           name: _c.user.nombreCompleto,
//           medicalIdentifier: _c.user.codigoFiliacion,
//         ),
//         Expanded(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               children: [
//                 SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
//                 TextFormField(
//                   controller: _c.newPasswordController,
//                   decoration: const InputDecoration(
//                     labelText: 'Nueva contraseña',
//                     hintText: 'Nueva contraseña',
//                   ),
//                   validator: (value) => '',
//                 ),
//                 SizedBox(height: context.scale(15, axis: ScaleAxis.height)),
//                 TextFormField(
//                   decoration: const InputDecoration(
//                     labelText: 'Confirmar contraseña',
//                     hintText: 'Confirmar contraseña',
//                   ),
//                   controller: _c.confirmNewPasswordController,
//                   validator: (value) => '',
//                 ),
//                 SizedBox(height: context.scale(40, axis: ScaleAxis.height)),
//                 ElevatedButton(onPressed: () {},
//child: const Text('Guardar')),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
