import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_share/whatsapp_share.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

void main() => runApp(MyApp());

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  final _controller = ScreenshotController();
  File _image;
  Future getImage() async {
    try {
      File _pickedFile =
          // ignore: deprecated_member_use
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
        phone: '911234567890',
        chooserTitle: 'Example Chooser Title');
  }

  Future<void> shareFile() async {
    await getImage();
    Directory directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    print('${directory.path} / ${_image.path}');
    await FlutterShare.shareFile(
      title: 'Example share',
      text: 'Example share text',
      phone: '911234567890',
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
      chooserTitle: 'Chooser title',
      text: 'wpndet',
      phone: '911234567890',
      filePath: localPath,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Whatsapp Share'),
        ),
        body: Center(
          child: Screenshot(
            controller: _controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text('Share text and link'),
                  onPressed: share,
                ),
                ElevatedButton(
                  child: Text('Share local file'),
                  onPressed: shareFile,
                ),
                ElevatedButton(
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
