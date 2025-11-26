import 'dart:convert';

class AnnexesDto {
  AnnexesDto({
    required this.id,
    required this.fileName,
    required this.contentType,
    required this.size,
    required this.description,
  });

  factory AnnexesDto.fromJson(String str) =>
      AnnexesDto.fromMap(json.decode(str));

  factory AnnexesDto.fromMap(Map<String, dynamic> json) => AnnexesDto(
    id: json['id'] ?? '',
    fileName: json['fileName'] ?? '',
    contentType: json['contentType'] ?? '',
    size: json['size'] ?? 0,
    description: json['description'] ?? '',
  );

  String id;
  String fileName;
  String contentType;
  int size;
  String description;

  AnnexesDto copyWith({
    String? id,
    String? fileName,
    String? contentType,
    int? size,
    String? description,
  }) => AnnexesDto(
    id: id ?? this.id,
    fileName: fileName ?? this.fileName,
    contentType: contentType ?? this.contentType,
    size: size ?? this.size,
    description: description ?? this.description,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'id': id,
    'fileName': fileName,
    'contentType': contentType,
    'size': size,
    'description': description,
  };
}
