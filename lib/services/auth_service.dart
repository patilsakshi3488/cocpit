import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:techm_practice/services/secure_storage.dart';

class AuthService {
  static const String baseUrl = "http://192.168.1.2:5000/api";

  /// ================= REGISTER =================
  Future<bool> register({
    required String fullName,
    required String email,
    required String password,
    required String accountType,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "fullName": fullName,
        "email": email.toLowerCase().trim(),
        "password": password,
        "accountType": accountType,
      }),
    );

    return response.statusCode == 201;
  }

  /// ================= LOGIN =================
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email.toLowerCase().trim(),
        "password": password,
      }),
    );

    if (response.statusCode != 200) return false;

    final body = jsonDecode(response.body);

    await AppSecureStorage.saveAccessToken(body["accessToken"]);
    await AppSecureStorage.saveRefreshToken(body["refreshToken"]);
    await AppSecureStorage.saveUser(jsonEncode(body["user"]));

    return true;
  }

  /// ================= GET CURRENT USER =================
  Future<Map<String, dynamic>?> getMe() async {
    final token = await AppSecureStorage.getAccessToken();
    if (token == null) return null;

    final response = await http.get(
      Uri.parse("$baseUrl/auth/me"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return null;
  }

  /// ================= REFRESH =================
  Future<bool> refreshAccessToken() async {
    final refreshToken = await AppSecureStorage.getRefreshToken();
    if (refreshToken == null) return false;

    final response = await http.post(
      Uri.parse("$baseUrl/auth/refresh"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"refreshToken": refreshToken}),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      await AppSecureStorage.saveAccessToken(body["accessToken"]);
      return true;
    }

    return false;
  }

  /// ================= LOGOUT =================
  Future<void> logout() async {
    final accessToken = await AppSecureStorage.getAccessToken();

    if (accessToken != null) {
      await http.post(
        Uri.parse("$baseUrl/auth/logout"),
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      );
    }

    await AppSecureStorage.clearAll();
  }
}
