part of '../assistants_page.dart';

class _AssistantsPhonePage extends StatelessWidget {
  _AssistantsPhonePage();

  final AssistantsController _c = Get.find<AssistantsController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhoneWdgt(
      title: msg.assistants.tr(),
      name: _c.user.nombreCompleto,
      lastname: _c.user.apePaterno,
      rfc: _c.user.rfc,
      jwt: _c.user.token.jwt,
      medicalIdentifier: _c.user.codigoFiliacion,
    ),
    body: _c.obx(
      (state) => Column(
        children: [
          /// Body
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsetsGeometry.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              itemCount: state!.assistants.length,
              itemBuilder: (context, i) => CardAsistente(
                onPressed: () async {
                  await _c.onOffAssistant(
                    assistant: state.assistants[i],
                  );
                },
                assistant: state.assistants[i],
                onRefresh: () async {
                  await _c.getAssistant(_c.user.codigoFiliacion);
                },
              ),
            ),
          ),

          /// Footer
          SafeArea(
            child: Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: _c.addAssistant,
                child: Text(msg.addAssistant.tr()),
              ),
            ),
          ),
        ],
      ),
      onLoading: const Center(child: LoadingGnp()),
      onEmpty: Center(
        child: LoadingGnp(
          title: msg.noAssistantsToShow.tr(),
          icon: const Icon(
            Icons.warning,
            size: 70,
            color: ColorPalette.primary,
          ),
        ),
      ),
      onError: (_) => Center(
        child: LoadingGnp(
          isError: true,
          title: msg.errorLoadingAssistants.tr(),
          subtitle: msg.pleaseTryAgainLater.tr(),
        ),
      ),
    ),
  );
}
