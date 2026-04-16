import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';

typedef _FastSumNative = Int64 Function(Pointer<Int64> prices, Int32 count);

typedef _FastSumDart = int Function(Pointer<Int64> prices, int count);

class NativeMathFfi {
  static late final _FastSumDart _fastSum;
  static bool _initialized = false;

  static void init() {
    if (_initialized) return;

    final lib = Platform.isAndroid
        ? DynamicLibrary.open("libmathplugin.so")
        : DynamicLibrary.process();

    _fastSum = lib
        .lookup<NativeFunction<_FastSumNative>>("fast_sum")
        .asFunction<_FastSumDart>();

    _initialized = true;
  }

  static int movingAverageSum(List<int> prices) {
    final ptr = calloc<Int64>(prices.length);

    try {
      for (int i = 0; i < prices.length; i++) {
        ptr[i] = prices[i];
      }

      return _fastSum(ptr, prices.length);
    } finally {
      calloc.free(ptr);
    }
  }
}
