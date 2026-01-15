part of 'view_pdf_controller.dart';

final class _ViewPdfModel {
  const _ViewPdfModel({
    this.name = 'ViewPdf',
  });

  _ViewPdfModel copyWith({
    String? name,
  }) => _ViewPdfModel(
    name: name ?? this.name,
  );

  final String name;
}
