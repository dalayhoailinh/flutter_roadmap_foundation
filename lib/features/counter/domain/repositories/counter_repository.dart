import '../entities/counter_value.dart';

abstract class CounterRepository {
  CounterValue read();

  void save(CounterValue value);
}
