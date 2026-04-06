import 'package:flutter/material.dart';

import '../domain/usecases/counter_use_cases.dart';
import 'counter_controller.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key, required this.useCases});

  final CounterUseCases useCases;

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  late final CounterController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CounterController(useCases: widget.useCases);
    _controller.addListener(_onControllerChanged);
  }

  void _onControllerChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Week 1 Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Counter value'),
            const SizedBox(height: 8),
            Text(
              '${_controller.value}',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _controller.decrement,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: _controller.increment,
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _controller.reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
