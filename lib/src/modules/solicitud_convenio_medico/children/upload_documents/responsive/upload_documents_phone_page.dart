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
          medicalIdentifier: _c.user.codigoFiliacion,
        ),
        SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() =>
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        esMessages.mx.prepareFollowingDocumentation.value,
                        style: Get.textTheme.titleLarge?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        esMessages.mx.documentationFormatPDFPNG.value,
                        style: Get.textTheme.titleMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    CardDocumentUpload(
                      loading: _c.loading.value,
                      title: esMessages.mx.accessionLetter.value,
                      onTap: () => _c.downloadFormato('Carta_de_adhesion.pdf'),
                    ),
                    CardDocumentUpload(
                      loading: _c.loading.value,
                      title: esMessages.mx.generalData.value,
                      onTap: () {},
                    ),
                    CardDocumentUpload(
                      loading: _c.loading.value,
                      title: esMessages.mx.paymentByTransfer.value,
                      onTap: () => _c.downloadFormato(
                        'Formato_de_alta_para_pago_por_transferencia.pdf'
                      ),
                    ),
                    ..._c.documentCardsWithoutOnTap.map(
                      (data) => CardDocumentUpload(
                        loading: _c.loading.value,
                        title: data['title']!,
                        description: data['description'],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async{
                        if (idSolicitud != null) {
                          await Get.toNamed(
                            RequestDocumentsPage.page.name,
                            arguments: idSolicitud,
                          );
                        }
                      },
                      child: Text(esMessages.mx.begin.value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 30),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(esMessages.mx.goOut.value),
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
