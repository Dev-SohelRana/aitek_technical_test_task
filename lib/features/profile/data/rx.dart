import 'dart:async';
import 'dart:developer';

import 'package:aitek_task/constants/app_constants.dart';
import 'package:aitek_task/features/profile/data/api.dart';
import 'package:aitek_task/helpers/di.dart';
import 'package:get/get.dart';

import '../model/profile_model.dart';

class ProfileRX extends GetxController {
  final ProfileAPI _profileAPI = ProfileAPI();

  final RxBool isLoading = false.obs;
  final Rxn<ProfileModel> profileModel = Rxn<ProfileModel>();
  final RxnString errorMessage = RxnString();

  Future<void> getProfile() async {
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
      errorMessage.value = 'Unable to load profile information.';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }
}
