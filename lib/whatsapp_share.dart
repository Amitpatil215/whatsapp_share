import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WhatsappShare {
  static const MethodChannel _channel = MethodChannel('whatsapp_share');

  /// Shares a message or/and link url with app chooser.
  ///
  /// - Title: Is the [title] of the message. Used as email subject if sharing
  /// with mail apps. The [title] cannot be null.
  /// - Text: Is the [text] of the message.
  /// - LinkUrl: Is the [linkUrl] to include with the message.
  /// - ChooserTitle (Just for Android): Is the [chooserTitle] of the app
  /// chooser popup. If null the system default title will be used.
  static Future<bool> share(
      {@required String title,
      @required String phone,
      String text,
      String linkUrl,
      String chooserTitle}) async {
    assert(title != null && title.isNotEmpty);

    if (title == null || title.isEmpty) {
      throw FlutterError('Title cannot be null');
    } else if (phone == null && phone.isNotEmpty) {
      throw FlutterError('Phone cannot be null');
    }

    final bool success = await _channel.invokeMethod('share', <String, dynamic>{
      'title': title,
      'text': text,
      'linkUrl': linkUrl,
      'chooserTitle': chooserTitle,
      'phone': phone,
    });

    return success;
  }

  /// Shares a local file with the app chooser.
  ///
  /// - Title: Is the [title] of the message. Used as email subject if sharing
  /// with mail apps. The [title] cannot be null.
  /// - Text: Is the [text] of the message.
  /// - FilePath: Is the [filePath] to include with the message.
  /// - ChooserTitle (Just for Android): Is the [chooserTitle] of the app
  /// chooser popup. If null the system default title will be used.
  static Future<bool> shareFile(
      {@required String title,
      @required String filePath,
      @required String phone,
      String text,
      String chooserTitle}) async {
    assert(title != null && title.isNotEmpty);
    assert(filePath != null && filePath.isNotEmpty);
    assert(phone != null && phone.isNotEmpty);

    if (title == null || title.isEmpty) {
      throw FlutterError('Title cannot be null');
    } else if (filePath == null || filePath.isEmpty) {
      throw FlutterError('FilePath cannot be null');
    } else if (phone == null && phone.isNotEmpty) {
      throw FlutterError('Phone cannot be null');
    }

    final bool success =
        await _channel.invokeMethod('shareFile', <String, dynamic>{
      'title': title,
      'text': text,
      'filePath': filePath,
      'chooserTitle': chooserTitle,
      'phone': phone,
    });

    return success;
  }
}
