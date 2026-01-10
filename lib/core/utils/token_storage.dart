import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _storage = FlutterSecureStorage();
  static const _key = "jwt_token";

  // Save token securely
  static Future<void> save(String token) async {
    await _storage.write(key: _key, value: token);
  }

  // Get token
  static Future<String?> get() async {
    return await _storage.read(key: _key);
  }

  // Clear token (logout)
  static Future<void> clear() async {
    await _storage.delete(key: _key);
  }
}
