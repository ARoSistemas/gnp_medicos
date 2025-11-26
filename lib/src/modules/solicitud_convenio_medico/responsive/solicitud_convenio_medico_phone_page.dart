part of '../solicitud_convenio_medico_page.dart';

class _SolicitudConvenioMedicoPhonePage extends StatelessWidget {
  _SolicitudConvenioMedicoPhonePage();

  final SolicitudConvenioMedicoController _c =
      Get.find<SolicitudConvenioMedicoController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhone(title: esMessages.mx.requestLog.value),
    body: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: BannerMedico(
            name: _c.user.nombreCompleto,
            medicalIdentifier: _c.user.codigoFiliacion,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: SectionTitle(
            title: esMessages.mx.requestLog.value.toUpperCase(),
            widget: IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: () => Get.toNamed(NuevaSolicitudPage.page.name),
              icon: const Icon(Icons.add, color: ColorPalette.primary),
            ),
          ),
        ),
        Expanded(
          child: Obx(
            () => Column(
              children: [
                if (_c.isLoading.value)
                  const Center(
                    child: CircularProgressIndicator(
                      color: ColorPalette.primary,
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      shrinkWrap: true,
                      itemCount: _c.requestsAgreement.length,
                      itemBuilder: (context, index) {
                        final SolicitudModel requestAgreement =
                            _c.requestsAgreement[index];
                        StatusSolicitud status;
                        switch (requestAgreement.cveEstatus) {
                          case '01':
                            status = StatusSolicitud.success;
                          case '02':
                            status = StatusSolicitud.error;
                          default:
                            status = StatusSolicitud.success;
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: CardSolicitud(
                            nameDoctor: requestAgreement.nombreMedico,
                            dateRequest: requestAgreement.fechaSolicitud,
                            status: status,
                            descriptionStatus:
                                requestAgreement.descripcionEstatus,
                            folio: requestAgreement.cveSolicitud,
                            onTapUpload: () async {
                              await Get.toNamed(
                                UploadDocumentsPage.page.name,
                                arguments: requestAgreement.cveSolicitud,
                              );
                              await _c.getRequestsAgreement();
                            },
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
