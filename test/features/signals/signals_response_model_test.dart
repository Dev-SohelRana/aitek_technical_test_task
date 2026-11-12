import 'package:aitek_task/features/signals/model/signals_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses nested signals into card data', () {
    final response = SignalsResponseModel.fromJson({
      'data': [
        {
          'symbol': 'EURUSD',
          'direction': 'long',
          'entryPrice': 1.0845,
          'sl': 1.08,
          'tp': 1.09,
          'openTime': '2026-01-03T10:30:00Z',
          'status': 'Active',
        },
      ],
    });

    expect(response.signals, hasLength(1));
    expect(response.signals.single.pair, 'EURUSD');
    expect(response.signals.single.type, 'BUY');
    expect(response.signals.single.entry, '1.0845');
    expect(response.signals.single.stopLoss, '1.08');
    expect(response.signals.single.takeProfit, '1.09');
    expect(response.signals.single.status, 'Active');
  });

  test('handles empty responses and extracts server messages', () {
    expect(SignalsResponseModel.fromJson([]).signals, isEmpty);
    expect(
      SignalsResponseModel.errorMessageFromResponse(
        '"Signal service unavailable"',
      ),
      'Signal service unavailable',
    );
    expect(
      SignalsResponseModel.errorMessageFromResponse({
        'message': 'Signal service unavailable',
      }),
      'Signal service unavailable',
    );
  });

  test('shows an error envelope instead of treating it as an empty list', () {
    expect(
      () => SignalsResponseModel.fromJson({
        'message': 'Signal service unavailable',
      }),
      throwsA(
        isA<FormatException>().having(
          (error) => error.message,
          'message',
          'Signal service unavailable',
        ),
      ),
    );
  });
}
