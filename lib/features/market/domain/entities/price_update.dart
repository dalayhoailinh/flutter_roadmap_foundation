class PriceUpdate {
  final String ticker;
  final double price;
  final double change;

  const PriceUpdate({
    required this.ticker,
    required this.price,
    required this.change,
  });
}
