import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:media_saver/media_saver.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String state;

  @override
  void initState() {
    super.initState();
  }

  void _saveImage() async {
    setState(() {
      state = 'begin download';
    });
    var response = await Dio().get(
      'https://flutter.dev/assets/flutter-lockup-c13da9c9303e26b8d5fc208d2a1fa20c1ef47eb021ecadf27046dea04c0cebf6.png',
      options: Options(responseType: ResponseType.bytes),
    );
    setState(() {
      state = 'download success, saving...';
    });

    bool path = await MediaSaver.saveImage(
      Uint8List.fromList(response.data),
      imageType: ImageType.JPG,
      fileName: 'saveFileName',
      directory: 'demo',
    );
    setState(() {
      state = 'savePath： $path';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('media saver'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Text(state ?? 'init'),
              GestureDetector(
                onTap: _saveImage,
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.redAccent,
                  alignment: Alignment.center,
                  child: Text(
                    '保存图片',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
