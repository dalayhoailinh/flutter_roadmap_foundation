import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/candle_data.dart';
import '../services/candle_data_service.dart';

final candleDataProvider = Provider.family<List<CandleData>, String>((
  ref,
  ticker,
) {
  return CandleDataService.generate(ticker: ticker);
});
