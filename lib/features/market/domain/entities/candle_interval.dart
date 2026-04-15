enum CandleInterval {
  oneMin(minutes: 1, label: '1m'),
  fiveMin(minutes: 5, label: '5m'),
  fifteenMin(minutes: 15, label: '15m'),
  thirtyMin(minutes: 30, label: '30m'),
  oneHour(minutes: 60, label: '1h');

  final int minutes;
  final String label;

  const CandleInterval({required this.minutes, required this.label});
}
