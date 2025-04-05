import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spell_champ_frontend/config/api_config.dart';


class AuthService {
  final String _signupUrl = ApiConfig.signupEndpoint;

  Future<Map<String, dynamic>> signUp(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(_signupUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        final message = data['data']?['message'] ?? 'Signup successful!';
        return {'success': true, 'message': message};
      } else {
        return {'success': false, 'message': data['message'] ?? 'Signup failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error occurred: $e'};
    }
  }
}
