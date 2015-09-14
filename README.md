# SymCrypt

Simple Symmetric-key encryption for Dart

## Usage

A simple usage example:

    import 'package:symcrypt/symcrypt.dart' as Symcrypt;

    main() {
        String pass = "pass"
        String salt = "salt"
        String pass = Symcrypt.saltData(pass, salt);
    
        String key = Symcrypt.createHash(pass);
        String data = getData();

        String decrypt = Symcrypt.decrypt(data, key);
        String encrypt = Symcrypt.encrypt(decrypt, key);

        assert(data == encrypt);
    }
