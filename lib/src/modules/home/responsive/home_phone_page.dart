part of '../home_page.dart';

class _HomePhonePage extends StatelessWidget {
  _HomePhonePage();

  final HomeController _c = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
      child: _c.obx(
        (state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80, bottom: 20),
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

            /// Mi Perfil como doctor
            if (_c.andIsDoctor.value)
              SizedBox(
                width: double.infinity,
                height: context.scale(160, axis: ScaleAxis.height),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
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

            /// Lista de Asistentes
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: SectionTitle(
                title: msg.myAccess.tr().toUpperCase(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: state?.asisstantList.length,
                itemBuilder: (context, i) {
                  final AsisstantDto item =
                      state?.asisstantList[i] ?? AsisstantDto.empty();
                  return ItemAssitants(
                    name:
                        '${item.nombre} '
                        '${item.apellidoPaterno} '
                        '${item.apellidoMaterno}',
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
        onLoading: const Center(child: LoadingGnp()),
        onEmpty: Scaffold(
          appBar: AppBarPhone(
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
