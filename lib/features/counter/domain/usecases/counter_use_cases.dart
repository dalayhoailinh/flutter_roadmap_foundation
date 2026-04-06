import '../entities/counter_value.dart';
import '../repositories/counter_repository.dart';

class CounterUseCases {
  final CounterRepository _repository;

  CounterUseCases(this._repository);

  CounterValue getCurrent() {
    return _repository.read();
  }

  CounterValue increment() {
    final next = _repository.read().increment();
    _repository.save(next);
    return next;
  }

  CounterValue decrement() {
    final next = _repository.read().decrement();
    _repository.save(next);
    return next;
  }

  CounterValue reset() {
    final next = _repository.read().reset();
    _repository.save(next);
    return next;
  }
}
