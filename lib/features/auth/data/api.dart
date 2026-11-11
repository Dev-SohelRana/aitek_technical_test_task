import 'dart:convert';
import 'dart:developer';

import 'package:aitek_task/features/auth/model/authentication_response_model.dart';
import 'package:aitek_task/networks/endpoints.dart';
import 'package:aitek_task/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class AuthenticationApi {
  static final AuthenticationApi _singleton = AuthenticationApi._internal();

  AuthenticationApi._internal();

  static AuthenticationApi get instance => _singleton;

  Future<AuthenticationResponseModel> authenticationApi({
    required String login,
    required String password,
  }) async {
    final url = ForexEndpoints.isAccountCredentialsCorrect();

    try {
      final data = {"login": int.parse(login), "password": password};

      log('Peanut API URL: $url');

      Response response = await Dio().post(
        url,
        data: data,
        options: Options(contentType: 'application/json-patch+json'),
      );

      if (response.statusCode == 200) {
        return AuthenticationResponseModel.fromJson(
          response.data is String
              ? json.decode(response.data)
              : Map<String, dynamic>.from(response.data),
        );
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } on DioException catch (error) {
      log('Peanut Status: ${error.response?.statusCode}');
      log('Peanut Error: ${error.response?.data}');
      rethrow;
    } catch (error) {
      log('Peanut Error: $error');
      rethrow;
    }
  }

  Future<String> partnerTokenApi({
    required String login,
    required String password,
  }) async {
    final url = ForexEndpoints.requestMobileCabinetApiToken();

    try {
      final data = {"login": int.parse(login), "password": password};

      log('Partner API URL: $url');

      Response response = await Dio().post(url, data: data);

      if (response.statusCode == 200) {
        return response.data.toString().trim();
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } on DioException catch (error) {
      log('Partner Status: ${error.response?.statusCode}');
      log('Partner Error: ${error.response?.data}');
      rethrow;
    } catch (error) {
      log('Partner Error: $error');
      rethrow;
    }
  }
}

// import 'dart:developer';

// import 'package:aitek_task/features/auth/model/authentication_response_model.dart';
// import 'package:aitek_task/networks/endpoints.dart';
// import 'package:aitek_task/networks/exception_handler/data_source.dart';
// import 'package:dio/dio.dart';

// final class AuthenticationApi {
//   static final AuthenticationApi _singleton = AuthenticationApi._internal();

//   AuthenticationApi._internal();

//   static AuthenticationApi get instance => _singleton;

//   Future<AuthenticationResponseModel> authenticationApi({
//     required String login,
//     required String password,
//   }) async {
//     final url = ForexEndpoints.isAccountCredentialsCorrect();

//     try {
//       final data = {"login": int.parse(login), "password": password};

//       log('Peanut API URL: $url');

//       Response response = await Dio().post(
//         url,
//         data: data,
//         options: Options(contentType: 'application/json-patch+json'),
//       );

//       log('Peanut Response: ${response.data}');

//       if (response.statusCode == 200) {
//         return AuthenticationResponseModel.fromJson(response.data);
//       } else {
//         throw DataSource.DEFAULT.getFailure();
//       }
//     } on DioException catch (error) {
//       log('Peanut Error Status: ${error.response?.statusCode}');
//       log('Peanut Error Response: ${error.response?.data}');
//       rethrow;
//     } catch (error) {
//       log('Peanut Error: $error');
//       rethrow;
//     }
//   }

//   Future<String> partnerTokenApi({
//     required String login,
//     required String password,
//   }) async {
//     try {
//       Map<String, dynamic> data = {
//         "login": int.parse(login),
//         "password": password,
//       };

//       Response response = await Dio().post(
//         ForexEndpoints.requestMobileCabinetApiToken(),
//         data: data,
//       );

//       log('Partner API URL: ${ForexEndpoints.requestMobileCabinetApiToken()}');
//       log('Partner Token: ${response.data}');

//       if (response.statusCode == 200) {
//         return response.data.toString().trim();
//       } else {
//         throw DataSource.DEFAULT.getFailure();
//       }
//     } catch (error) {
//       rethrow;
//     }
//   }
///////////////////
// Future<AuthenticationResponseModel> authenticationApi({
//   required String login,
//   required String password,
// }) async {
//   try {
//     Map<String, dynamic> data = {"login": login, "password": password};

//     Response response = await Dio().post(
//       ForexEndpoints.isAccountCredentialsCorrect(),
//       data: data,
//     );
//     log('Peanut API URL: ${ForexEndpoints.isAccountCredentialsCorrect()}');
//     if (response.statusCode == 200) {
//       return AuthenticationResponseModel.fromRawJson(
//         response.data is String ? response.data : response.data.toString(),
//       );
//     } else {
//       throw DataSource.DEFAULT.getFailure();
//     }
//   } catch (error) {
//     rethrow;
//   }
// }

// Future<AuthenticationResponseModel> partnerTokenApi({
//   required String login,
//   required String password,
// }) async {
//   try {
//     Map<String, dynamic> data = {"login": login, "password": password};

//     Response response = await Dio().post(
//       ForexEndpoints.requestMobileCabinetApiToken(),
//       data: data,
//     );
//     final url = ForexEndpoints.requestMobileCabinetApiToken();

//     log('Partner API URL: $url');

//     if (response.statusCode == 200) {
//       return AuthenticationResponseModel.fromRawJson(
//         response.data is String ? response.data : response.data.toString(),
//       );
//     } else {
//       throw DataSource.DEFAULT.getFailure();
//     }
//   } on DioException catch (error) {
//     log('Partner Failed URL: ${error.requestOptions.uri}');
//     log('Partner Error Status: ${error.response?.statusCode}');
//     log('Partner Error Response: ${error.response?.data}');
//     rethrow;
//   }
// }
// }
