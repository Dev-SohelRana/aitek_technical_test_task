class SignalModel {
  const SignalModel({
    required this.pair,
    required this.type,
    required this.entry,
    required this.stopLoss,
    required this.takeProfit,
    required this.date,
    required this.time,
    required this.status,
  });

  final String pair;
  final String type;
  final String entry;
  final String stopLoss;
  final String takeProfit;
  final String date;
  final String time;
  final String status;

  factory SignalModel.fromJson(Map<String, dynamic> json) {
    final map = {
      for (final entry in json.entries) entry.key.toLowerCase(): entry.value,
    };
    final rawDate = _firstValue(map, [
      'date',
      'signaldate',
      'datetime',
      'opentime',
      'createdat',
      'timestamp',
    ]);
    final dateTime = _parseDate(rawDate);
    final rawTime = _firstValue(map, ['time', 'signaltime']);

    return SignalModel(
      pair: _displayValue(
        _firstValue(map, ['pair', 'symbol', 'currency', 'currencypair']),
      ),
      type: _direction(
        _firstValue(map, [
          'type',
          'signaltype',
          'direction',
          'action',
          'command',
        ]),
      ),
      entry: _displayValue(
        _firstValue(map, [
          'entry',
          'entryprice',
          'openprice',
          'priceopen',
          'price',
        ]),
      ),
      stopLoss: _displayValue(
        _firstValue(map, ['stoploss', 'sl', 'stop_loss']),
      ),
      takeProfit: _displayValue(
        _firstValue(map, ['takeprofit', 'tp', 'take_profit']),
      ),
      date: dateTime == null ? _displayValue(rawDate) : _formatDate(dateTime),
      time: rawTime == null && dateTime != null
          ? _formatTime(dateTime)
          : _displayValue(rawTime),
      status: _displayValue(_firstValue(map, ['status', 'state'])),
    );
  }

  static dynamic _firstValue(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final value = map[key];
      if (value != null && value.toString().trim().isNotEmpty) return value;
    }
    return null;
  }

  static DateTime? _parseDate(dynamic value) {
    if (value is num) {
      final timestamp = value.abs() < 1000000000000 ? value * 1000 : value;
      return DateTime.fromMillisecondsSinceEpoch(
        timestamp.round(),
        isUtc: true,
      ).toLocal();
    }
    if (value is! String) return null;
    final timestamp = num.tryParse(value);
    if (timestamp != null) return _parseDate(timestamp);
    return DateTime.tryParse(value)?.toLocal();
  }

  static String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  static String _formatTime(DateTime date) {
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  static String _direction(dynamic value) {
    final text = _displayValue(value).toUpperCase();
    if (text == 'LONG') return 'BUY';
    if (text == 'SHORT') return 'SELL';
    return text;
  }

  static String _displayValue(dynamic value) => value?.toString().trim() ?? '';
}
