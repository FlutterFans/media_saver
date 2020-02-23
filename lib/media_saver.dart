import 'dart:async';

import 'package:flutter/services.dart';

class MediaSaver {
  static const MethodChannel _channel =
      const MethodChannel('media_saver');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
