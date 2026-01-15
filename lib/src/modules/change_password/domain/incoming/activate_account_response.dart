import 'dart:convert';

class ActivateAccountResponse {
  ActivateAccountResponse({
    required this.code,
    required this.message,
    required this.payload,
  });

  factory ActivateAccountResponse.fromRawJson(String str) =>
      ActivateAccountResponse.fromJson(
        json.decode(str),
      );

  factory ActivateAccountResponse.fromJson(Map<String, dynamic> json) =>
      ActivateAccountResponse(
        code: json['code'],
        message: json['message'],
        payload: json['payload'],
      );
  final int code;
  final String message;
  final String payload;
}
