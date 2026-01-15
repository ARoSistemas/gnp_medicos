part of '../profile_page.dart';

class _ProfileDesktopPage extends StatelessWidget {
  _ProfileDesktopPage(this.initialIndex);

  final int? initialIndex;

  final ProfileController _c = Get.find<ProfileController>();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('initialIndex', initialIndex));
  }

  Widget _tabBar(BuildContext context) => AnimatedBuilder(
    animation: _c.mainTabController,
    builder: (context, _) => Row(
      children: [
        InkWell(
          onHover: (value) {},
          onTap: () => _c.mainTabController.animateTo(0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: _c.mainTabController.index == 0
                  ? ColorPalette.chips
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _c.mainTabController.index == 0
                    ? ColorPalette.textField
                    : ColorPalette.borderCardFormat,
              ),
            ),
            child: Text(
              msg.generalData.tr(),
              textAlign: TextAlign.center,
              style: context.textTheme.titleMedium?.copyWith(
                color: _c.mainTabController.index == 0
                    ? Colors.white
                    : ColorPalette.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
        SizedBox(width: context.scale(16)),
        Visibility(
          visible: _c.enableAsisstant.value,
          child: InkWell(
            onHover: (value) {},
            onTap: () => _c.mainTabController.animateTo(1),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: _c.mainTabController.index == 1
                    ? ColorPalette.chips
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _c.mainTabController.index == 1
                      ? ColorPalette.textField
                      : ColorPalette.borderCardFormat,
                ),
              ),
              child: Text(
                msg.assistants.pValue ?? '',
                textAlign: TextAlign.center,
                style: context.textTheme.titleMedium?.copyWith(
                  color: _c.mainTabController.index == 1
                      ? Colors.white
                      : ColorPalette.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _bodyTab(BuildContext context) => AnimatedBuilder(
    animation: _c.mainTabController,
    builder: (context, _) => IndexedStack(
      index: _c.mainTabController.index,
      children: [
        _generalData(context),
        Visibility(
          visible: _c.enableAsisstant.value,
          child: const AssistantsDesktopView(),
        ),
      ],
    ),
  );

  Widget _dataTabBar(BuildContext context) => Obx(
    () => TabBar(
      controller: _c.dataTabController,
      indicatorColor: ColorPalette.primary,
      indicatorSize: TabBarIndicatorSize.tab,
      physics: const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
      onTap: _c.onTapChange,
      tabs: _c.availableTabs
          .asMap()
          .entries
          .map(
            (entry) => Tab(
              child: Text(
                entry.value.label,
                style: context.textTheme.titleMedium?.copyWith(
                  color: _c.selectedIndex.value == entry.key
                      ? ColorPalette.primary
                      : null,
                ),
              ),
            ),
          )
          .toList(),
    ),
  );

  Widget get _bodyDataTab => Obx(
    () {
      if (_c.availableTabs.isEmpty) {
        return const SizedBox.shrink();
      }

      final int currentIndex = _c.selectedIndex.value;

      if (currentIndex >= 0 && currentIndex < _c.availableTabs.length) {
        // Para Datos Personales, mantener el obx wrapper
        if (currentIndex == 0 &&
            _c.availableTabs.first.label == msg.personalData.tr()) {
          return _c.obx(
            (state) => _c.availableTabs[currentIndex].widgetBuilder(),
            onLoading: const Center(child: LoadingGnp()),
            onError: (_) => Center(
              child: LoadingGnp(
                isError: true,
                title: msg.errorOccurred.tr(),
                subtitle: msg.couldNotRetrieveAnnexes.tr(),
              ),
            ),
          );
        }

        return _c.availableTabs[currentIndex].widgetBuilder();
      }

      return const SizedBox.shrink();
    },
  );

  Widget _generalData(BuildContext context) => SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _dataTabBar(context), 
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: _bodyDataTab
        )
      ],
    ),
  );

  Widget _buttons(BuildContext context) => Column(
    spacing: 24,
    children: [
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
      ButtonPerfil(
        label: msg.deleteAccount.tr(),
        icon: const Icon(
          Icons.person_off_outlined,
          color: ColorPalette.errorText,
        ),
        color: ColorPalette.errorText,
        onPressed: _c.deleteAccount,
      ),
    ],
  );

  Widget _body(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(
      horizontal: MediaQuery.of(context).size.width * .1,
    ),
    child: Column(
      children: [
        SizedBox(height: context.scale(30, axis: ScaleAxis.height)),

        /// First TabBar - Datos Generales / Usuarios
        if (((_c.appState.userPermissions[DatosAcademicosPage.page.name] ??
                    false) ||
                (_c.appState.userPermissions[DatosFiscalesPage.page.name] ??
                    false)) &&
            _c.user.banConvenioVigenteEstatus) ...[
          _tabBar(context),
          SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
        ],

        /// Second TabBar - Data sections
        _bodyTab(context),
        const SizedBox(height: 24),

        /// Action Buttons
        _buttons(context),
        SizedBox(height: context.scale(30, axis: ScaleAxis.height)),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarWeb(title: msg.myProfile.tr()),
    body: _c.obx(
      (state) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Banner User
            BannerUser(
              name: _c.user.nombreCompleto,
              lastname: _c.user.apePaterno,
              medicalIdentifier: _c.user.codigoFiliacion,
              rfc: _c.user.rfc,
              jwt: _c.user.token.jwt,
              canChangeProfile: _c.user.canChangeProfile,
              onTapChangePhoto: () => AppService.i.alert.showAlert(
                child: UploadPhotoModal(
                  name: _c.user.nombreCompleto, 
                  lastname: _c.user.apePaterno, 
                  rfc: _c.user.rfc,
                  jwt: _c.user.token.jwt,
                  isWeb: true,
                  onUpload: _c.uploadProfilePhoto
                )
              ),
            ),
            _body(context),
          ],
        ),
      ),
      onLoading: const Center(child: LoadingGnp()),
      onEmpty: Center(
        child: LoadingGnp(
          icon: const Icon(
            Icons.warning,
            size: 70,
            color: ColorPalette.primary,
          ),
          title: msg.noInformationToShow.tr(),
          subtitle: '',
        ),
      ),
      onError: (_) => Center(
        child: LoadingGnp(
          isError: true,
          title: msg.errorLoadingInfo.tr(),
          subtitle: msg.pleaseTryAgainLater.tr(),
        ),
      ),
    ),
  );
}
