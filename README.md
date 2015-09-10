# SymCrypt

Simple Symmetric-key encryption for Dart

## Usage

A simple usage example:

    import 'package:symcrypt/symcrypt.dart';

    main() {
        String key = Symcrypt.createHash("Key");
        String data = getData();

        String decrypt = Symcrypt.decrypt(data, key);
        String encrypt = Symcrypt.encrypt(decrypt, key);

        assert(data == encrypt);
    }

# symcrypt
