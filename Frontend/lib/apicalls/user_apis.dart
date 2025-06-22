import 'dart:convert';
import 'package:http/http.dart' as http;

class UserApis {
  static Future<dynamic> registerUser({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/users/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'email': email,
        'password': password,
        'role': 'user',
        'rating' : 0.0
      }),
    );
    return jsonDecode(response.body);
  }

  static Future<bool> isUsernameAvailable(String username) async {
    final response = await http.get(
      Uri.parse('http://localhost:8000/users/check/$username'),
    );
    if (response.statusCode == 200) {
      final result = response.body.contains('true');
      return result;
    }
    // If the endpoint returns 404 or error, treat as not available
    return false;
  }
}