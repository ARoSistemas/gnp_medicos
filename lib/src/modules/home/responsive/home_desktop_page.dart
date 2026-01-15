part of '../home_page.dart';

class _HomeDesktopPage extends StatelessWidget {
  _HomeDesktopPage();

  final HomeController _c = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      child: _c.obx(
        (state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                msg.welcomeHome.tr(),
                style: Get.textTheme.titleMedium,
              ),
            ),
            Text(
              msg.selectProfile.tr(),
              style: Get.textTheme.titleSmall?.copyWith(
                color: ColorPalette.textTertiary,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_c.andIsDoctor.value)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: SectionTitle(
                                title: msg.myProfile.tr().toUpperCase(),
                              ),
                            ),
                            ItemAssitants(
                              name: _c.appState.userLogued.nombreCompleto,
                              lastname: _c.appState.userLogued.apePaterno,
                              subTitle: _c.appState.userLogued.especialidad,
                              rfc: _c.appState.userLogued.rfc,
                              jwt: _c.appState.userLogued.token.jwt,
                              onTap: _c.selectprofile,
                            ),
                          ],
                        ),
                      ),
                    SizedBox(width: _c.andIsDoctor.value ? 40 : 0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SectionTitle(
                              title: msg.myAccess.tr().toUpperCase(),
                            ),
                          ),
                          Expanded(
                            child: ListView.separated(
                              padding: EdgeInsets.zero,
                              itemCount: state?.asisstantList.length ?? 0,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(height: 16),
                              itemBuilder: (context, i) {
                                final AsisstantDto item =
                                    state?.asisstantList[i] ??
                                    AsisstantDto.empty();
                                return ItemAssitants(
                                  name: item.nombre,
                                  lastname: item.apellidoPaterno,
                                  subTitle: item.especialidad,
                                  rfc: item.rfc,
                                  jwt: _c.appState.user.token.jwt,
                                  onTap: () async {
                                    await _c.selectUser(item);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        onLoading: const Center(child: LoadingGnp()),
        onEmpty: Scaffold(
          appBar: AppBarWeb(
            elevation: 8,
            title: msg.back.tr(),
            onBack: _c.exit,
          ),
          body: Column(
            children: [
              const SizedBox(height: 30),
              Text(
                msg.apologize.pValue.value(),
                style: Get.textTheme.titleLarge,
              ),
              const SizedBox(height: 50),
              ImageFromWeb(
                height: 300,
                width: double.infinity,
                imageName: 'imagen_mensaje_ups.png',
                jwt: _c.appState.user.token.jwt,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 30),
              Text(
                msg.noInvitation.tr(),
                style: Get.textTheme.titleMedium,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
        onError: (_) => Center(
          child: LoadingGnp(
            isError: true,
            title: msg.errorLoadingInvites.tr(),
            subtitle: msg.pleaseTryAgainLater.tr(),
          ),
        ),
      ),
    ),
  );
}
