import 'dart:async';
import 'dart:isolate';

void _workerEntryPoint(SendPort mainSendPort) {
  final workerReceivePort = ReceivePort();

  mainSendPort.send(workerReceivePort.sendPort);

  workerReceivePort.listen((message) {
    if (message is int) {
      int result = 0;
      for (int i = 0; i < message; i++) {
        result += i;
      }
      mainSendPort.send(result);
    } else if (message == 'kill') {
      workerReceivePort.close();
    }
  });
}

class IsolateDemoService {
  Isolate? _isolate;
  SendPort? _workerSendPort;
  ReceivePort? _mainReceivePort;
  StreamSubscription<dynamic>? _mainSubscription;
  Completer<int>? _pendingResult;

  Future<void> start() async {
    if (_isolate != null) {
      return;
    }

    _mainReceivePort = ReceivePort();
    final workerReady = Completer<SendPort>();

    _mainSubscription = _mainReceivePort!.listen((message) {
      if (message is SendPort && _workerSendPort == null) {
        _workerSendPort = message;
        if (!workerReady.isCompleted) {
          workerReady.complete(message);
        }
        return;
      }

      if (message is int) {
        final pending = _pendingResult;
        if (pending != null && !pending.isCompleted) {
          pending.complete(message);
        }
      }
    });

    _isolate = await Isolate.spawn(
      _workerEntryPoint,
      _mainReceivePort!.sendPort,
    );

    await workerReady.future;
  }

  Future<int> calculateSum(int n) async {
    if (_workerSendPort == null) {
      throw Exception('Isolate chưa được khởi động');
    }

    if (_pendingResult != null && !_pendingResult!.isCompleted) {
      throw StateError('Isolate đang xử lý một tác vụ khác');
    }

    final completer = Completer<int>();
    _pendingResult = completer;

    _workerSendPort!.send(n);

    try {
      return await completer.future;
    } finally {
      if (identical(_pendingResult, completer)) {
        _pendingResult = null;
      }
    }
  }

  void _completePendingWithDisposedError() {
    final pending = _pendingResult;
    if (pending != null && !pending.isCompleted) {
      pending.completeError(StateError('Isolate đã bị dispose'));
    }
    _pendingResult = null;
  }

  void dispose() {
    _completePendingWithDisposedError();
    _workerSendPort?.send('kill');
    _mainSubscription?.cancel();
    _mainSubscription = null;
    _mainReceivePort?.close();
    _mainReceivePort = null;
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
    _workerSendPort = null;
  }
}
