import 'dart:developer';

import 'package:aitek_task/features/promo/model/promo_material_model.dart';
import 'package:aitek_task/networks/endpoints.dart';
import 'package:dio/dio.dart';

final class PromoAPI {
  static final PromoAPI _singleton = PromoAPI._internal();

  PromoAPI._internal();

  static PromoAPI get instance => _singleton;

  Future<List<PromoMaterialModel>> getPromoMaterials() async {
    try {
      final response = await Dio().post<String>(
        ForexEndpoints.cabinetMicroServiceUrl,
        data:
            '<?xml version="1.0" encoding="utf-8"?>'
            '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'
            '<soap:Body><GetCCPromo xmlns="http://tempuri.org/">'
            '<lang>en</lang>'
            '</GetCCPromo></soap:Body></soap:Envelope>',
        options: Options(
          contentType: 'text/xml; charset=utf-8',
          responseType: ResponseType.plain,
          headers: {
            'SOAPAction': 'http://tempuri.org/CabinetMicroService/GetCCPromo',
          },
        ),
      );

      final body = response.data;
      if (response.statusCode != 200 || body == null) {
        throw const FormatException(
          'Promo service returned an empty response.',
        );
      }
      return PromoMaterialModel.fromSoapResponse(body);
    } on DioException catch (error) {
      log('Promo API status: ${error.response?.statusCode}');
      log('Promo API error: ${error.response?.data ?? error.message}');
      rethrow;
    } catch (error) {
      log('Promo API error: $error');
      rethrow;
    }
  }
}
