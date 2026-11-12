import 'dart:developer';

import 'package:aitek_task/features/promo/data/api.dart';
import 'package:aitek_task/features/promo/model/promo_material_model.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class PromoRX {
  final PromoAPI _promoAPI = PromoAPI.instance;

  final RxBool isLoading = false.obs;
  final RxList<PromoMaterialModel> promoMaterials = <PromoMaterialModel>[].obs;
  final RxnString errorMessage = RxnString();

  Future<void> getPromoMaterials() async {
    if (isLoading.value) return;

    isLoading.value = true;
    errorMessage.value = null;

    try {
      final materials = await _promoAPI.getPromoMaterials();
      promoMaterials.assignAll(materials);
    } catch (error) {
      log('Promo materials load error: $error');
      errorMessage.value = _errorMessage(error);
    } finally {
      isLoading.value = false;
    }
  }

  String _errorMessage(Object error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      if (statusCode != null) {
        return 'Promo service returned an error ($statusCode). Please retry.';
      }
      return 'Could not connect to the promo service. Check your internet and retry.';
    }
    if (error is FormatException) return error.message;
    return 'Unable to load promo materials. Please retry.';
  }
}
