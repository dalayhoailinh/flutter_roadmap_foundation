class WatchlistItem {
  final String symbol;
  final String name;

  const WatchlistItem({required this.symbol, required this.name});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WatchlistItem && symbol == other.symbol;

  @override
  int get hashCode => symbol.hashCode;
}
