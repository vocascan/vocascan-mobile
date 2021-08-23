import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static final _storage = new FlutterSecureStorage();

  static add(String key, String value) {
    _storage.write(key: key, value: value);
  }

  static get(String key) async{
    return await _storage.read(key: key);
  }

  static delete(String key) async{
    return await _storage.delete(key: key);
  }
}
