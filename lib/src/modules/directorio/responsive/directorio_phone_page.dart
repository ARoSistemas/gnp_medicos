part of '../directorio_page.dart';

class _DirectorioPhonePage extends StatelessWidget {
  _DirectorioPhonePage();

  final DirectorioController _c = Get.find<DirectorioController>();

  @override
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhone(title: esMessages.mx.directory.value),
    body: SingleChildScrollView(
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
                  onTap: () async {
                    await Get.toNamed(
                      FilterPage.page.name,
                      arguments: _c.items[i],
                    );
                  },
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
  );
}
