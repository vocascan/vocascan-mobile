import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

  Future<dynamic> get(String key) async{
    return await _storage.read(key: key);
  }

  delete(String key) async{
    await _storage.delete(key: key);
  }

  Future<bool> exists(String key) async {
    return await _storage.containsKey(key: key);
  }
}
