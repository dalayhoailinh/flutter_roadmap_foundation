import 'dart:async';
import 'dart:math';

import '../../domain/entities/price_update.dart';

class PriceTickerService {
  final _random = Random();

  final _basePrices = <String, double>{
    'AAPL': 178.50,
    'GOOGL': 140.20,
    'MSFT': 415.80,
    'TSLA': 195.30,
    'NVDA': 875.60,
  };

  final _controller = StreamController<PriceUpdate>.broadcast();
  Stream<PriceUpdate> get priceStream => _controller.stream;

  PriceTickerService() {
    for (var ticker in _basePrices.keys) {
      _startIndividualTicker(ticker);
    }
  }

  void _startIndividualTicker(String ticker) async {
    while (true) {
      await Future.delayed(Duration(milliseconds: 500 + _random.nextInt(2000)));

      final base = _basePrices[ticker]!;
      final change = (_random.nextDouble() - 0.5) * 4;
      final newPrice = base * (1 + change / 100);
      _basePrices[ticker] = newPrice;

      _controller.add(
        PriceUpdate(ticker: ticker, price: newPrice, changePercent: change),
      );
    }
  }
}
