import 'package:flutter/foundation.dart';

import '../domain/usecases/counter_use_cases.dart';

class CounterController extends ChangeNotifier {
  final CounterUseCases _useCases;
  int _value;

  CounterController({required CounterUseCases useCases})
    : _useCases = useCases,
      _value = useCases.getCurrent().value;

  int get value => _value;

  void increment() {
    _value = _useCases.increment().value;
    notifyListeners();
  }

  void decrement() {
    _value = _useCases.decrement().value;
    notifyListeners();
  }

  void reset() {
    _value = _useCases.reset().value;
    notifyListeners();
  }
}
