import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../networks/endpoints.dart';
import '../model/signals_response_model.dart';

final class SignalsAPI {
  static final SignalsAPI _singleton = SignalsAPI._internal();

  SignalsAPI._internal();

  static SignalsAPI get instance => _singleton;

  Future<SignalsResponseModel> getAnalyticSignals({
    required String login,
    required String passkey,
    required List<String> pairs,
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    if (login.trim().isEmpty || passkey.trim().isEmpty || pairs.isEmpty) {
      throw ArgumentError('Login, passkey and currency pairs are required.');
    }
    if (toDate.isBefore(fromDate)) {
      throw ArgumentError.value(
        toDate,
        'toDate',
        'Must not be before fromDate',
      );
    }

    final url = ForexEndpoints.getAnalyticSignals(login);
    final queryParameters = {
      'tradingsystem': 3,
      'pairs': pairs.join(','),
      'from': _startOfDay(fromDate),
      'to': _endOfDay(toDate),
    };

    try {
      final response = await Dio().get(
        url,
        queryParameters: queryParameters,
        options: Options(headers: {'passkey': passkey}),
      );
      return SignalsResponseModel.fromJson(response.data);
    } on DioException catch (error) {
      log('Signals API status: ${error.response?.statusCode}');
      log('Signals API error: ${error.response?.data ?? error.message}');
      rethrow;
    } catch (error) {
      log('Signals API error: $error');
      rethrow;
    }
  }

  int _startOfDay(DateTime date) =>
      DateTime(date.year, date.month, date.day).millisecondsSinceEpoch ~/ 1000;

  int _endOfDay(DateTime date) =>
      DateTime(
        date.year,
        date.month,
        date.day,
        23,
        59,
        59,
      ).millisecondsSinceEpoch ~/
      1000;
}
