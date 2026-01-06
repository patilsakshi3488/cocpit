import 'dart:convert';
import 'package:http/http.dart' as http;

import 'auth_service.dart';
import 'secure_storage.dart';

class ApiClient {
  static const String baseUrl = "http://192.168.1.2:5000/api";

  /// ===================== GET =====================
  static Future<http.Response> get(String path) async {
    return _send(
          (headers) => http.get(
        Uri.parse("$baseUrl$path"),
        headers: headers,
      ),
    );
  }

  /// ===================== POST =====================
  static Future<http.Response> post(
      String path, {
        Map<String, dynamic>? body,
      }) async {
    return _send(
          (headers) => http.post(
        Uri.parse("$baseUrl$path"),
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      ),
    );
  }

  /// ===================== PUT =====================
  static Future<http.Response> put(
      String path, {
        Map<String, dynamic>? body,
      }) async {
    return _send(
          (headers) => http.put(
        Uri.parse("$baseUrl$path"),
        headers: headers,
        body: body != null ? jsonEncode(body) : null,
      ),
    );
  }

  /// ===================== DELETE =====================
  static Future<http.Response> delete(String path) async {
    return _send(
          (headers) => http.delete(
        Uri.parse("$baseUrl$path"),
        headers: headers,
      ),
    );
  }

  /// =================================================
  /// 🔐 CORE REQUEST HANDLER (AUTO REFRESH ON 401)
  /// =================================================
  static Future<http.Response> _send(
      Future<http.Response> Function(Map<String, String> headers) request,
      ) async {
    String? accessToken = await AppSecureStorage.getAccessToken();

    Map<String, String> headers = {
      "Content-Type": "application/json",
      if (accessToken != null) "Authorization": "Bearer $accessToken",
    };

    http.Response response = await request(headers);

    // 🔥 ACCESS TOKEN EXPIRED
    if (response.statusCode == 401) {
      final newToken = await AuthService().refreshAccessToken();

      if (newToken != null) {
        headers["Authorization"] = "Bearer $newToken";
        response = await request(headers);
      }
    }

    return response;
  }
}
