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

  Future<void> start() async {
    _mainReceivePort = ReceivePort();

    _isolate = await Isolate.spawn(
      _workerEntryPoint,
      _mainReceivePort!.sendPort,
    );

    _workerSendPort = await _mainReceivePort!.first as SendPort;
  }

  Future<int> calculateSum(int n) async {
    if (_workerSendPort == null) {
      throw Exception('Isolate chưa được khởi động');
    }

    final responsePort = ReceivePort();
    _mainReceivePort = responsePort;
    _workerSendPort!.send(n);

    return await responsePort.first as int;
  }

  void dispose() {
    _workerSendPort?.send('kill');
    _mainReceivePort?.close();
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
    _workerSendPort = null;
  }
}
