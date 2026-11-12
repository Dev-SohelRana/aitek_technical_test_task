import 'package:aitek_task/features/promo/model/promo_material_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PromoMaterialModel.fromSoapResponse', () {
    test('parses promo fields and XML-escaped links', () {
      const response =
          '<s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">'
          '<s:Body><GetCCPromoResponse xmlns="http://tempuri.org/">'
          '<GetCCPromoResult>{"forex_copy":{"image":'
          '"https://forex-images.instaforex.com/promo.png","text":"False: Earn '
          '&amp; grow","link":"https://example.com/promo?lang=en&amp;source=app",'
          '"button_text":"Start now","button_color":"#3A469A",'
          '"euro_available":False}}</GetCCPromoResult>'
          '</GetCCPromoResponse></s:Body></s:Envelope>';

      final promos = PromoMaterialModel.fromSoapResponse(response);

      expect(promos, hasLength(1));
      expect(promos.single.title, 'Forex Copy');
      expect(promos.single.description, 'False: Earn & grow');
      expect(
        promos.single.imageUrl,
        'https://forex-images.ifxdb.com/promo.png',
      );
      expect(
        promos.single.link,
        'https://example.com/promo?lang=en&source=app',
      );
      expect(promos.single.buttonText, 'Start now');
      expect(promos.single.buttonColor, '#3A469A');
    });

    test('returns an empty list for an empty service result', () {
      const response = '<Envelope><Body><GetCCPromoResult /></Body></Envelope>';

      expect(PromoMaterialModel.fromSoapResponse(response), isEmpty);
    });
  });
}
