import 'dart:convert';

FormatDto formatDtoFromJson(String str) => 
FormatDto.fromJson(json.decode(str));

String formatDtoToJson(FormatDto data) => json.encode(data.toJson());

class FormatDto {
  FormatDto({
    required this.fileName,
    required this.contentType,
    required this.size,
  });

  factory FormatDto.fromJson(Map<String, dynamic> json) => FormatDto(
    fileName: json['fileName'] ?? '',
    contentType: json['contentType'] ?? '',
    size: json['size'] ?? 0,
  );

  factory FormatDto.empty() => FormatDto(
    fileName: '',
    contentType: '',
    size: 0
  );
  
  final String fileName;
  final String contentType;
  final int size;

  Map<String, dynamic> toJson() => {
    'fileName': fileName,
    'contentType': contentType,
    'size': size,
  };
}
