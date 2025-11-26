part of '../assistants_page.dart';

class _AssistantsPhonePage extends StatelessWidget {
  _AssistantsPhonePage();

  final AssistantsController _c = Get.find<AssistantsController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhoneWdgt(
      title: msg.assistants.value,
      name: _c.user.nombreCompleto,
      medicalIdentifier: _c.user.codigoFiliacion,
    ),
    body: _c.obx(
      (data) => Column(
        children: [
          /// Body
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsetsGeometry.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              itemCount: data!.assistants.length,
              itemBuilder: (context, i) => CardAsistente(
                onPressed: () async {
                  Get.back();
                  await _c.onOffAssistant(
                    assistant: data.assistants[i],
                  );
                },
                assistant: data.assistants[i],
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
                child: Text(msg.addAssistant.value),
              ),
            ),
          ),
        ],
      ),
      onEmpty: Center(
        child: LoadingGnp(
          title: msg.noAssistantsToShow.value,
          icon: const Icon(
            Icons.warning,
            size: 70,
            color: ColorPalette.primary,
          ),
        ),
      ),
      onError: (_) => Center(
        child: LoadingGnp(
          title: msg.errorLoadingAssistants.value,
          subtitle: msg.pleaseTryAgainLater.value,
          icon: const Icon(
            Icons.error,
            size: 70,
            color: ColorPalette.primary,
          ),
        ),
      ),
      onLoading: const Center(child: LoadingGnp()),
    ),
  );
}
