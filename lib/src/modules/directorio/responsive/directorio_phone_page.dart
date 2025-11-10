part of '../directorio_page.dart';

class _DirectorioPhonePage extends StatelessWidget {
  _DirectorioPhonePage();

  final DirectorioController _c = Get.find<DirectorioController>();

  @override
  @override
  Widget build(BuildContext context) {
    Future<void> goto(ItemDirectoryMdl item) async {
      await Get.toNamed(
        FilterPage.page.name,
        arguments: {
          'item': item,
          'catEspecialidades': _c.catEspecialidades,
          'catCirculos': _c.catCirculos,
          'catPlanHospitalario': _c.catPlanHospitalario,
          'catClinicas': _c.catClinicas,
          'catOtrosServicios': _c.catOtrosServicios,
          'catEstados': _c.catEstados,
        },
      )?.then((result) {
        if (result != null && result is Map) {
          _c.catEspecialidades = result['catEspecialidades'];
          _c.catCirculos = result['catCirculos'];
          _c.catPlanHospitalario = result['catPlanHospitalario'];
          _c.catClinicas = result['catClinicas'];
          _c.catOtrosServicios = result['catOtrosServicios'];
        }
      });
    }

    return Scaffold(
      appBar: AppBarPhone(title: esMessages.mx.directory.value),
      body: _c.obx(
        (state) => SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            spacing: 20,
            children: [
              /// Banner
              BannerMedico(
                name: _c.user.nombreCompleto,
                medicalIdentifier: _c.user.codigoFiliacion,
              ),

              /// body
              SizedBox(
                width: double.infinity,
                height: context.pHeight(80),
                child: ListView.builder(
                  itemCount: _c.items.length,
                  itemBuilder: (context, i) => Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: InkWell(
                      onTap: () => goto(_c.items[i]),
                      child: ItemsMenuDirectory(
                        title: _c.items[i].title,
                        img: _c.items[i].img,
                        jwt: _c.jwt,
                      ),
                    ),
                  ),
                ),
              ),
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
            title: esMessages.mx.noInformationToShow.value,
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
            title: esMessages.mx.errorLoadingInfo.value,
            subtitle: esMessages.mx.pleaseTryAgainLater.value,
          ),
        ),
      ),
    );
  }
}
