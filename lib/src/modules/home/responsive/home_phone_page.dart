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
                msg.welcomeHome.value,
                style: Get.textTheme.titleMedium,
              ),
            ),
            Text(
              msg.selectProfile.value,
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
                        title: msg.myProfile.value.toUpperCase(),
                      ),
                    ),
                    ItemAssitants(
                      name: _c.appState.user.nombreCompleto,
                      subTitle: _c.appState.user.especialidad,
                      urlPhoto: '',
                      onTap: _c.selectprofile,
                    ),
                  ],
                ),
              ),

            /// Lista de Asistentes
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: SectionTitle(
                title: msg.myAccess.value.toUpperCase(),
              ),
            ),
            Expanded(
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
        onEmpty: Scaffold(
          appBar: AppBarPhone(
            elevation: 8,
            title: msg.back.value,
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
                msg.noInvitation.value,
                style: Get.textTheme.titleMedium,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
        onError: (_) => Center(
          child: LoadingGnp(
            icon: const Icon(
              Icons.error,
              size: 70,
              color: ColorPalette.primary,
            ),
            title: msg.errorLoadingInvites.value,
            subtitle: msg.pleaseTryAgainLater.value,
          ),
        ),
        onLoading: const Center(child: LoadingGnp()),
      ),
    ),
  );
}
