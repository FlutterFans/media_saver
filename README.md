# media_saver

[![Pub](https://img.shields.io/pub/v/dio.svg?style=flat-square)](https://pub.dartlang.org/packages/media_saver)

Quick and Simple save media file for Android and IOS

## Features

- Implements native permission (Android)
- Save image to Pictures for Android and IOS
- Support save jpg/png/gif image
- Support set image name, set image dir, set image suffix

## Installation

Add it to your pubspec.yaml file
```
dependencies:
   media_saver: <PLUGIN_VERSION>
```

Install it

```
pub get
```

Import it

```
import 'package:media_saver/media_saver.dart';
```

For iOS you need setting info.plist with
```
  Privacy - Photo Library Additions Usage Description
```

## Usage

1.
```dart
    var response = await Dio().get(
      'https://flutter.dev/assets/flutter-lockup-c13da9c9303e26b8d5fc208d2a1fa20c1ef47eb021ecadf27046dea04c0cebf6.png',
      options: Options(responseType: ResponseType.bytes),
    );

    String path = await MediaSaver.saveImage(
      Uint8List.fromList(response.data),
      imageType: ImageType.PNG,
      fileName: 'saveFileName',
      directory: 'demo',
    );
```

## License

MIT [@yk3372]() [@wsh794972562]()
