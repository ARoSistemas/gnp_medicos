part of '../profile_page.dart';

class _ProfilePhonePage extends StatelessWidget {
  _ProfilePhonePage();

  final ProfileController _c = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    // appBar: AppBarPhone(title: msg.myProfile.tr()),
    body: _c.obx(
      (state) => Column(
        children: [
          AppBarPhone(title: msg.myProfile.tr()),

          /// Banner
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: BannerUser(
              name: _c.user.nombreCompleto,
              lastname: _c.user.apePaterno,
              rfc: _c.user.rfc,
              jwt: _c.user.token.jwt,
              medicalIdentifier: _c.user.codigoFiliacion,
              canChangeProfile: _c.user.canChangeProfile,
              onTapChangePhoto: () => AppService.i.alert.showAlert(
                child: UploadPhotoModal(
                  name: _c.user.nombreCompleto, 
                  lastname: _c.user.apePaterno,
                  rfc: _c.user.rfc,
                  jwt: _c.user.token.jwt, 
                  onUpload: _c.uploadProfilePhoto
                )
              ),
            ),
          ),

          /// Body
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: ColorPalette.backgroundCardBanner,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        SizedBox(
                          height: context.scale(10, axis: ScaleAxis.height),
                        ),

                        /// Title: Datos del médico
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 13,
                                vertical: 5,
                              ),
                              decoration: const BoxDecoration(
                                color: ColorPalette.backgroundPerfil,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.medical_information_outlined,
                                    color: ColorPalette.textPrimary,
                                    size: 20,
                                  ),
                                  SizedBox(width: context.scale(5)),
                                  Text(
                                    msg.doctorsInformation.tr(),
                                    style: context.textTheme.labelMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        /// Card: Datos personales
                        CardSectionProfile(
                          showCard:
                              _c.appState.userPermissions[DatosPersonalesPage
                                  .page
                                  .name] ??
                              false,
                          title: msg.personalData.tr(),
                          subtitle: '',
                          onTap: () => Get.toNamed(
                            DatosPersonalesPage.page.name,
                            arguments: _c.profileDto,
                          ),
                        ),

                        /// Card: Datos Académicos
                        CardSectionProfile(
                          showCard:
                              (_c.appState.userPermissions[DatosAcademicosPage
                                      .page
                                      .name] ??
                                  false) &&
                              _c.user.banConvenioVigenteEstatus,
                          title: msg.academicData.tr(),
                          subtitle: '',
                          onTap: () => Get.toNamed(
                            DatosAcademicosPage.page.name,
                            arguments: _c.profileDto,
                          ),
                        ),

                        /// Card: Datos Fiscales - Cuentas
                        CardSectionProfile(
                          showCard:
                              (_c.appState.userPermissions[DatosFiscalesPage
                                      .page
                                      .name] ??
                                  false) &&
                              _c.user.banConvenioVigenteEstatus,
                          title: msg.taxDataAccounts.tr(),
                          subtitle: '',
                          onTap: () => Get.toNamed(
                            DatosFiscalesPage.page.name,
                            arguments: _c.profileDto,
                          ),
                        ),

                        /// Card: Asistentes
                        if (_c.enableAsisstant.value)
                          CardSectionProfile(
                            showCard:
                                _c.appState.userPermissions[AssistantsPage
                                    .page
                                    .name] ??
                                false,
                            title: msg.assistants.pValue ?? '',
                            subtitle: '',
                            onTap: () => Get.toNamed(AssistantsPage.page.name),
                          ),

                        SizedBox(
                          height: context.scale(10, axis: ScaleAxis.height),
                        ),
                      ],
                    ),
                  ),

                  /// Footer
                  Obx(
                    () => Visibility(
                      replacement: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      visible: _c.canCheckBiometrics.value,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: ColorPalette.borderCardFormat,
                                width: context.scale(1),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: context.scale(
                                      5,
                                      axis: ScaleAxis.height,
                                    ),
                                  ),
                                  Text(
                                    msg.quickLogin.tr(),
                                    style: context.textTheme.titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                  SizedBox(
                                    height: context.scale(
                                      3,
                                      axis: ScaleAxis.height,
                                    ),
                                  ),
                                  Text(
                                    msg.activateFingerprintFace.tr(),
                                    style: context.textTheme.labelMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: context.scale(1),
                                        height: context.scale(
                                          50,
                                          axis: ScaleAxis.height,
                                        ),
                                        decoration: const BoxDecoration(
                                          color: ColorPalette.borderCardFormat,
                                        ),
                                      ),
                                      SizedBox(width: context.scale(10)),
                                      Switch(
                                        value:
                                            _c.userStored?.biometric ?? false,
                                        onChanged: (v) async {
                                          await _c.activeBiometric(value: v);
                                        },
                                        activeTrackColor: ColorPalette.primary,
                                        thumbIcon:
                                            WidgetStateProperty.resolveWith<
                                              Icon?
                                            >(
                                              (states) {
                                                if (states.contains(
                                                  WidgetState.selected,
                                                )) {
                                                  return const Icon(
                                                    Icons.check,
                                                    color: ColorPalette.primary,
                                                  );
                                                }
                                                return const Icon(Icons.close);
                                              },
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  ButtonPerfil(
                    label: msg.resetPassword.tr(),
                    icon: const Icon(
                      Icons.lock_outline,
                      color: ColorPalette.textPrimary,
                    ),
                    color: ColorPalette.textPrimary,
                    onPressed: _c.resetPassword,
                  ),

                  ButtonPerfil(
                    label: msg.signOut.tr(),
                    icon: const Icon(Icons.power_settings_new),
                    color: ColorPalette.primary,
                    onPressed: _c.signOut,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ButtonPerfil(
                      label: msg.deleteAccount.tr(),
                      icon: const Icon(
                        Icons.person_off_outlined,
                        color: ColorPalette.errorText,
                      ),
                      color: ColorPalette.errorText,
                      onPressed: _c.deleteAccount,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      onLoading: const Center(child: LoadingGnp()),
      onEmpty: Column(
        children: [
          AppBarPhone(title: msg.myProfile.tr()),
          const Spacer(),
          LoadingGnp(
            icon: const Icon(
              Icons.warning,
              size: 70,
              color: ColorPalette.primary,
            ),
            title: msg.noInformationToShow.tr(),
            subtitle: '',
          ),
          const Spacer(),
        ],
      ),
      onError: (_) => Column(
        children: [
          AppBarPhone(title: msg.myProfile.tr()),
          const Spacer(),
          LoadingGnp(
            isError: true,
            title: msg.errorLoadingInfo.tr(),
            subtitle: msg.pleaseTryAgainLater.tr(),
          ),
          const Spacer(),
        ],
      ),
    ),
  );
}
