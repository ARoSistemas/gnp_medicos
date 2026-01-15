import 'dart:convert';

class TabulatorDto {
  TabulatorDto({
    required this.idTabulador,
    required this.dsCpt,
    required this.cpt,
    required this.tabuladorHm,
  });

  factory TabulatorDto.fromJson(String str) => 
  TabulatorDto.fromMap(json.decode(str));

  factory TabulatorDto.fromMap(Map<String, dynamic> json) => TabulatorDto(
    idTabulador: json['idTabulador'] ?? '',
    dsCpt: json['dsCpt'] ?? '',
    cpt: json['cpt'] ?? '',
    tabuladorHm: double.tryParse(json['tabuladorHm'].toString()) ?? 0.00,
  );

  String idTabulador;
  String dsCpt;
  String cpt;
  double tabuladorHm;

  TabulatorDto copyWith({
    String? idTabulador,
    String? dsCpt,
    String? cpt,
    double? tabuladorHm
  }) => TabulatorDto(
    idTabulador: idTabulador ?? this.idTabulador,
    dsCpt: dsCpt ?? this.dsCpt,
    cpt: cpt ?? this.cpt,
    tabuladorHm: tabuladorHm ?? this.tabuladorHm,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'idTabulador': idTabulador,
    'dsCpt': dsCpt,
    'cpt': cpt,
    'tabuladorHm': tabuladorHm,
  };
}
