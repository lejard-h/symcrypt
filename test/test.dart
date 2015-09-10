// Copyright (c) 2015, <your name>. All rights reserved. Use of this source code

// is governed by a BSD-style license that can be found in the LICENSE file.

library symcrypt.test;

import 'package:symcrypt/core.dart';
import 'package:test/test.dart';

void main() {
  String data;
  String key;
  String encryptData;
  String decryptData;

  data = "Toto";
  key = Symcrypt.createHash("Key");
  encryptData = Symcrypt.encrypt(data, key);
  decryptData = Symcrypt.decrypt(encryptData, key);

  test('encrypt/decrypt', () {
    expect(decryptData, data);
  });
}
