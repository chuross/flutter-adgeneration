import 'dart:async';

import 'package:flutter/services.dart';

class ChrAdgeneration {
  static const MethodChannel _channel =
      const MethodChannel('chr_adgeneration');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
