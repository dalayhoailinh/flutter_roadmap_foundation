import 'package:flutter/services.dart';

class DeviceChannel {
  static const _channel = MethodChannel('com.example.roadmap/device');

  static Future<String> getDeviceInfo() async {
    try {
      final info = await _channel.invokeMethod<String>('getDeviceInfo');
      return info ?? 'Device info unavailable';
    } on PlatformException catch (e) {
      return 'Platform error: ${e.message}';
    } on MissingPluginException {
      return 'Channel not available on this platform';
    }
  }
}
