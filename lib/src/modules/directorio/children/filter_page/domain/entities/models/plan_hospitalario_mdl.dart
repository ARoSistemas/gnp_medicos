import 'dart:convert';

class PlanHospitalarioMdl {
  PlanHospitalarioMdl({
    required this.clavePlan,
    required this.plan,
  });

  factory PlanHospitalarioMdl.fromJson(String str) =>
      PlanHospitalarioMdl.fromMap(json.decode(str));

  factory PlanHospitalarioMdl.fromMap(Map<String, dynamic> json) =>
      PlanHospitalarioMdl(
        clavePlan: json['clavePlan'] ?? '',
        plan: json['plan'] ?? '',
      );

  factory PlanHospitalarioMdl.empty() => PlanHospitalarioMdl(
    clavePlan: '',
    plan: '',
  );

  String clavePlan;
  String plan;

  PlanHospitalarioMdl copyWith({
    String? clavePlan,
    String? plan,
  }) => PlanHospitalarioMdl(
    clavePlan: clavePlan ?? this.clavePlan,
    plan: plan ?? this.plan,
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    'clavePlan': clavePlan,
    'plan': plan,
  };
}
