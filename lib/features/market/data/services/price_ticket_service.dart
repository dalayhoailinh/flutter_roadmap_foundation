import 'dart:math';

import '../../domain/entities/price_update.dart';

class PriceTicketService {
  final _random = Random();

  final _basePrices = <String, double>{
    'AAPL': 178.50,
    'GOOGL': 140.20,
    'MSFT': 415.80,
    'TSLA': 195.30,
    'NVDA': 875.60,
  };

  late final Stream<PriceUpdate> priceStream = _buildPriceStream()
      .asBroadcastStream();

  Stream<PriceUpdate> _buildPriceStream() async* {
    final tickers = _basePrices.keys.toList();
    int index = 0;

    while (true) {
      await Future<void>.delayed(const Duration(seconds: 1));

      final ticker = tickers[index % tickers.length];
      final base = _basePrices[ticker]!;

      final changePercent = (_random.nextDouble() - 0.5) * 4;
      final newPrice = base * (1 + changePercent / 100);

      _basePrices[ticker] = newPrice;
      yield PriceUpdate(
        ticker: ticker,
        price: newPrice,
        changePercent: changePercent,
      );

      index++;
    }
  }
}
