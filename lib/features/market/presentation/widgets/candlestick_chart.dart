import 'package:flutter/material.dart';

import '../../domain/entities/candle_data.dart';
import 'candlestick_painter.dart';

class CandlestickChart extends StatelessWidget {
  final List<CandleData> candles;
  final double height;

  const CandlestickChart({super.key, required this.candles, this.height = 280});

  @override
  Widget build(BuildContext context) {
    if (candles.isEmpty) {
      return SizedBox(
        height: height,
        child: const Center(child: Text('Không có dữ liệu.')),
      );
    }

    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return CustomPaint(
            size: Size(constraints.maxWidth, height),
            painter: CandlestickPainter(data: candles),
            isComplex: true,
            willChange: true,
          );
        },
      ),
    );
  }
}
