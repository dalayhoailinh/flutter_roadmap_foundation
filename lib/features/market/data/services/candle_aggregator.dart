import 'dart:math';

import '../../domain/entities/candle_data.dart';
import '../../domain/entities/candle_interval.dart';
import '../../domain/entities/price_tick.dart';

class CandleAggregator {
  static List<CandleData> aggregate({
    required List<PriceTick> ticks,
    required CandleInterval interval,
  }) {
    if (ticks.isEmpty) return [];

    final buckets = <DateTime, List<PriceTick>>{};
    for (final tick in ticks) {
      final key = _bucketKey(tick.time, interval.minutes);
      (buckets[key] ??= []).add(tick);
    }

    final sortedKeys = buckets.keys.toList()..sort();

    return sortedKeys.map((key) {
      final bucketTicks = buckets[key]!;
      final open = bucketTicks.first.price;
      final close = bucketTicks.last.price;
      final high = bucketTicks.map((t) => t.price).reduce(max);
      final low = bucketTicks.map((t) => t.price).reduce(min);
      return CandleData(
        time: key,
        open: open,
        high: high,
        low: low,
        close: close,
      );
    }).toList();
  }

  // Ex: 10:07:34 with 5-minute interval -> bucket key is 10:05:00
  static DateTime _bucketKey(DateTime time, int intervalMinutes) {
    if (intervalMinutes >= 60) {
      final intervalHours = intervalMinutes ~/ 60;
      return DateTime(
        time.year,
        time.month,
        time.day,
        (time.hour ~/ intervalHours) * intervalHours,
      );
    }
    return DateTime(
      time.year,
      time.month,
      time.day,
      time.hour,
      (time.minute ~/ intervalMinutes) * intervalMinutes,
    );
  }
}
