import 'package:flutter_roadmap_foundation/features/market/domain/entities/candle_data.dart';
import 'package:flutter_roadmap_foundation/features/market/presentation/widgets/candlestick_painter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final time = DateTime(2026, 4, 16, 5, 0, 0);

  final candle1 = CandleData(
    time: time,
    open: 100.0,
    high: 105.0,
    low: 98.0,
    close: 102.0,
  );

  final candle2 = CandleData(
    time: time.add(const Duration(minutes: 1)),
    open: 102.0,
    high: 108.0,
    low: 101.0,
    close: 106.0,
  );

  group('CandlestickPainter.shouldRepaint', () {
    test('Trả về false khi cùng data reference', () {
      final data = [candle1, candle2];
      final painter1 = CandlestickPainter(data: data);
      final painter2 = CandlestickPainter(data: data);

      expect(painter1.shouldRepaint(painter2), false);
    });

    test('Trả về true khi data reference khác nhau', () {
      final painter1 = CandlestickPainter(data: [candle1, candle2]);
      final painter2 = CandlestickPainter(data: [candle1, candle2]);

      expect(painter1.shouldRepaint(painter2), true);
    });
  });

  group('CandleData value equality (sau freezed migration)', () {
    test('hai CandleData cùng field là equal', () {
      final time = DateTime(2026, 4, 15, 10, 0);
      final a = CandleData(
        time: time,
        open: 100.0,
        high: 105.0,
        low: 98.0,
        close: 102.0,
      );
      final b = CandleData(
        time: time,
        open: 100.0,
        high: 105.0,
        low: 98.0,
        close: 102.0,
      );

      expect(a, equals(b));
    });

    test('copyWith tạo bản copy với field được thay đổi', () {
      final time = DateTime(2026, 4, 15, 10, 0);
      final original = CandleData(
        time: time,
        open: 100.0,
        high: 105.0,
        low: 98.0,
        close: 102.0,
      );

      final updated = original.copyWith(close: 108.0);

      expect(updated.open, 100.0);
      expect(updated.high, 105.0);
      expect(updated.close, 108.0);
      expect(original.close, 102.0);
    });
  });
}
