import '../../domain/entities/counter_value.dart';
import '../../domain/repositories/counter_repository.dart';

class InMemoryCounterRepository implements CounterRepository {
  CounterValue _current = CounterValue.zero;

  @override
  CounterValue read() {
    return _current;
  }

  @override
  void save(CounterValue value) {
    _current = value;
  }
}
