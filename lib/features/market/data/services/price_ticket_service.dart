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
    }
  }
}
