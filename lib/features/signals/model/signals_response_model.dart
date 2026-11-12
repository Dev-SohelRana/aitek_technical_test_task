import 'dart:convert';

import 'package:aitek_task/features/signals/model/signal_model.dart';

class SignalsResponseModel {
  const SignalsResponseModel({this.signals = const []});

  final List<SignalModel> signals;

  factory SignalsResponseModel.fromJson(dynamic response) {
    final decoded = _decode(response);
    final items = _extractSignals(decoded);
    return SignalsResponseModel(
      signals: items.map(_signalFromJson).toList(growable: false),
    );
  }

  static dynamic _decode(dynamic value) {
    if (value is! String) return value;
    final text = value.trim();
    if (text.isEmpty) return const <dynamic>[];
    try {
      return jsonDecode(text);
    } on FormatException {
      throw const FormatException('Signals service returned invalid data.');
    }
  }

  static List<dynamic> _extractSignals(dynamic value) {
    if (value is List) return value;
    if (value is Map) {
      final map = Map<String, dynamic>.from(value);
      for (final key in ['signals', 'data', 'items', 'results', 'result']) {
        final nested = _valueFor(map, key);
        if (nested is List || nested is Map) return _extractSignals(nested);
      }
      if (map.isEmpty) return const [];
      if (_isSignal(map)) return [map];

      final message = errorMessageFromResponse(map);
      if (message != null) {
        throw FormatException(message);
      }
    }
    throw const FormatException(
      'Signals service returned an unexpected response.',
    );
  }

  static SignalModel _signalFromJson(dynamic value) {
    if (value is! Map) {
      throw const FormatException(
        'Signals service returned an invalid signal item.',
      );
    }
    return SignalModel.fromJson(Map<String, dynamic>.from(value));
  }

  static bool _isSignal(Map<String, dynamic> map) {
    final keys = map.keys.map((key) => key.toLowerCase()).toSet();
    return keys.any(
      (key) => {
        'pair',
        'symbol',
        'currency',
        'currencypair',
        'signaltype',
        'direction',
        'type',
      }.contains(key),
    );
  }

  static dynamic _valueFor(Map<String, dynamic> map, String key) {
    for (final entry in map.entries) {
      if (entry.key.toLowerCase() == key.toLowerCase()) return entry.value;
    }
    return null;
  }

  static String? errorMessageFromResponse(dynamic value) {
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
      return null;
    }
    if (value is! String || value.trim().isEmpty) return null;

    final text = value.trim();
    try {
      final decoded = jsonDecode(text);
      if (decoded is String) return decoded.trim();
      if (decoded is Map) return errorMessageFromResponse(decoded);
    } on FormatException {
      return text;
    }
    return text;
  }
}
