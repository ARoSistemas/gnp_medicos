part of '../home_page.dart';

class _HomePhonePage extends StatelessWidget {
  _HomePhonePage();

  final HomeController _c = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
      child: _c.obx(
        (data) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80, bottom: 20),
              child: Text(
                esMessages.mx.welcomeHome.value,
                style: Get.textTheme.titleMedium,
              ),
            ),
            Text(
              esMessages.mx.selectProfile.value,
              style: Get.textTheme.titleSmall?.copyWith(
                color: ColorPalette.textTertiary,
              ),
            ),

            /// Mi Perfil como doctor
            if (_c.appState.isDoctor)
              SizedBox(
                width: double.infinity,
                height: context.scale(160, axis: ScaleAxis.height),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: SectionTitle(
                        title: esMessages.mx.myProfile.value.toUpperCase(),
                      ),
                    ),
                    ItemAssitants(
                      name: _c.appState.user.nombreCompleto,
                      subTitle: _c.appState.user.especialidad,
                      urlPhoto: '',
                      onTap: () => Get.toNamed(WelcomePage.page.name),
                    ),
                  ],
                ),
              ),

            /// Lista de Asistentes
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: SectionTitle(
                title: esMessages.mx.myAccess.value.toUpperCase(),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: context.scale(
                420 + (_c.appState.isDoctor ? 0 : 160),
                axis: ScaleAxis.height,
              ),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: data?.asisstantList.length,
                itemBuilder: (context, i) {
                  final AsisstantDto item =
                      data?.asisstantList[i] ?? AsisstantDto.empty();
                  return ItemAssitants(
                    name: item.nombre,
                    subTitle: item.especialidad,
                    onTap: () async {
                      await _c.selectUser(item);
                    },
                  );
                },
              ),
            ),
          ],
        ),
        onEmpty: Center(
          child: LoadingGnp(
            icon: const Icon(
              Icons.warning,
              size: 70,
              color: ColorPalette.primary,
            ),
            title: esMessages.mx.noInvites.value,
            subtitle: esMessages.mx.noActiveInvites.value,
          ),
        ),
        onError: (_) => Center(
          child: LoadingGnp(
            icon: const Icon(
              Icons.error,
              size: 70,
              color: ColorPalette.primary,
            ),
            title: esMessages.mx.errorLoadingInvites.value,
            subtitle: esMessages.mx.pleaseTryAgainLater.value,
          ),
        ),
        onLoading: const Center(child: LoadingGnp()),
      ),
    ),
  );
}
