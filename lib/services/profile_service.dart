import 'dart:convert';
import 'package:techm_practice/services/api_client.dart';

class ProfileService {

  /// 🔐 GET LOGGED-IN USER PROFILE
  Future<Map<String, dynamic>?> getMyProfile() async {
    final response = await ApiClient.get("/profile/me");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return null;
  }

  /// ➕ ADD NEW EXPERIENCE
  Future<bool> addExperience({
    required String title,
    required String company,
    required String location,
    required String startDate,
    String? endDate,
    required bool currentlyWorking,
    required String description,
  }) async {
    final response = await ApiClient.post(
      "/profile/experiences",
      body: {
        "title": title,
        "company_name": company,
        "location": location,
        "start_date": startDate,
        "end_date": currentlyWorking ? null : endDate,
        "is_current": currentlyWorking,
        "description": description,
      },
    );

    return response.statusCode == 201;
  }
}
