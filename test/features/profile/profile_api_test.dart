import 'dart:convert';
import 'dart:typed_data';

import 'package:aitek_task/features/profile/data/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'sends Peanut credentials and combines both profile responses',
    () async {
      final adapter = _ProfileAdapter();
      final dio = Dio()..httpClientAdapter = adapter;
      final requests = <RequestOptions>[];
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            requests.add(options);
            handler.next(options);
          },
        ),
      );

      final profile = await ProfileAPI(dio: dio)
          .getProfile(login: '12345678', token: 'peanut-token');

      expect(requests, hasLength(2));
      for (final request in requests) {
        expect(request.data, {'login': 12345678, 'token': 'peanut-token'});
        expect(request.contentType, 'application/json-patch+json');
        expect(request.headers['Authorization'], 'Bearer peanut-token');
      }
      expect(
        requests.map((request) => request.uri.path),
        containsAll([
          '/api/ClientCabinetBasic/GetAccountInformation',
          '/api/ClientCabinetBasic/GetLastFourNumbersPhone',
        ]),
      );
      expect(profile.login, '12345678');
      expect(profile.name, 'Test Account');
      expect(profile.phone, '********5520');
      expect(profile.accountType, '1');
      // expect(profile.verificationLevel, '0');
    },
  );

  test('shows account data when the phone endpoint returns an error', () async {
    final api = ProfileAPI(
      dio: Dio()
        ..httpClientAdapter = _ProfileAdapter(
          failingOperation: 'GetLastFourNumbersPhone',
        ),
    );

    final profile = await api.getProfile(
      login: '12345678',
      token: 'peanut-token',
    );

    expect(profile.name, 'Test Account');
    expect(profile.phone, isNull);
    // expect(profile.phoneError, 'Internal server error');
  });

  test('identifies an account information endpoint error', () async {
    final api = ProfileAPI(
      dio: Dio()
        ..httpClientAdapter = _ProfileAdapter(
          failingOperation: 'GetAccountInformation',
        ),
    );

    await expectLater(
      api.getProfile(login: '12345678', token: 'peanut-token'),
      throwsA(
        isA<ProfileApiException>()
            .having(
              (error) => error.operation,
              'operation',
              'GetAccountInformation',
            )
            .having((error) => error.statusCode, 'statusCode', 500)
            .having(
              (error) => error.message,
              'message',
              'Internal server error',
            ),
      ),
    );
  });

  test(
    'reports an empty profile response without requesting phone data',
    () async {
      final adapter = _ProfileAdapter(emptyAccountResponse: true);
      final api = ProfileAPI(dio: Dio()..httpClientAdapter = adapter);

      await expectLater(
        api.getProfile(login: '12345678', token: 'peanut-token'),
        throwsA(
          isA<ProfileApiException>().having(
            (error) => error.message,
            'message',
            'The profile service returned no profile data.',
          ),
        ),
      );
      expect(adapter.requestPaths, hasLength(1));
    },
  );
}

class _ProfileAdapter implements HttpClientAdapter {
  _ProfileAdapter({this.failingOperation, this.emptyAccountResponse = false});

  final String? failingOperation;
  final bool emptyAccountResponse;
  final requestPaths = <String>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requestPaths.add(options.uri.path);
    final isAccountInformation = options.uri.path.endsWith(
      'GetAccountInformation',
    );
    final operation = isAccountInformation
        ? 'GetAccountInformation'
        : 'GetLastFourNumbersPhone';
    if (operation == failingOperation) {
      return ResponseBody.fromString(
        '"Internal server error"',
        500,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      );
    }

    final body = isAccountInformation
        ? jsonEncode(
            emptyAccountResponse
                ? <String, dynamic>{}
                : {'name': 'Test Account', 'type': 1, 'verificationLevel': 0},
          )
        : '********5520';
    return ResponseBody.fromString(
      body,
      200,
      headers: {
        Headers.contentTypeHeader: [
          isAccountInformation ? Headers.jsonContentType : 'text/plain',
        ],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
