import 'dart:math';

import '../../domain/entities/candle_data.dart';

class CandleDataService {
  static const _basePrices = <String, double>{
    'AAPL': 178.50,
    'GOOGL': 140.20,
    'MSFT': 415.80,
    'TSLA': 195.30,
    'NVDA': 875.60,
  };

  static List<CandleData> generate({required String ticker, int count = 30}) {
    final random = Random(ticker.hashCode);
    final basePrice = _basePrices[ticker] ?? 100.0;
    final now = DateTime.now();

    final candles = <CandleData>[];
    double currentClose = basePrice * 0.90;

    for (int i = count - 1; i >= 0; i--) {
      final open = currentClose;

      final changePercent = (random.nextDouble() - 0.45) * 3.0;
      final close = open * (1 + changePercent / 100);

      final bodyTop = min(open, close);
      final bodyBottom = max(open, close);
      final high = bodyTop * (1 + random.nextDouble() * 0.015);
      final low = bodyBottom * (1 - random.nextDouble() * 0.015);

      candles.add(
        CandleData(
          time: now.subtract(Duration(days: i)),
          open: open,
          high: high,
          low: low,
          close: close,
        ),
      );

      currentClose = close;
    }
    return candles;
  }
}
