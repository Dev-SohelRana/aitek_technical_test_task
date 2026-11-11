class AuthenticationResponseModel {
  bool? result;
  String? token;

  AuthenticationResponseModel({this.result, this.token});

  factory AuthenticationResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationResponseModel(
      result: json['result'],
      token: json['token'],
    );
  }
}

// class AuthenticationResponseModel {
//   bool? result;
//   String? token;

//   AuthenticationResponseModel({this.result, this.token});

//   factory AuthenticationResponseModel.fromJson(Map<String, dynamic> json) {
//     return AuthenticationResponseModel(
//       result: json['result'],
//       token: json['token'],
//     );
//   }
// }

// import 'dart:convert';

// class AuthenticationResponseModel {
//   dynamic data;
//   String? message;
//   bool? success;

//   AuthenticationResponseModel({this.data, this.message, this.success});

//   factory AuthenticationResponseModel.fromRawJson(String str) =>
//       AuthenticationResponseModel.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory AuthenticationResponseModel.fromJson(Map<String, dynamic> json) =>
//       AuthenticationResponseModel(
//         data: json["data"],
//         message: json["message"],
//         success: json["success"],
//       );

//   Map<String, dynamic> toJson() => {
//     "data": data,
//     "message": message,
//     "success": success,
//   };
// }
