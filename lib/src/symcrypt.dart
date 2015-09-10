// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library symcrypt.base;

import 'package:cipher/cipher.dart';
import "package:cipher/impl/server.dart";
import 'package:crypto/crypto.dart';
import "dart:typed_data";

class Symcrypt {

  static bool _init = false;

  static init() {
    if (_init == false) {
      initCipher();
      _init = true;
    }
  }

  static String encrypt(String data, String key) {
    init();
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

  static String decrypt(String data, String key) {
    init();
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


  static String saltData(String data, [String salt = ""]) {
    if (data == null || data == "") {
      return data;
    }
    if (salt == null) {
      salt = "";
    }
    String _data = data + salt;
    var sha256 = new MD5();
    sha256.add(_data.codeUnits);
    var digest = sha256.close();
    var hexString = CryptoUtils.bytesToBase64(digest);
    return hexString;
  }

  static String createHash([String str = ""]) {
    if (str == null) {
      str = "";
    }
    MD5 sha256 = new MD5();
    sha256.add(str.codeUnits);
    var digest = sha256.close();
    var hexString = CryptoUtils.bytesToBase64(digest);
    return hexString;
  }

}