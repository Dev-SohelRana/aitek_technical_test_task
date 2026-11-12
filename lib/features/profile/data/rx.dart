import 'dart:async';
import 'dart:developer';

import 'package:aitek_task/constants/app_constants.dart';
import 'package:aitek_task/features/profile/data/api.dart';
import 'package:aitek_task/helpers/di.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../model/profile_model.dart';

class ProfileRX extends GetxController {
  final ProfileAPI _profileAPI = ProfileAPI();

  final RxBool isLoading = false.obs;
  final Rxn<ProfileModel> profileModel = Rxn<ProfileModel>();
  final RxnString errorMessage = RxnString();

  Future<void> getProfile() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;
      errorMessage.value = null;

      final login = appData.read(kKeyPeanutLogin)?.toString();
      final token = appData.read(kKeyPeanutToken)?.toString();
      if (login == null || login.isEmpty || token == null || token.isEmpty) {
        throw StateError('Peanut login session is unavailable');
      }

      final response = await _profileAPI.getProfile(login: login, token: token);

      profileModel.value = response;
    } catch (error) {
      log('Profile loading failed: $error');
      profileModel.value = null;
      errorMessage.value = _errorMessage(error);
    } finally {
      isLoading.value = false;
    }
  }

  String _errorMessage(Object error) {
    if (error is StateError) {
      return 'Profile session is unavailable. Please sign in again.';
    }
    if (error is ProfileApiException) {
      if (error.statusCode == 401 || error.statusCode == 403) {
        return 'Profile access expired. Please sign in again.';
      }
      return error.message;
    }
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      if (statusCode != null) {
        return 'Profile service returned an error ($statusCode). Please retry.';
      }
      return 'Could not connect to the profile service. Check your internet and retry.';
    }
    if (error is FormatException) return error.message;
    return 'Unable to load profile information. Please retry.';
  }

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }
}
