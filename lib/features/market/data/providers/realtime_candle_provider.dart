import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/candle_data.dart';
import '../../domain/entities/candle_interval.dart';
import '../services/candle_aggregator.dart';
import 'price_history_notifier.dart';

typedef CandleProviderArg = ({String ticker, CandleInterval interval});

final realtimeCandleProvider =
    Provider.family<List<CandleData>, CandleProviderArg>((ref, arg) {
      final history = ref.watch(priceHistoryProvider);
      final ticks = history[arg.ticker] ?? [];

      return CandleAggregator.aggregate(ticks: ticks, interval: arg.interval);
    });
