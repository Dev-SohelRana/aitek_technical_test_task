final List<String> currencyPairs = [
  'EURUSD',
  'GBPUSD',
  'USDJPY',
  'USDCHF',
  'USDCAD',
  'AUDUSD',
  'NZDUSD',
];

final List<String> selectedPairs = ['EURUSD', 'GBPUSD'];

final List<Map<String, dynamic>> signals = [
  {
    'pair': 'EURUSD',
    'type': 'BUY',
    'entry': '1.08450',
    'stopLoss': '1.08150',
    'takeProfit': '1.09050',
    'date': 'Nov 10, 2026',
    'time': '10:30 AM',
    'status': 'Active',
  },
  {
    'pair': 'GBPUSD',
    'type': 'SELL',
    'entry': '1.29350',
    'stopLoss': '1.29650',
    'takeProfit': '1.28750',
    'date': 'Nov 10, 2026',
    'time': '09:15 AM',
    'status': 'Closed',
  },
  {
    'pair': 'EURUSD',
    'type': 'SELL',
    'entry': '1.08620',
    'stopLoss': '1.08920',
    'takeProfit': '1.08020',
    'date': 'Nov 09, 2026',
    'time': '02:45 PM',
    'status': 'Active',
  },
];
