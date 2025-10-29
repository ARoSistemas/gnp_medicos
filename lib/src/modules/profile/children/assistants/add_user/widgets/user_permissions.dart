import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/shared/messages/es/es_messages.dart';
import 'package:medicos/src/modules/profile/children/assistants/add_user/add_user_controller.dart';
import 'package:medicos/src/modules/profile/profile_page.dart';
import 'package:medicos/src/modules/profile/widgets/dropdown_permisos.dart';
import 'package:medicos/src/modules/profile/widgets/title_sections.dart';

class UserPermissions extends StatelessWidget {
  UserPermissions({super.key});
  final AddUserController _c = Get.find<AddUserController>();

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.scale(20, axis: ScaleAxis.height)),

          ..._c.permissions.map((permiso) {
            if (permiso.submodulos.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: TitleSections(
                  id: permiso.id,
                  title: permiso.descripcion,
                  value: _c.permisosSeleccionadosIds.contains(permiso.id),
                  onChanged: (value) {
                    _c.updatePermission(
                      permiso.id,
                      isSelected: value!,
                    );
                  },
                ),
              );
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TitleSections(
                      id: permiso.id,
                      title: permiso.descripcion,
                      showCheckbox: permiso.id != ProfilePage.page.name,
                      value: _c.permisosSeleccionadosIds.contains(permiso.id),
                      onChanged: (value) {
                        _c.updatePermission(
                          permiso.id,
                          isSelected: value!,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsGeometry.only(bottom: 30),
                    child: DropdownPermission(
                      title: permiso.descripcion,
                      items: [
                        ...permiso.submodulos.map(
                          (submodulo) => DropdownMenuItem(
                            value: submodulo.id,
                            child: StatefulBuilder(
                              builder: (context, setState) => TitleSections(
                                id: permiso.id,
                                title: submodulo.descripcion,
                                value: _c.permisosSeleccionadosIds.contains(
                                  submodulo.id,
                                ),
                                onChanged: (value) {
                                  _c.updatePermission(
                                    submodulo.id,
                                    isSelected: value!,
                                  );
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                ],
              );
            }
          }),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton(
              onPressed: _c.saveUserComplete,
              child: Text(
                _c.isNewUser.value
                    ? esMessages.mx.registerUser.value
                    : esMessages.mx.updateUser.value,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
