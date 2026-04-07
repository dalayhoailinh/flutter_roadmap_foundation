class PortfolioStat {
  final String label;
  final double value;
  final String unit;

  const PortfolioStat({
    required this.label,
    required this.value,
    required this.unit,
  });

  factory PortfolioStat.fromMap(Map<String, dynamic> map) {
    return PortfolioStat(
      label: map['label'] as String,
      value: (map['value'] as num).toDouble(),
      unit: map['unit'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'label': label, 'value': value, 'unit': unit};
  }
}
