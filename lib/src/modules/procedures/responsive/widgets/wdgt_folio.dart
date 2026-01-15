import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/src/modules/procedures/domain/entities/folio_mdl.dart';

class FolioItemWdgt extends StatefulWidget {
  const FolioItemWdgt({
    required this.data,
    this.isProcedure = true,
    super.key,
  });

  final FolioSiniestro data;
  final bool isProcedure;

  @override
  State<FolioItemWdgt> createState() => _FolioItemWdgtState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<FolioSiniestro>('data', data))
      ..add(DiagnosticsProperty<bool>('isProcedure', isProcedure));
  }
}

class _FolioItemWdgtState extends State<FolioItemWdgt> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      /// Header (contraído / expandido)
      InkWell(
        onTap: () => setState(() {
          FocusScope.of(context).unfocus();
          isExpanded = !isExpanded;
        }),
        child: Container(
          color: isExpanded ? const Color(0xffF6F9FD) : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Folio del siniestro: ${widget.data.idTramite}',
                  style: const TextStyle(
                    fontSize: 15,
                    color: ColorPalette.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: ColorPalette.primary,
                size: 28,
              ),
            ],
          ),
        ),
      ),

      /// Expanded content
      if (isExpanded)
        GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _colItem(
                  widget.isProcedure
                      ? 'Nombre del Asegurado:'
                      : 'Fecha de pago:',
                  widget.data.nombreAsegurado,
                ),
                _colItem(
                  widget.isProcedure
                      ? 'Fecha del Siniestro-Folio:'
                      : 'Siniestro Asociado:',
                  widget.data.fechaSiniestro,
                ),
                _colItem(
                  widget.isProcedure
                      ? 'Padecimiento (ICD):'
                      : 'Estado del pago:',
                  widget.data.padecimiento,
                ),
                if (!widget.isProcedure)
                  const Divider(
                    color: Color(0xFFD4DBE6),
                    height: 32,
                    thickness: 1,
                  ),
                _colItem(
                  widget.isProcedure ? 'Póliza:' : 'Monto Reclamado:',
                  widget.data.poliza,
                ),
                _colItem(
                  widget.isProcedure ? 'Hospital de atención:' : 'Monto pagado',
                  widget.data.hospitalAtencion,
                ),
                _colItem(
                  widget.isProcedure ? 'Estatus:' : 'Cuenta de pago',
                  widget.data.estatus,
                ),
                if (!widget.isProcedure)
                  _colItem(
                    'Institución bancaria:',
                    widget.data.estatus,
                  ),
              ],
            ),
          ),
        ),

      /// Divider
      const Divider(
        color: Color(0xFFD4DBE6),
        height: 1,
        thickness: 1,
      ),
    ],
  );

  Widget _colItem(String label, String value) => Padding(
    padding: const EdgeInsets.only(top: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 15,
            color: ColorPalette.textSecondary,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: double.infinity,
          child: Text(
            value,
            textAlign: TextAlign.start,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              color: ColorPalette.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isExpanded', isExpanded));
  }
}
