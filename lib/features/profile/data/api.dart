import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../networks/endpoints.dart';
import '../model/profile_model.dart';

class ProfileAPI {
  final Dio _dio;

  ProfileAPI({Dio? dio}) : _dio = dio ?? Dio();

  Future<ProfileModel> getProfile({
    required String login,
    required String token,
  }) async {
    final parsedLogin = int.tryParse(login);
    if (parsedLogin == null) {
      throw FormatException('Peanut login must be numeric', login);
    }
    if (token.isEmpty) {
      throw ArgumentError.value(token, 'token', 'Must not be empty');
    }

    final requestBody = {'login': parsedLogin, 'token': token};
    final accountResponse = await _post(
      operation: 'GetAccountInformation',
      url: ForexEndpoints.getAccountInformation(),
      data: requestBody,
      token: token,
    );
    final accountData = _asJsonMap(accountResponse.data);
    if (accountData.isEmpty) {
      throw const ProfileApiException(
        operation: 'GetAccountInformation',
        serverMessage: 'The profile service returned no profile data.',
      );
    }

    String? phone;
    try {
      final phoneResponse = await _post(
        operation: 'GetLastFourNumbersPhone',
        url: ForexEndpoints.getLastFourNumbersPhone(),
        data: requestBody,
        token: token,
      );
      final responsePhone = _asString(phoneResponse.data);
      if (responsePhone.isEmpty) {
        throw const FormatException('Phone response was empty');
      }
      phone = responsePhone;
    } on ProfileApiException catch (error) {
      log('Profile phone loading failed: ${error.message}');
    } on FormatException catch (error) {
      log('Profile phone response was invalid: $error');
    }

    return ProfileModel.fromJson(json: accountData, login: login, phone: phone);
  }

  Future<Response<dynamic>> _post({
    required String operation,
    required String url,
    required Map<String, Object> data,
    required String token,
  }) async {
    try {
      return await _dio.post(
        url,
        data: data,
        options: Options(
          contentType: 'application/json-patch+json',
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
    } on DioException catch (error) {
      throw ProfileApiException(
        operation: operation,
        statusCode: error.response?.statusCode,
        serverMessage: _responseMessage(error.response?.data),
      );
    }
  }

  String? _responseMessage(dynamic value) {
    if (value is String) {
      final message = value.trim();
      if (message.isEmpty) return null;
      try {
        final decoded = jsonDecode(message);
        if (decoded is String) return decoded.trim();
        if (decoded is Map) return _responseMessage(decoded);
      } on FormatException {
        return message;
      }
      return message;
    }
    if (value is Map) {
      for (final entry in value.entries) {
        if ([
          'message',
          'error',
          'title',
          'detail',
        ].contains(entry.key.toString().toLowerCase())) {
          final message = entry.value?.toString().trim();
          if (message != null && message.isNotEmpty) return message;
        }
      }
    }
    return null;
  }

  Map<String, dynamic> _asJsonMap(dynamic value) {
    final decoded = value is String ? jsonDecode(value) : value;
    if (decoded is Map<String, dynamic>) return decoded;
    if (decoded is Map) return Map<String, dynamic>.from(decoded);
    throw const FormatException('Account response was not a JSON object');
  }

  String _asString(dynamic value) {
    final decoded = value is String ? value : value?.toString();
    return decoded?.trim() ?? '';
  }
}

class ProfileApiException implements Exception {
  const ProfileApiException({
    required this.operation,
    this.statusCode,
    this.serverMessage,
  });

  final String operation;
  final int? statusCode;
  final String? serverMessage;

  String get message {
    if (serverMessage != null) return serverMessage!;
    if (statusCode != null) {
      return '$operation returned HTTP $statusCode.';
    }
    return '$operation could not be reached. Check your internet connection.';
  }
}
