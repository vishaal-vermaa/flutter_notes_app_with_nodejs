
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_constants.dart';
import '../../../../core/utils/token_storage.dart';

class AuthApiDatasource {
  Future<void> register(String username, String password) async {
    final response = await http.post(
      Uri.parse("${ApiConstants.baseUrl}/auth/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode != 200) {
      throw Exception("Registration failed");
    }
  }

  Future<void> login(String username, String password) async {
    final response = await http.post(
      Uri.parse("${ApiConstants.baseUrl}/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode != 200) {
      throw Exception("Login failed");
    }

    final data = jsonDecode(response.body);
    await TokenStorage.save(data['token']);
  }

  Future<void> logout() async {
    await TokenStorage.clear();
  }

}
