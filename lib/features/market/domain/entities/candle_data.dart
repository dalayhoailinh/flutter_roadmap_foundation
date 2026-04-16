import 'package:freezed_annotation/freezed_annotation.dart';

part 'candle_data.freezed.dart';

@freezed
abstract class CandleData with _$CandleData {
  const factory CandleData({
    required DateTime time,
    required double open,
    required double high,
    required double low,
    required double close,
  }) = _CandleData;
}
