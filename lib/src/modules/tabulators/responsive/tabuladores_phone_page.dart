part of '../tabulators_page.dart';

class _TabuladoresPhonePage extends StatelessWidget {
  _TabuladoresPhonePage();

  final TabulatorsController _c = Get.find<TabulatorsController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhoneWdgt(
      title: msg.tabulator.tr(),
      name: _c.user.nombreCompleto,
      lastname: _c.user.apePaterno,
      rfc: _c.user.rfc,
      jwt: _c.user.token.jwt,
      medicalIdentifier: _c.user.codigoFiliacion,
    ),
    body: _c.obx(
      (state) => Form(
        key: _c.formKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  spacing: context.scale(30, axis: ScaleAxis.height),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField(
                      initialValue: _c.estadoSelected,
                      focusColor: ColorPalette.white,
                      decoration: InputDecoration(
                        labelText: msg.state.tr(),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                      items: state?.estadosCat
                          .map(
                            (estado) => DropdownMenuItem(
                              value: estado,
                              child: Text(
                                estado.estado,
                                style: Get.textTheme.titleMedium?.copyWith(
                                  color: ColorPalette.textTertiary,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: _c.onChangeEstado,
                      validator: Validators.optionObject,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),

                    Obx(
                      () => DropdownButtonFormField(
                        initialValue: _c.municipioSelected.value,
                        focusColor: ColorPalette.white,
                        decoration: InputDecoration(
                          labelText: msg.municipality.tr(),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        items: _c.municipios.value
                            .map(
                              (municipio) => DropdownMenuItem(
                                value: municipio,
                                child: Text(
                                  municipio,
                                  style: Get.textTheme.titleMedium?.copyWith(
                                    color: ColorPalette.textTertiary,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: _c.onChangeMunicipio,
                        validator: Validators.optionObject,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),

                    DropdownButtonFormField(
                      initialValue: _c.circuloSelected,
                      focusColor: ColorPalette.white,
                      decoration: InputDecoration(
                        labelText: msg.medicalCircleTab.tr(),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                      items: state?.circulosCat
                          .map(
                            (estado) => DropdownMenuItem(
                              value: estado,
                              child: Text(
                                estado.circuloMedico,
                                style: Get.textTheme.titleMedium?.copyWith(
                                  color: ColorPalette.textTertiary,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: _c.onChangeCirculo,
                      validator: Validators.optionObject,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    searchInput(context),
                    SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                  ],
                ),
              ),
            ),
            Obx(() => costoCpt(context)),
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

  Widget searchInput(BuildContext context) => Stack(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _c.cptController,
            decoration: InputDecoration(
              hintText: msg.procedure.tr(),
              labelText: msg.procedure.tr(),
              suffixIcon: const Icon(
                Icons.search,
                color: ColorPalette.textSecondary,
              ),
            ),
            validator: Validators.option,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: _c.onType,
          ),
          SizedBox(
            height: context.scale(5, axis: ScaleAxis.height),
          ),
          Text(
            msg.cpts.tr(),
            style: Get.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w400,
              color: ColorPalette.textTertiary,
            ),
          ),
          info(context),
        ],
      ),
      Obx(
        () => _c.tabuladores.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 60),
                child: cptList(context),
              )
            : const SizedBox.shrink(),
      ),
    ],
  );

  Widget costoCpt(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 25,
    ),
    decoration: const BoxDecoration(
      color: ColorPalette.backgroundCardBanner,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          msg.cost.tr(),
          style: Get.textTheme.titleMedium?.copyWith(
            color: ColorPalette.textTertiary,
          ),
        ),
        Text(
          '${Tools().formatMXN(_c.costo.value)} MXN',
          style: Get.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w400,
            color: ColorPalette.textSecondary,
          ),
        ),
        SizedBox(
          height: context.scale(20, axis: ScaleAxis.height),
        ),
        ElevatedButton(
          onPressed: _c.onSearch,
          child: _c.isSearch.value
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(msg.consult.tr()),
        ),
      ],
    ),
  );

  Widget cptList(BuildContext context) => SizedBox(
    height: context.pHeight(20),
    child: Card(
      margin: EdgeInsets.zero,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _c.tabuladores
              .map(
                (tab) => ListTile(
                  title: Text(
                    tab.dsCpt,
                    style: Get.textTheme.titleMedium?.copyWith(
                      color: ColorPalette.textTertiary,
                    ),
                  ),
                  onTap: () => _c.onSelectTabulator(tab),
                ),
              )
              .toList(),
        ),
      ),
    ),
  );

  Widget info(BuildContext context) => Container(
    margin: const EdgeInsets.only(top: 24),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: ColorPalette.backgroundCardTwo,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.info_outline, color: ColorPalette.iconBlue),
        Flexible(
          child: Text(
            'El costo del tabulador varía según la zona de '
            'atención y se determina conforme'
            ' al círculo/tabulador médico contratado por el asegurado.',
            style: context.textTheme.titleMedium?.copyWith(
              color: ColorPalette.textSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    ),
  );
}
