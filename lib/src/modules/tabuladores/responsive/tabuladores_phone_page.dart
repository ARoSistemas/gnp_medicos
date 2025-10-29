part of '../tabuladores_page.dart';

class _TabuladoresPhonePage extends StatelessWidget {
  _TabuladoresPhonePage();

  final TabuladoresController _c = Get.find<TabuladoresController>();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBarPhone(title: esMessages.mx.tabulator.value,),
    body: Column(
      children: <Widget>[
        BannerMedico(
          name: _c.user.nombreCompleto,
          medicalIdentifier: _c.user.codigoFiliacion,
        ),
        SizedBox(height: context.scale(10, axis: ScaleAxis.height)),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField(
                items: [
                  DropdownMenuItem(
                    child: Text(
                      esMessages.mx.medicalCircle.value,
                      style: Get.textTheme.titleMedium?.copyWith(
                        color: ColorPalette.textTertiary,
                      ),
                    ),
                  ),
                ],
                onChanged: (value) {},
              ),
              SizedBox(height: context.scale(30, axis: ScaleAxis.height)),
              TextFormField(
                decoration: InputDecoration(
                  hintText: esMessages.mx.procedure.value,
                  labelText: esMessages.mx.procedure.value,
                  suffixIcon: const Icon(
                    Icons.search,
                    color: ColorPalette.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: context.scale(5, axis: ScaleAxis.height)),
              Text(
                esMessages.mx.cpts.value,
                style: Get.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: ColorPalette.textTertiary,
                ),
              ),
              SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
              Container(
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
                      esMessages.mx.cost.value,
                      style: Get.textTheme.titleMedium?.copyWith(
                        color: ColorPalette.textTertiary,
                      ),
                    ),
                    Text(
                      r'$100,000 MXN',
                      style: Get.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ColorPalette.textSecondary,
                      ),
                    ),
                    SizedBox(height: context.scale(20, axis: ScaleAxis.height)),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(esMessages.mx.consult.value),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
