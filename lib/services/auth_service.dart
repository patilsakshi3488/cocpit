import 'dart:async';
import 'secure_storage.dart';

class AuthService {
  /// TEMP LOGIN (MOCK)
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate network

    // save dummy token
    await SecureStorage.saveToken("TEMP_TOKEN");

    return true; // always success
  }

  /// TEMP SIGNUP (MOCK)
  Future<bool> signup({
    required String fullName,
    required String email,
    required String password,
    required String accountType,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    await SecureStorage.saveToken("TEMP_TOKEN");

    return true;
  }

  /// LOGOUT
  Future<void> logout() async {
    await SecureStorage.deleteToken();
  }
}
