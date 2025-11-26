import 'dart:convert';

FormatDto formatDtoFromJson(String str) => 
FormatDto.fromJson(json.decode(str));

String formatDtoToJson(FormatDto data) => json.encode(data.toJson());

class FormatDto {
  FormatDto({
    required this.fileName,
    required this.contentType,
    required this.size,
    required this.description,
  });

  factory FormatDto.fromJson(Map<String, dynamic> json) => FormatDto(
    fileName: json['fileName'] ?? '',
    contentType: json['contentType'] ?? '',
    size: json['size'] ?? 0,
    description: json['description'] ?? '',
  );

  factory FormatDto.empty() => FormatDto(
    fileName: '',
    contentType: '',
    size: 0,
    description: '',
  );
  
  final String fileName;
  final String contentType;
  final String description;
  final int size;

  Map<String, dynamic> toJson() => {
    'fileName': fileName,
    'contentType': contentType,
    'size': size,
    'description': description,
  };
}
