import 'dart:developer';

import 'package:aitek_task/constants/app_constants.dart';
import 'package:aitek_task/features/signals/data/api.dart';
import 'package:aitek_task/features/signals/model/signal_model.dart';
import 'package:aitek_task/features/signals/model/signals_response_model.dart';
import 'package:aitek_task/helpers/di.dart';
import 'package:aitek_task/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class SignalsRX extends RxResponseInt<SignalsResponseModel> {
  SignalsRX({required super.empty, required super.dataFetcher});

  final SignalsAPI _signalsAPI = SignalsAPI.instance;

  final RxBool isLoading = false.obs;
  final RxBool hasLoaded = false.obs;
  final RxList<SignalModel> signals = <SignalModel>[].obs;
  final RxnString errorMessage = RxnString();

  Future<void> getSignals({
    required List<String> pairs,
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    if (isLoading.value) return;

    isLoading.value = true;
    hasLoaded.value = false;
    errorMessage.value = null;
    signals.clear();

    try {
      final login = appData.read(kKeyPeanutLogin)?.toString();
      final passkey = appData.read(kKeyPartnerToken)?.toString();
      if (login == null ||
          login.isEmpty ||
          passkey == null ||
          passkey.isEmpty) {
        throw StateError('Partner authorization is unavailable.');
      }

      final response = await _signalsAPI.getAnalyticSignals(
        login: login,
        passkey: passkey,
        pairs: pairs,
        fromDate: fromDate,
        toDate: toDate,
      );
      signals.assignAll(response.signals);
      hasLoaded.value = true;
      handleSuccessWithReturn(response);
    } catch (error) {
      signals.clear();
      errorMessage.value = _errorMessage(error);
      handleErrorWithReturn(error);
    } finally {
      isLoading.value = false;
    }
  }

  String _errorMessage(Object error) {
    if (error is StateError) {
      return 'Partner authorization is unavailable. Please sign in again.';
    }
    if (error is DioException) {
      final message = SignalsResponseModel.errorMessageFromResponse(
        error.response?.data,
      );
      if (message != null) return message;
      final statusCode = error.response?.statusCode;
      if (statusCode != null) {
        return 'Signals service returned an error ($statusCode). Please retry.';
      }
      return 'Could not connect to the signals service. Check your internet and retry.';
    }
    if (error is FormatException) return error.message;
    return 'Unable to load signals. Please retry.';
  }

  @override
  dynamic handleErrorWithReturn(dynamic error) {
    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}
