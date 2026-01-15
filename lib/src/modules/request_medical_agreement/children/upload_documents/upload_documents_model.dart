part of 'upload_documents_controller.dart';

final class _UploadDocumentsModel {
  const _UploadDocumentsModel({
    this.name = 'UploadDocuments',
  });

  _UploadDocumentsModel copyWith({
    String? name,
  }) => _UploadDocumentsModel(
    name: name ?? this.name,
  );

  final String name;
}
