class PriceUpdate {
  final String ticker;
  final double price;
  final double changePercent;

  const PriceUpdate({
    required this.ticker,
    required this.price,
    required this.changePercent,
  });
}
