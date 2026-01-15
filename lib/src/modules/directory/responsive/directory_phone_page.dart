part of '../directory_page.dart';

class _DirectoryPhonePage extends StatelessWidget {
  _DirectoryPhonePage();

  final DirectoryController _c = Get.find<DirectoryController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhoneWdgt(
      title: msg.directory.tr(),
      name: _c.user.nombreCompleto,
      lastname: _c.user.apePaterno,
      rfc: _c.user.rfc,
      jwt: _c.user.token.jwt,
      medicalIdentifier: _c.user.codigoFiliacion,
    ),
    body: _c.obx(
      (state) => SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          spacing: 20,
          children: [
            /// body
            SizedBox(
              width: double.infinity,
              height: context.pHeight(80),
              child: ListView.builder(
                itemCount: _c.items.length,
                itemBuilder: (context, i) => Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: InkWell(
                    onTap: () => _c.gotoMobile(_c.items[i]),
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
