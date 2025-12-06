part of '../profile_page.dart';

class _ProfilePhonePage extends StatelessWidget {
  _ProfilePhonePage();

  final ProfileController _c = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhone(title: esMessages.mx.myProfile.value),
    body: Column(
      children: [
        /// Banner
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: BannerUser(
            name: _c.user.nombreCompleto,
            medicalIdentifier: _c.user.codigoFiliacion,
            canChangeProfile: _c.user.canChangeProfile,
            onTapChangePhoto: () {},
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
                                  esMessages.mx.doctorsInformation.value,
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
                        title: esMessages.mx.personalData.value,
                        subtitle: '',
                        onTap: () => Get.toNamed(DatosPersonalesPage.page.name),
                      ),

                      /// Card: Datos Académicos
                      CardSectionProfile(
                        showCard:
                            (_c.appState.userPermissions[DatosAcademicosPage
                                    .page
                                    .name] ??
                                false) &&
                            _c.user.banConvenioVigenteEstatus,
                        title: esMessages.mx.academicData.value,
                        subtitle: '',
                        onTap: () => Get.toNamed(DatosAcademicosPage.page.name),
                      ),

                      /// Card: Datos Fiscales - Cuentas
                      CardSectionProfile(
                        showCard:
                            (_c.appState.userPermissions[DatosFiscalesPage
                                    .page
                                    .name] ??
                                false) &&
                            _c.user.banConvenioVigenteEstatus,
                        title: esMessages.mx.taxDataAccounts.value,
                        subtitle: '',
                        onTap: () => Get.toNamed(DatosFiscalesPage.page.name),
                      ),

                      /// Card: Asistentes
                      if (_c.enableAsisstant.value)
                        CardSectionProfile(
                          showCard:
                              _c.appState.userPermissions[AssistantsPage
                                  .page
                                  .name] ??
                              false,
                          title: esMessages.mx.assistants.pValue ?? '',
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
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
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
                                  esMessages.mx.quickLogin.value,
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
                                  esMessages.mx.activateFingerprintFace.value,
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
                                      value: _c.userStored?.biometric ?? false,
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
                  label: esMessages.mx.signOut.value,
                  icon: const Icon(Icons.power_settings_new),
                  color: ColorPalette.primary,
                  onPressed: () {
                    _c.appState.reset();
                    unawaited(Get.offAllNamed(LoginPage.page.name));
                  },
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ButtonPerfil(
                    label: esMessages.mx.deleteAccount.value,
                    icon: const Icon(
                      Icons.person_off_outlined,
                      color: ColorPalette.errorText,
                    ),
                    color: ColorPalette.errorText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
