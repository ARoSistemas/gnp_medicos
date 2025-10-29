part of '../add_user_page.dart';

class _AddUserPhonePage extends StatelessWidget {
  _AddUserPhonePage();

  final AddUserController _c = Get.find<AddUserController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhone(
      title: _c.isNewUser.value
          ? esMessages.mx.newUser.value
          : esMessages.mx.updateUser.value,
    ),
    body: _c.obx(
      (data) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BannerMedico(
            name: _c.user.token.jwtLogin.claims.givenName,
            medicalIdentifier: _c.user.codigoFiliacion,
          ),

          /// Header
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      /// General data page
                      InkWell(
                        onTap: () => _c.changeTab(0),
                        child: ItemTabBarView(
                          isSelected: _c.selectedIndex.value == 0,
                          iconName: Icons.person_outline,
                          title: 'Datos Generales',
                        ),
                      ),

                      /// Permissions page
                      InkWell(
                        onTap: () => _c.changeTab(1),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ItemTabBarView(
                            isSelected: _c.selectedIndex.value == 1,
                            iconName: Icons.security_outlined,
                            title: 'Permisos',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.transparent),
                  Text(
                    _c.selectedIndex.value == 0
                        ? esMessages.mx.stepOneOfTwo.value
                        : esMessages.mx.stepTwoOfTwo.value,
                    style: Get.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// Body
          Obx(
            () => Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    if (_c.selectedIndex.value == 0) UserGeneralData(),
                    if (_c.selectedIndex.value == 1) UserPermissions(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      onLoading: const Center(child: LoadingGnp()),
      onEmpty: Center(
        child: LoadingGnp(
          icon: const Icon(
            Icons.warning,
            size: 70,
            color: ColorPalette.primary,
          ),
          title: esMessages.mx.noForm.value,
          subtitle: '',
        ),
      ),
      onError: (_) => Center(
        child: LoadingGnp(
          icon: const Icon(
            Icons.error,
            size: 70,
            color: ColorPalette.primary,
          ),
          title: esMessages.mx.errorLoadingForm.value,
          subtitle: esMessages.mx.pleaseTryAgainLater.value,
        ),
      ),
    ),
  );
}
