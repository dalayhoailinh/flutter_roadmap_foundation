class CounterValue {
  final int value;

  const CounterValue(this.value);

  static const CounterValue zero = CounterValue(0);

  CounterValue increment() => CounterValue(value + 1);

  CounterValue decrement() => CounterValue(value - 1);

  CounterValue reset() => zero;
}
