import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WhatsappShare {
  static const MethodChannel _channel = MethodChannel('whatsapp_share');

  /// Shares a message or/and link url with whatsapp.
  /// - Text: Is the [text] of the message.
  /// - LinkUrl: Is the [linkUrl] to include with the message.
  /// - Phone: is the [phone] contact number to share with.

  static Future<bool> share({
    @required String phone,
    String text,
    String linkUrl,
  }) async {
    assert(phone != null && phone.isNotEmpty);

    if (phone == null && phone.isNotEmpty) {
      throw FlutterError('Phone cannot be null');
    }

    final bool success = await _channel.invokeMethod('share', <String, dynamic>{
      'title': ' ',
      'text': text,
      'linkUrl': linkUrl,
      'chooserTitle': ' ',
      'phone': phone,
    });

    return success;
  }

  /// Shares a local file with whatsapp.
  /// - Text: Is the [text] of the message.
  /// - FilePath: Is the [filePath] to include with the message.
  /// - Phone: is the [phone] contact number to share with.
  static Future<bool> shareFile({
    @required String filePath,
    @required String phone,
    String text,
  }) async {
    assert(filePath != null && filePath.isNotEmpty);
    assert(phone != null && phone.isNotEmpty);

    if (filePath == null || filePath.isEmpty) {
      throw FlutterError('FilePath cannot be null');
    } else if (phone == null && phone.isNotEmpty) {
      throw FlutterError('Phone cannot be null');
    }

    final bool success =
        await _channel.invokeMethod('shareFile', <String, dynamic>{
      'title': ' ',
      'text': text,
      'filePath': filePath,
      'chooserTitle': ' ',
      'phone': phone,
    });

    return success;
  }
}
