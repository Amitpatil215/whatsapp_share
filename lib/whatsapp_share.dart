import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Select Whatsapp Type
enum Package { whatsapp, businessWhatsapp }

class WhatsappShare {
  static const MethodChannel _channel = MethodChannel('whatsapp_share');

  /// Checks whether whatsapp is installed in device or not
  ///
  /// [Package] is optional enum parameter which is defualt to [Package.whatsapp]
  /// for business whatsapp set it to [Package.businessWhatsapp], it cannot be null
  ///
  /// return true if installed otherwise false.
  static Future<bool> isInstalled({Package package = Package.whatsapp}) async {
    assert(package != null);

    String _package;
    _package = package.index == 0 ? "com.whatsapp" : "com.whatsapp.w4b";
    final bool success =
        await _channel.invokeMethod('isInstalled', <String, dynamic>{
      "package": _package,
    });
    return success;
  }

  /// Shares a message or/and link url with whatsapp.
  /// - Text: Is the [text] of the message.
  /// - LinkUrl: Is the [linkUrl] to include with the message.
  /// - Phone: is the [phone] contact number to share with.

  static Future<bool> share({
    required String phone,
    String? text,
    String? linkUrl,
    Package package = Package.whatsapp,
  }) async {
    assert(phone != null && phone.isNotEmpty);
    assert(package != null);

    if (phone == null && phone.isNotEmpty) {
      throw FlutterError('Phone cannot be null');
    }

    String _package;
    _package = package.index == 0 ? "com.whatsapp" : "com.whatsapp.w4b";

    final bool success = await _channel.invokeMethod('share', <String, dynamic>{
      'title': ' ',
      'text': text,
      'linkUrl': linkUrl,
      'chooserTitle': ' ',
      'phone': phone,
      'package': _package,
    });

    return success;
  }

  /// Shares a local file with whatsapp.
  /// - Text: Is the [text] of the message.
  /// - FilePath: Is the List of paths which can be prefilled.
  /// - Phone: is the [phone] contact number to share with.
  static Future<bool> shareFile({
    required List<String> filePath,
    required String phone,
    String? text,
    Package package = Package.whatsapp,
  }) async {
    assert(filePath != null && filePath.isNotEmpty);
    assert(phone != null && phone.isNotEmpty);
    assert(package != null);

    if (filePath == null || filePath.isEmpty) {
      throw FlutterError('FilePath cannot be null');
    } else if (phone == null && phone.isNotEmpty) {
      throw FlutterError('Phone cannot be null');
    }

    String _package;
    _package = package.index == 0 ? "com.whatsapp" : "com.whatsapp.w4b";

    final bool success =
        await _channel.invokeMethod('shareFile', <String, dynamic>{
      'title': ' ',
      'text': text,
      'filePath': filePath,
      'chooserTitle': ' ',
      'phone': phone,
      'package': _package,
    });

    return success;
  }
}
