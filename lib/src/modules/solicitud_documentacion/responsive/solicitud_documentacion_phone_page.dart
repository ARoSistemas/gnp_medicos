part of '../solicitud_documentacion_page.dart';

class _SolicitudDocumentacionPhonePage extends StatelessWidget {
  _SolicitudDocumentacionPhonePage();

  final SolicitudDocumentacionController _c =
      Get.find<SolicitudDocumentacionController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhone(title: esMessages.mx.documentationRequest.value),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
        BannerMedico(
          name: _c.user.nombreCompleto,
          medicalIdentifier: _c.user.codigoFiliacion,
        ),
        SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                esMessages.mx.prepareFollowingDocumentation.value,
                style: Get.textTheme.titleLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
              Text(
                esMessages.mx.documentationFormatPDFPNG.value,
                style: Get.textTheme.titleMedium,
              ),
              SizedBox(height: context.scale(15, axis: ScaleAxis.height)),
              DownloadDocument(
                title: esMessages.mx.accessionLetter.value,
                onTap: () {},
              ),
              SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
              DownloadDocument(
                title: esMessages.mx.generalData.value,
                onTap: () {},
              ),
              SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
              DownloadDocument(
                title: esMessages.mx.paymentByTransfer.value,
                onTap: () {},
              ),
              SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
              ElevatedButton(
                onPressed: () => Get.toNamed(SolicitudUploadPhone.page.name),
                child: Text(esMessages.mx.begin.value),
              ),
              SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
              TextButton(
                onPressed: () {}, 
                child: Text(esMessages.mx.goOut.value)
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
