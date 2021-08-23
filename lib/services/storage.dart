import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vocascan_mobile/services/auth.dart';

class StorageService {
  static StorageService? instance;
  final _storage = new FlutterSecureStorage();

  StorageService() {
    instance = this;
  }

  static StorageService getInstance() {
    return instance ?? StorageService();
  }


  add(String key, String value) {
    _storage.write(key: key, value: value);
  }

  get(String key) async{
    return await _storage.read(key: key);
  }

  delete(String key) async{
    await _storage.delete(key: key);
  }
}
