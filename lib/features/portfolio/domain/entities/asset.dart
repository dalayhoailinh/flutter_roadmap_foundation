class Asset {
  final String symbol;
  final String name;
  final double price;
  final double changePercent;
  final double holdings;
  final String logoLabel;

  const Asset({
    required this.symbol,
    required this.name,
    required this.price,
    required this.changePercent,
    required this.holdings,
    required this.logoLabel,
  });

  bool get isPositive => changePercent >= 0;

  double get totalValue => price * holdings;

  String get formattedPrice => '\$${price.toStringAsFixed(2)}';

  String get formattedChange =>
      '${isPositive ? '+' : ''}${changePercent.toStringAsFixed(2)}%';

  String get formattedValue => '\$${totalValue.toStringAsFixed(2)}';
}

const List<Asset> mockAssets = [
  Asset(
    symbol: 'AAPL',
    name: 'Apple Inc.',
    price: 189.43,
    changePercent: 1.24,
    holdings: 5.0,
    logoLabel: 'A',
  ),
  Asset(
    symbol: 'MSFT',
    name: 'Microsoft Corp.',
    price: 415.20,
    changePercent: -0.38,
    holdings: 3.0,
    logoLabel: 'M',
  ),
  Asset(
    symbol: 'NVDA',
    name: 'NVIDIA Corp.',
    price: 875.55,
    changePercent: 3.17,
    holdings: 2.5,
    logoLabel: 'N',
  ),
  Asset(
    symbol: 'GOOGL',
    name: 'Alphabet Inc.',
    price: 175.80,
    changePercent: 0.62,
    holdings: 4.0,
    logoLabel: 'G',
  ),
  Asset(
    symbol: 'TSLA',
    name: 'Tesla Inc.',
    price: 248.90,
    changePercent: -2.05,
    holdings: 6.0,
    logoLabel: 'T',
  ),
  Asset(
    symbol: 'META',
    name: 'Meta Platforms',
    price: 512.30,
    changePercent: 1.88,
    holdings: 1.5,
    logoLabel: 'M',
  ),
];
