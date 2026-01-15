import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicos/core/extensions/responsive_extension.dart';
import 'package:medicos/core/services/app_service.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/shared/widgets/avatar_user.dart';

class UploadPhotoModal extends StatelessWidget {
  const UploadPhotoModal({
    required this.name,
    required this.lastname,
    required this.onUpload,
    required this.rfc,
    required this.jwt,
    this.isWeb = false,
    super.key,
  });

  final bool isWeb; 
  final String name;
  final String lastname;
  final String rfc;
  final String jwt;
  final Function(PlatformFile) onUpload;

  Future<void> _pickImage() async {
    final PlatformFile? file = await appService.fileStorage.pickFile(
      allowedExtensions: ['png','jpg','jpeg'],
      mbSize: 3,
    );

    if (file != null) {
      onUpload(file);
      Get.back();
    }
  }

  Widget get _cancelButton => TextButton(
    onPressed: Get.back,
    child: Text(
      msg.cancel.tr(),
      style: const TextStyle(
        color: ColorPalette.primary,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
    ),
  );

  Widget get _pickPhotoButton => ElevatedButton(
    onPressed: _pickImage,
    child: const Text(
      'Subir foto',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) => Container(
    constraints: const BoxConstraints(maxWidth: kIsWeb ? 320 : 500),
    padding: const EdgeInsets.all(20),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Foto de perfil',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        AvatarUser(
          name: name,
          lastname: lastname,
          rfc: rfc,
          jwt: jwt,
          radius: 50,
          onTap: null,
          customIcon: Icons.delete_outline_rounded,
          isPerfil: false,
        ),
        const SizedBox(height: 24),
        if (isWeb) 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _pickPhotoButton),
              SizedBox(width: context.scale(8)),
              Expanded(child: _cancelButton),
            ]
          ) 
        else 
          Column(
            children:[
              _pickPhotoButton,
              SizedBox(height: context.scale(14)),
              _cancelButton,
            ]
          )
      ],
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('name', name))
      ..add(StringProperty('lastname', lastname))
      ..add(ObjectFlagProperty<Function(PlatformFile p1)>
        .has('onUpload', onUpload))
      ..add(DiagnosticsProperty<bool>('isWeb', isWeb))
      ..add(StringProperty('rfc', rfc))
      ..add(StringProperty('jwt', jwt));
  }
}
