// To parse this JSON data, do
//
//     final benefitDto = benefitDtoFromJson(jsonString);

import 'dart:convert';

class BenefitDto {
  BenefitDto({
    required this.id,
    required this.fileName,
    required this.contentType,
    required this.size,
  });

  factory BenefitDto.fromJson(Map<String, dynamic> json) => BenefitDto(
    id: json['id'] ?? '',
    fileName: json['fileName'] ?? '',
    contentType: json['contentType'] ?? '',
    size: json['size'] ?? 0,
  );

  factory BenefitDto.empty() => BenefitDto(
    id: '',
    fileName: '',
    contentType: '',
    size: 0,
  );

  BenefitDto benefitDtoFromJson(String str) =>
      BenefitDto.fromJson(json.decode(str));

  String benefitDtoToJson(BenefitDto data) => json.encode(
    data.toJson(),
  );

  final String id;
  final String fileName;
  final String contentType;
  final int size;

  Map<String, dynamic> toJson() => {
    'id': id,
    'fileName': fileName,
    'contentType': contentType,
    'size': size,
  };
}
