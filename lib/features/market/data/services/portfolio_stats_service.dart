import 'package:flutter/foundation.dart';

import '../../domain/entities/portfolio_stat.dart';

List<Map<String, dynamic>> _computeStats(
  List<Map<String, dynamic>> rawHoldings,
) {
  double totalValue = 0;
  double totalCost = 0;
  double dayGain = 0;

  for (final holding in rawHoldings) {
    final qty = (holding['qty'] as num).toDouble();
    final currentPrice = (holding['currentPrice'] as num).toDouble();
    final costBasis = (holding['costBasis'] as num).toDouble();
    final changePercent = (holding['changePercent'] as num).toDouble();

    totalValue += qty * currentPrice;
    totalCost += qty * costBasis;
    dayGain += qty * currentPrice * changePercent / 100;
  }

  final totalPnl = totalValue - totalCost;
  final totalPnlPercent = totalCost > 0 ? (totalPnl / totalCost) * 100 : 0.0;

  return [
    {'label': 'Total Value', 'value': totalValue, 'unit': 'USD'},
    {'label': 'Total P&L', 'value': totalPnl, 'unit': 'USD'},
    {'label': 'Total P&L %', 'value': totalPnlPercent, 'unit': '%'},
    {'label': 'Day Gain', 'value': dayGain, 'unit': 'USD'},
  ];
}

class PortfolioStatsService {
  Future<List<PortfolioStat>> calculateStats(
    List<Map<String, dynamic>> rawHoldings,
  ) async {
    final resultMaps = await compute(_computeStats, rawHoldings);
    return resultMaps.map(PortfolioStat.fromMap).toList();
  }
}

final fakeholdings = <Map<String, dynamic>>[
  {
    'ticker': 'AAPL',
    'qty': 10,
    'currentPrice': 178.50,
    'costBasis': 150.00,
    'changePercent': 0.8,
  },
  {
    'ticker': 'GOOGL',
    'qty': 5,
    'currentPrice': 140.20,
    'costBasis': 120.00,
    'changePercent': -0.3,
  },
  {
    'ticker': 'MSFT',
    'qty': 8,
    'currentPrice': 415.80,
    'costBasis': 380.00,
    'changePercent': 1.2,
  },
  {
    'ticker': 'TSLA',
    'qty': 3,
    'currentPrice': 195.30,
    'costBasis': 250.00,
    'changePercent': -2.1,
  },
  {
    'ticker': 'NVDA',
    'qty': 2,
    'currentPrice': 875.60,
    'costBasis': 600.00,
    'changePercent': 3.5,
  },
];
