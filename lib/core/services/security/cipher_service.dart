import 'package:encrypt/encrypt.dart';
import 'package:get/get.dart';

final CipherService cipherService = Get.put(CipherService());

class CipherService extends GetxService {
  static const String _key = String.fromEnvironment('cipherKey');
  static final IV iv = IV.fromUtf8(const String.fromEnvironment('cipherIV'));
  final Encrypter encrypter = Encrypter(
    AES(Key.fromUtf8(_key), mode: AESMode.ecb),
  );

  String encrypt(String val) => encrypter.encrypt(val, iv: iv).base64;

  String decrypt(String val) => encrypter.decrypt(
    Encrypted.from64(val),
    iv: iv,
  );
}
