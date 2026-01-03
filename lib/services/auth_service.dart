import 'dart:async';
import 'secure_storage.dart';

class AuthService {
  /// TEMP LOGIN (MOCK)
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    await SecureStorage.saveAccessToken("TEMP_ACCESS_TOKEN");
    await SecureStorage.saveRefreshToken("TEMP_REFRESH_TOKEN");

    return true;
  }

  /// TEMP SIGNUP (MOCK)
  Future<bool> signup({
    required String fullName,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    await SecureStorage.saveAccessToken("TEMP_ACCESS_TOKEN");
    await SecureStorage.saveRefreshToken("TEMP_REFRESH_TOKEN");

    return true;
  }

  /// LOGOUT
  Future<void> logout() async {
    await SecureStorage.clearAll();
  }
}
