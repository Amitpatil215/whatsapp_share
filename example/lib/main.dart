import 'dart:async';
import 'dart:developer';
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
  File? _image;

  MyApp({super.key});

  Future<void> share() async {
    await WhatsappShare.share(
      text: 'Example share text',
      linkUrl: 'https://flutter.dev/',
      phone: '911234567890',
    );
  }

  Future<void> shareFile() async {
    await getImage();
    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }
    debugPrint('${directory?.path} / ${_image?.path}');

    await WhatsappShare.shareFile(
      phone: '911234567890',
      filePath: ["${_image?.path}"],
    );
  }

  Future<void> isInstalled() async {
    final val = await WhatsappShare.isInstalled(package: Package.whatsapp);
    debugPrint('Whatsapp is installed: $val');
  }

  Future<void> shareScreenShot() async {
    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    final String? localPath =
        await _controller.captureAndSave(directory!.path);

    await Future.delayed(const Duration(seconds: 1));
    if (localPath == null) {
      log("localPath is null");
    }

    await WhatsappShare.shareFile(
      phone: '911234567890',
      filePath: [localPath!],
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
                  onPressed: share,
                  child: const Text('Share text and link'),
                ),
                ElevatedButton(
                  onPressed: shareFile,
                  child: const Text('Share Image'),
                ),
                ElevatedButton(
                  onPressed: shareScreenShot,
                  child: const Text('Share screenshot'),
                ),
                ElevatedButton(
                  onPressed: isInstalled,
                  child: const Text('is Installed'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///Pick Image From gallery using image_picker plugin
  Future getImage() async {
    try {
      XFile? pickedFile =
          // ignore: deprecated_member_use
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {}
    } catch (er) {
      log(er.toString());
    }
  }
}
