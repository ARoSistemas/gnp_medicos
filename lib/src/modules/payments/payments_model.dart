part of 'payments_controller.dart';

final class _PaymentsModel {
  const _PaymentsModel({
    this.name = 'Mis Pagos',
  });

  _PaymentsModel copyWith({
    String? name,
  }) => _PaymentsModel(
    name: name ?? this.name,
  );

  final String name;
}
