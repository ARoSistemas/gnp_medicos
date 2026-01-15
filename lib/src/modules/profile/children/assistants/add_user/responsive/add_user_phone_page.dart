part of '../add_user_page.dart';

class _AddUserPhonePage extends StatelessWidget {
  _AddUserPhonePage();

  final AddUserController _c = Get.find<AddUserController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhoneWdgt(
      title: _c.isNewUser.value ? msg.newUser.tr() : msg.updateUser.tr(),
      name: _c.user.nombreCompleto,
      lastname: _c.user.apePaterno,
      rfc: _c.user.rfc,
      jwt: _c.user.token.jwt,
      medicalIdentifier: _c.user.codigoFiliacion,
    ),
    body: _c.obx(
      (state) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
                          isCompleted: _c.selectedIndex.value > 0,
                          iconName: Icons.person_outline,
                          title: msg.generalData.tr(),
                        ),
                      ),

                      /// Permissions page
                      InkWell(
                        onTap: () => _c.changeTab(1),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ItemTabBarView(
                            isSelected: _c.selectedIndex.value == 1,
                            iconName: Icons.verified_user_outlined,
                            title: msg.permissions.tr(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.transparent),
                  Text(
                    _c.selectedIndex.value == 0
                        ? msg.stepOneOfTwo.tr()
                        : msg.stepTwoOfTwo.tr(),
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
          title: msg.noForm.tr(),
          subtitle: '',
        ),
      ),
      onError: (_) => Center(
        child: LoadingGnp(
          isError: true,
          title: msg.errorLoadingForm.tr(),
          subtitle: msg.pleaseTryAgainLater.tr(),
        ),
      ),
    ),
  );
}
