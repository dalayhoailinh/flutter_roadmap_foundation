import 'dart:async';

import 'package:flutter_roadmap_foundation/features/market/data/providers/market_providers.dart';
import 'package:flutter_roadmap_foundation/features/market/data/providers/price_history_notifier.dart';
import 'package:flutter_roadmap_foundation/features/market/data/services/price_ticker_service.dart';
import 'package:flutter_roadmap_foundation/features/market/domain/entities/price_update.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'price_history_notifier_test.mocks.dart';

@GenerateMocks([PriceTickerService])
void main() {
  group('PriceHistoryNotifier', () {
    test('Tích lũy tick khi stream phát PriceUpdate', () async {
      final streamController = StreamController<PriceUpdate>.broadcast(
        sync: true,
      );

      final mockService = MockPriceTickerService();
      when(mockService.priceStream).thenAnswer((_) => streamController.stream);

      final container = ProviderContainer(
        overrides: [priceTickerServiceProvider.overrideWithValue(mockService)],
      );
      addTearDown(container.dispose);
      addTearDown(streamController.close);

      container.read(priceHistoryProvider);

      streamController.add(
        const PriceUpdate(ticker: 'AAPL', price: 180.0, changePercent: 1.0),
      );
      streamController.add(
        const PriceUpdate(ticker: 'AAPL', price: 181.0, changePercent: 0.5),
      );

      final historry = container.read(priceHistoryProvider);
      final aaplTicks = historry['AAPL'];

      expect(aaplTicks, isNotNull);
      expect(aaplTicks!.length, 2);
      expect(aaplTicks[0].price, 180.0);
      expect(aaplTicks[1].price, 181.0);
    });
  });
}
