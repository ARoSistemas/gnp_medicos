import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medicos/shared/messages/i_app_messages.dart';
import 'package:medicos/shared/utils/colors/color_palette.dart';
import 'package:medicos/src/modules/payments/domain/entities/payment.dart';

class PaymentItemWidget extends StatefulWidget {
  const PaymentItemWidget({
    required this.data,
    this.isProcedure = true,
    super.key,
  });

  final Payment data;
  final bool isProcedure;

  @override
  State<PaymentItemWidget> createState() => _PaymentItemWidgetState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Payment>('data', data))
      ..add(DiagnosticsProperty<bool>('isProcedure', isProcedure));
  }
}

class _PaymentItemWidgetState extends State<PaymentItemWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) => Column(
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
                  'Pago: ${widget.data.siniestroAsociado}',
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
                  msg.paymentDate.tr(),
                  widget.data.fechaPago.toString(),
                ),
                _colItem(
                  msg.associatedIncident.tr(),
                  widget.data.siniestroAsociado,
                ),
                _colItem(msg.paymentStatus.tr(), widget.data.desEstadoPago),
                const Divider(
                  color: Color(0xFFD4DBE6),
                  height: 32,
                  thickness: 1,
                ),

                _colItem(
                  msg.amountClaimed.tr(),
                  '\$${widget.data.montoReclamado.toStringAsFixed(2)}'
                ),
                _colItem(
                  msg.amountPaid.tr(),
                  '\$${widget.data.montoPagado.toStringAsFixed(2)}'
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
        const SizedBox(height: 4),
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
