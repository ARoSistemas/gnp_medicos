part of '../upload_documents_page.dart';

class _UploadDocumentsPhonePage extends StatelessWidget {
  _UploadDocumentsPhonePage();

  final UploadDocumentsController _c = Get.find<UploadDocumentsController>();
  final String? idSolicitud = Get.arguments is String
      ? Get.arguments as String
      : null;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: const AppBarPhone(title: 'Documentación necesaria'),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
        BannerMedico(
          name: _c.user.nombreCompleto,
          lastname: _c.user.apePaterno,
          rfc: _c.user.rfc,
          jwt: _c.user.token.jwt,
          medicalIdentifier: _c.user.codigoFiliacion,
        ),
        SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        msg.prepareFollowingDocumentation.tr(),
                        style: Get.textTheme.titleLarge?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        msg.documentationFormatPDFPNG.tr(),
                        style: Get.textTheme.titleMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                    ..._c.files.map(
                      (data) => CardDocumentUpload(
                        downloading: _c.downloading.value == data['file'],
                        title: data['title'].toString(),
                        onTap: () => _c.downloadFormat(data['file'].toString()),
                      ),
                    ),

                    ..._c.documentCardsWithoutOnTap.map(
                      (data) => CardDocumentUpload(
                        title: data['title']!,
                        description: data['description'],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (idSolicitud != null) {
                          await Get.toNamed(
                            RequestDocumentsPage.page.name,
                            arguments: idSolicitud,
                          );
                        }
                      },
                      child: Text(msg.begin.tr()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 30),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(msg.goOut.tr()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('idSolicitud', idSolicitud));
  }
}
