import 'package:flutter_riverpod/legacy.dart';

import '../../domain/entities/watchlist_item.dart';

class WatchlistNotifier extends StateNotifier<List<WatchlistItem>> {
  static const List<WatchlistItem> _defaultWatchlist = [
    WatchlistItem(symbol: 'AAPL', name: 'Apple Inc.'),
    WatchlistItem(symbol: 'NVDA', name: 'NVIDIA Corp.'),
    WatchlistItem(symbol: 'MSFT', name: 'Microsoft Corp.'),
  ];

  WatchlistNotifier() : super(_defaultWatchlist);

  void addItem(WatchlistItem item) {
    if (state.contains(item)) return;
    state = [...state, item];
  }

  void removeItem(String symbol) {
    state = state.where((i) => i.symbol != symbol).toList();
  }

  bool isWatching(String symbol) {
    return state.any((i) => i.symbol == symbol);
  }
}

final watchlistProvider =
    StateNotifierProvider<WatchlistNotifier, List<WatchlistItem>>(
      (ref) => WatchlistNotifier(),
    );
