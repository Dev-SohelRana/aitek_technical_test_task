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
