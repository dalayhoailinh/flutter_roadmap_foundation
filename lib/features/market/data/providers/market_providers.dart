import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/portfolio_stat.dart';
import '../../domain/entities/price_update.dart';
import '../services/portfolio_stats_service.dart';
import '../services/price_ticker_service.dart';

final _priceTickerServiceProvider = Provider<PriceTickerService>(
  (ref) => PriceTickerService(),
);

final _portfolioStatsServiceProvider = Provider<PortfolioStatsService>(
  (ref) => PortfolioStatsService(),
);

final portfolioStatsProvider = FutureProvider.autoDispose<List<PortfolioStat>>((
  ref,
) async {
  final service = ref.watch(_portfolioStatsServiceProvider);
  return service.calculateStats(fakeholdings);
});

final marketStateProvider = StreamProvider<Map<String, PriceUpdate>>((
  ref,
) async* {
  final service = ref.watch(_priceTickerServiceProvider);
  final Map<String, PriceUpdate> currentPrices = {};

  await for (final update in service.priceStream) {
    currentPrices[update.ticker] = update;
    yield {...currentPrices};
  }
});
