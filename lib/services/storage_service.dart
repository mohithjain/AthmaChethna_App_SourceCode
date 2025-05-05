import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final _storage = FlutterSecureStorage();

  // Save all login details securely
  Future<void> saveLoginDetails({
    required String username,
    required String email,
    required String userId,
    required String password,
  }) async {
    await _storage.write(key: 'username', value: username);
    await _storage.write(key: 'email', value: email);
    await _storage.write(key: 'userId', value: userId);
    await _storage.write(key: 'password', value: password);
    print("✅ Login details saved successfully!");
  }

  // Save username securely
  Future<void> saveUsername(String username) async {
    await _storage.write(key: 'username', value: username);
  }

  // Save email securely
  Future<void> saveEmail(String email) async {
    await _storage.write(key: 'email', value: email);
  }

  // Save userId securely
  Future<void> saveUserId(String userId) async {
    await _storage.write(key: 'userId', value: userId);
  }

  // Save password securely
  Future<void> savePassword(String password) async {
    await _storage.write(key: 'password', value: password);
  }

  // Get username
  Future<String?> getUsername() async {
    return await _storage.read(key: 'username');
  }

  // Get email
  Future<String?> getEmail() async {
    return await _storage.read(key: 'email');
  }

  // Get userId
  Future<String?> getUserId() async {
    return await _storage.read(key: 'userId');
  }

  // Get password
  Future<String?> getPassword() async {
    return await _storage.read(key: 'password');
  }

  // Delete all stored data (for logout)
  Future<void> clearStorage() async {
    await _storage.deleteAll();
  }
}
