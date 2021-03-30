import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final _controller = ScreenshotController();
  File _image;
  Future getImage() async {
    try {
      File _pickedFile =
          await ImagePicker.pickImage(source: ImageSource.gallery);

      if (_pickedFile != null) {
        // getting a directory path for saving
        final directory = await getExternalStorageDirectory();

// copy the file to a new path
        _image = await _pickedFile.copy('${directory.path}/image1.png');
      } else {}
    } catch (er) {
      print(er);
    }
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  Future<void> shareFile() async {
    await getImage();
    final directory = await getExternalStorageDirectory();
    print('${directory.path} / ${_image.path}');
    await FlutterShare.shareFile(
      title: 'Example share',
      text: 'Example share text',
      filePath: "${_image.path}",
    );
  }

  Future<void> shareScreenShot() async {
    Directory directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    final String localPath =
        '${directory.path}/${DateTime.now().toIso8601String()}.png';

    await _controller.capture(path: localPath);

    await Future.delayed(Duration(seconds: 1));

    await FlutterShare.shareFile(
      title: 'Compartilhar comprovante',
      chooserTitle: 'God knows',
      text: 'wpndet',
      filePath: localPath,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Screenshot(
            controller: _controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text('Share text and link'),
                  onPressed: share,
                ),
                FlatButton(
                  child: Text('Share local file'),
                  onPressed: shareFile,
                ),
                FlatButton(
                  child: Text('Share screenshot'),
                  onPressed: shareScreenShot,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
