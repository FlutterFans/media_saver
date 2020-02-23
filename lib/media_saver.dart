import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class MediaSaver {
  static const MethodChannel _channel = const MethodChannel('media_saver');

  ///
  /// save Image to Album, Android save to Pictures
  /// [ImageType] 保存图片类型
  /// [fileName] 保存图片名称，默认时间戳,无需带扩展名
  /// return the file path
  ///
  static Future<String> saveImage(
    Uint8List imageBytes, {
    ImageType imageType,
    String fileName,
    String directory,
  }) async {
    if (imageBytes == null) {
      return null;
    }
    String type = 'jpg';
    if (imageType == ImageType.PNG) {
      type = 'png';
    } else if (imageType == ImageType.GIF) {
      type = 'gif';
    }
    return await _channel.invokeMethod(
      'saveImage',
      {
        'data': imageBytes,
        'type': type,
        'directory': directory,
        'fileName': fileName ?? '${DateTime.now().millisecondsSinceEpoch}',
      },
    );
  }
}

enum ImageType { JPG, PNG, GIF }
