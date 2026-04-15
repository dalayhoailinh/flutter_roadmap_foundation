import 'dart:async';

import 'package:flutter_riverpod/legacy.dart';

import '../../domain/entities/price_tick.dart';
import '../../domain/entities/price_update.dart';
import '../services/price_ticker_service.dart';
import 'market_providers.dart';

const int _maxTicksPerTicker = 500;

class PriceHistoryNotifier extends StateNotifier<Map<String, List<PriceTick>>> {
  StreamSubscription<PriceUpdate>? _sub;

  PriceHistoryNotifier(PriceTickerService service) : super({}) {
    _sub = service.priceStream.listen(_onTick);
  }

  void _onTick(PriceUpdate update) {
    final tick = PriceTick(price: update.price, time: DateTime.now());
    final current = state[update.ticker] ?? [];

    final updated = [...current, tick];

    // Vì chỉ muốn giữ lại một số lượng tick nhất định để tránh chiếm quá
    // nhiều bộ nhớ, nên sẽ cắt bớt nếu vượt quá giới hạn. Vì thế đôi khi sẽ
    // mất một vài tick cũ nếu có quá nhiều cập nhật mới, và bạn sẽ thấy giá
    // ở khung thời gian đầu tiên có thể nhảy vì đã mất tick trước đó,
    // nhưng điều này chấp nhận được trong bối cảnh này.
    // Giữ tất cả tick: final capped = updated;
    final capped = updated.length > _maxTicksPerTicker
        ? updated.sublist(updated.length - _maxTicksPerTicker)
        : updated;

    state = {...state, update.ticker: capped};
  }

  @override
  void dispose() {
    _sub?.cancel();
    _sub = null;
    super.dispose();
  }
}

final priceHistoryProvider =
    StateNotifierProvider<PriceHistoryNotifier, Map<String, List<PriceTick>>>((
      ref,
    ) {
      final service = ref.watch(priceTickerServiceProvider);
      return PriceHistoryNotifier(service);
    });
