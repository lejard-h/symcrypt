// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library symcrypt.base;

import 'package:cipher/cipher.dart';
import "package:cipher/impl/server.dart";
import 'package:crypto/crypto.dart';
import "dart:typed_data";


bool _initSymCrypt = false;

/// Init internal library
/// Automatically called by encrypt and decrypt
initSymCrypt() {
    if (_initSymCrypt == false) {
      initCipher();
      _initSymCrypt = true;
    }
  }

/// Encrypt String data with a key
/// Key length must be 128/192/256 bits
String encrypt(String data, String key) {
    initSymCrypt();
    if (data == null || data.isEmpty) {
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

/// Decrypt String data with a key
/// Key length must be 128/192/256 bits
String decrypt(String data, String key) {
    initSymCrypt();
    if (data == null || data.isEmpty) {
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

/// saltData with MD5 encryption
String saltData(String data, String salt) {
    if (data.isEmpty || salt.isEmpty) {
      return data;
    }
    String _data = data + salt;
    var md5 = new MD5();
    md5.add(_data.codeUnits);
    var digest = md5.close();
    var hexString = CryptoUtils.bytesToBase64(digest);
    return hexString;
  }

String createHash(String str) {
    MD5 md5 = new MD5();
    md5.add(str?.codeUnits);
    var digest = md5.close();
    var hexString = CryptoUtils.bytesToBase64(digest);
    return hexString;
  }
