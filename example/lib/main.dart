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
      state = '开始下载';
    });
    var response = await Dio().get(
      'http://a4.att.hudong.com/21/09/01200000026352136359091694357.jpg',
      options: Options(responseType: ResponseType.bytes),
    );
    setState(() {
      state = '下载完成保存中...';
    });

    String path = await MediaSaver.saveImage(
      Uint8List.fromList(response.data),
      imageType: ImageType.JPG,
//      fileName: 'saveFileName',
//      directory: 'demo',
    );
    setState(() {
      state = '保存成功： $path';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
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
