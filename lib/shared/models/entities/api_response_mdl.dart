// import 'dart:convert';

// class ApiResponse {
//   ApiResponse({
//     required this.code,
//     required this.msg,
//     required this.data,
//     required this.isSuccess,
//     this.bodyBytes,
//   });

//   factory ApiResponse.fromRaw(String raw) =>
//       ApiResponse.fromMap(jsonDecode(raw));

//   factory ApiResponse.fromMap(Map<String, dynamic> json) {
//     final int code = json['code'] ?? 0;
//     return ApiResponse(
//       code: code,
//       msg: json['message'] ?? '',
//       data: json['payload'] ?? '',
//       isSuccess: code >= 200 && code <= 299,
//       bodyBytes: json['bodyBytes'],
//     );
//   }

//   factory ApiResponse.empty() =>
//       ApiResponse(code: 0, msg: '', data: '', isSuccess: false);

//   ApiResponse copyWith({
//     int? code,
//     String? msg,
//     String? data,
//     bool? isSuccess,
//     Stream<List<int>>? bodyBytes,
//   }) => ApiResponse(
//     code: code ?? this.code,
//     msg: msg ?? this.msg,
//     data: data ?? this.data,
//     isSuccess: isSuccess ?? this.isSuccess,
//     bodyBytes: bodyBytes ?? this.bodyBytes,
//   );

//   final int code;
//   final String msg;
//   final String data;
//   final bool isSuccess;
//   final Stream<List<int>>? bodyBytes;
// }

// /// Para manejar éxito/error usando .when o un switch.
// sealed class NetworkResult<T> {
//   const NetworkResult();
// }

// class Success<T> extends NetworkResult<T> {
//   const Success(this.data);
//   final T data;
// }

// class Failure<T> extends NetworkResult<T> {
//   const Failure(this.message);
//   final String message;
// }
