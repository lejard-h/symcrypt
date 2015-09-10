// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library symcrypt.base;

import 'package:cipher/cipher.dart';
import "dart:typed_data";

class Symcrypt {

  static String encrypt(String data, String key) {
    if (data == null || data == "") {
      return null;
    }
    Uint8List _key = new Uint8List.fromList(key.codeUnits);
    var iv = new Uint8List.fromList(
        [0x00,0x11,0x22,0x33,0x44,0x55,0x66,0x77]
    );
    var params = new ParametersWithIV(new KeyParameter( _key ), iv);
    var cipher = new StreamCipher("AES/CTR")
      ..init(true, params);

    Uint8List cipherData = cipher.process(new Uint8List.fromList(data.codeUnits));
    return new String.fromCharCodes(cipherData);
  }

  static String decryptData(String data, String key) {
    if (data == null || data == "") {
      return null;
    }
    Uint8List _key = new Uint8List.fromList(key.codeUnits);
    var iv = new Uint8List.fromList(
        [0x00,0x11,0x22,0x33,0x44,0x55,0x66,0x77]
    );
    var params = new ParametersWithIV(new KeyParameter( _key ), iv);
    var cipher = new StreamCipher("AES/CTR")
      ..init(false, params);

    Uint8List cipherData = cipher.process(new Uint8List.fromList(data.codeUnits));
    return new String.fromCharCodes(cipherData);
  }

}