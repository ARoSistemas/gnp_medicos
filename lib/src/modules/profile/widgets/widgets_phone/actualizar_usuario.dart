// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:medicos/core/extensions/responsive_extension.dart';
// import 'package:medicos/shared/utils/colors/color_palette.dart';
// import 'package:medicos/shared/widgets/appbar_phone.dart';
// import 'package:medicos/shared/widgets/banner_medico.dart';
// import 'package:medicos/src/modules/profile/profile_controller.dart';

// class ActualizarUsuario extends StatelessWidget {
//   ActualizarUsuario({super.key});

//   static final GetPage page = GetPage(
//     name: '/actualizar-usuario',
//     page: ActualizarUsuario.new,
//     transition: Transition.rightToLeft,
//   );

//   final ProfileController _c = Get.find();

//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: const AppBarPhone(
//       title: 'Actualizar usuario',
//     ),
//     body: Column(
//       children: [
//         BannerMedico(
//           name: _c.user.nombreCompleto,
//           medicalIdentifier: _c.user.codigoFiliacion,
//         ),
//         SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             children: [
//               Obx(
//                 () => Row(
//                   children: List.generate(_c.tabs.length, (index) {
//                     final bool isSelected = _c.selectedIndex.value == index;
//                     return GestureDetector(
//                       onTap: () {
//                         _c.tabController.animateTo(index);
//                       },
//                       child: Row(
//                         children: [
//                           AnimatedContainer(
//                             padding: 
//const EdgeInsets.symmetric(vertical: 15),
//                             duration: const Duration(milliseconds: 300),
//                             curve: Curves.easeInOut,
//                             width: isSelected
//                                 ? context.scale(260)
//                                 : context.scale(60),
//                             decoration: BoxDecoration(
//                               border: Border(
//                                 bottom: BorderSide(
//                                   color: isSelected
//                                       ? ColorPalette.primary
//                                       : ColorPalette.textPrimary,
//                                   width: context.scale(2),
//                                 ),
//                               ),
//                             ),
//                             alignment: Alignment.center,
//                             child: Row(
//                               mainAxisAlignment: isSelected
//                                   ? MainAxisAlignment.start
//                                   : MainAxisAlignment.center,
//                               children: [
//                                 if (index == 0)
//                                   const Icon(
//                                     Icons.person_outline,
//                                     size: 20,
//                                     color: ColorPalette.primary,
//                                   )
//                                 else
//                                   const Icon(
//                                     Icons.security_outlined,
//                                     size: 20,
//                                     color: ColorPalette.primary,
//                                   ),
//                                 SizedBox(
//                                   width: isSelected
//                                       ? context.scale(10)
//                                       : context.scale(0),
//                                 ),
//                                 if (isSelected)
//                                   Flexible(
//                                     child: Text(
//                                       _c.tabs[index],
//                                       style: Get.textTheme.labelLarge,
//                                     ),
//                                   )
//                                 else
//                                   const SizedBox(),
//                               ],
//                             ),
//                           ),
//                           SizedBox(width: context.scale(9)),
//                         ],
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: context.scale(20)),
//         /* Expanded(
//           child: TabBarView(
//             controller: _c.tabController,
//             children: tabsView.map((e) => e).toList(),
//           ),
//         ), */
//       ],
//     ),
//   );

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(IterableProperty('tabs', _c.tabs));
//   }
// }
