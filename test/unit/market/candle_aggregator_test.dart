import 'package:flutter_roadmap_foundation/features/market/data/services/candle_aggregator.dart';
import 'package:flutter_roadmap_foundation/features/market/domain/entities/candle_interval.dart';
import 'package:flutter_roadmap_foundation/features/market/domain/entities/price_tick.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final baseTime = DateTime(2026, 4, 16, 5, 0, 0);

  group('CandleAggregator.aggregate', () {
    test('Trả về list rỗng khi ticks rỗng', () {
      final result = CandleAggregator.aggregate(
        ticks: [],
        interval: CandleInterval.oneMin,
      );
      expect(result, isEmpty);
    });

    test('Tạo 1 nến từ nhiều ticks trong cùng 1 phút', () {
      final ticks = [
        PriceTick(price: 100.0, time: baseTime), // open
        PriceTick(
          price: 105.0,
          time: baseTime.add(const Duration(seconds: 20)),
        ), // high
        PriceTick(
          price: 98.0,
          time: baseTime.add(const Duration(seconds: 40)),
        ), // low
        PriceTick(
          price: 102.0,
          time: baseTime.add(const Duration(seconds: 55)),
        ), // close
      ];

      final result = CandleAggregator.aggregate(
        ticks: ticks,
        interval: CandleInterval.oneMin,
      );

      expect(result.length, 1);
      expect(result[0].open, 100.0);
      expect(result[0].close, 102.0);
      expect(result[0].high, 105.0);
      expect(result[0].low, 98.0);
    });

    test('Tạo 2 nến từ ticks thuộc 2 phút khác nhau', () {
      final tick1 = PriceTick(price: 100.0, time: baseTime);
      final tick2 = PriceTick(
        price: 101.0,
        time: baseTime.add(const Duration(minutes: 1)),
      );

      final result = CandleAggregator.aggregate(
        ticks: [tick1, tick2],
        interval: CandleInterval.oneMin,
      );

      expect(result.length, 2);
      expect(result[0].open, 100.0);
      expect(result[0].close, 100.0);
      expect(result[1].open, 101.0);
      expect(result[1].close, 101.0);
    });

    test('Nến được sort theo thời gian tăng dần', () {
      final ticks = [
        PriceTick(price: 99.0, time: baseTime.add(const Duration(minutes: 2))),
        PriceTick(price: 100.0, time: baseTime),
        PriceTick(price: 101.0, time: baseTime.add(const Duration(minutes: 1))),
      ];

      final result = CandleAggregator.aggregate(
        ticks: ticks,
        interval: CandleInterval.oneMin,
      );

      expect(result.length, 3);
      expect(result[0].time, DateTime(2026, 4, 16, 5, 0, 0));
      expect(result[1].time, DateTime(2026, 4, 16, 5, 1, 0));
      expect(result[2].time, DateTime(2026, 4, 16, 5, 2, 0));
    });
  });
}
