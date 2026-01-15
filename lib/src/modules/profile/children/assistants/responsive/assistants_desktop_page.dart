part of '../assistants_page.dart';

class _AssistantsDesktopPage extends StatelessWidget {
  _AssistantsDesktopPage();

  final AssistantsController _c = Get.find<AssistantsController>();

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SectionTitle(
        title: msg.myUsers.tr().toUpperCase(),
        widget: TextButton(
          style: Get.theme.textButtonTheme.style?.copyWith(
            minimumSize: WidgetStateProperty.all(const Size(0, 48)),
          ),
          onPressed: _c.addAssistant,
          child: Row(
            spacing: 8,
            children: [
              Text(
                msg.newUser.tr(),
                style: Get.textTheme.titleMedium?.copyWith(
                  color: ColorPalette.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Icon(
                Icons.add,
                color: ColorPalette.primary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
      SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
      _c.obx(
        (state) => LayoutBuilder(
          builder: (context, constraints) {
            final int crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
            final double childAspectRatio = crossAxisCount == 2
                ? constraints.maxWidth * 0.0058
                : constraints.maxWidth * 0.01;
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              childAspectRatio: childAspectRatio,
              crossAxisSpacing: 16,
              children: state!.assistants
                  .map(
                    (assist) => CardAsistente(
                      onPressed: () async {
                        await _c.onOffAssistant(
                          assistant: assist,
                        );
                      },
                      assistant: assist,
                      onRefresh: () async {
                        await _c.getAssistant(_c.user.codigoFiliacion);
                      },
                    ),
                  )
                  .toList(),
            );
          },
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
    ],
  );
}
