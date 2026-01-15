part of '../request_medical_agreement_page.dart';

class _RequestMedicalAgreementPhonePage extends StatelessWidget {
  _RequestMedicalAgreementPhonePage();

  final RequestMedicalAgreementController _c =
      Get.find<RequestMedicalAgreementController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhone(title: msg.requestLog.tr()),
    body: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: BannerMedico(
            name: _c.user.nombreCompleto,
            lastname: _c.user.apePaterno,
            rfc: _c.user.rfc,
            jwt: _c.user.token.jwt,
            medicalIdentifier: _c.user.codigoFiliacion,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: SectionTitle(
            title: msg.requestLog.tr().toUpperCase(),
            widget: IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: _c.goToNewRequest,
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
                            status = StatusSolicitud.inProgress;
                          case '02':
                            status = StatusSolicitud.incompleted;
                          case '08':
                            status = StatusSolicitud.incompleted;
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
                            onTapUploadIncompleted: () => _c.getComment(
                              requestAgreement.cveSolicitud,
                            ),
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
