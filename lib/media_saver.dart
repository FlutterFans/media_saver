import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class MediaSaver {
  static const MethodChannel _channel = const MethodChannel('media_saver');

  ///
  /// save Image to Album, Android is save to Pictures
  /// [ImageType] save image type, default is jpg
  /// [fileName] save image file name, default milliseconds, eg. target_file
  /// [directory] save image's dir, default save in Pictures
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
