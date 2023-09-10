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
  static Future<bool?> isInstalled({Package package = Package.whatsapp}) async {
    String _package;
    _package = package.index == 0 ? "com.whatsapp" : "com.whatsapp.w4b";
    final bool? success =
        await _channel.invokeMethod('isInstalled', <String, dynamic>{
      "package": _package,
    });
    return success;
  }

  /// Shares a message or/and link url with whatsapp.
  /// - Text: Is the [text] of the message.
  /// - LinkUrl: Is the [linkUrl] to include with the message.
  /// - Phone: is the [phone] contact number to share with.

  static Future<bool?> share({
    required String phone,
    String? text,
    String? linkUrl,
    Package package = Package.whatsapp,
  }) async {
    assert(phone.isNotEmpty);

    String _package;
    _package = package.index == 0 ? "com.whatsapp" : "com.whatsapp.w4b";

    final bool? success =
        await _channel.invokeMethod('share', <String, dynamic>{
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
  static Future<bool?> shareFile({
    required List<String> filePath,
    required String phone,
    @Deprecated(
        "No support for text along with files, this field is ignored")
    String? text,
    Package package = Package.whatsapp,
  }) async {
    assert(filePath.isNotEmpty);
    assert(phone.isNotEmpty);

    if (filePath.isEmpty) {
      throw FlutterError('FilePath cannot be Empty');
    } else if (phone.isEmpty) {
      throw FlutterError('Phone cannot be Empty');
    }

    String _package;
    _package = package.index == 0 ? "com.whatsapp" : "com.whatsapp.w4b";

    final bool? success =
        await _channel.invokeMethod('shareFile', <String, dynamic>{
      'title': ' ',
      'text': ' ',
      'filePath': filePath,
      'chooserTitle': ' ',
      'phone': phone,
      'package': _package,
    });

    return success;
  }
}
