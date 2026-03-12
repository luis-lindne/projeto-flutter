import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/authenticated_user.dart';

class AuthService {
  static const _baseUrl = 'https://dummyjson.com';

  Future<AuthenticatedUser> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return AuthenticatedUser.fromJson(jsonDecode(response.body));
    }

    final error = jsonDecode(response.body);
    throw Exception(error['message'] ?? 'Erro ao fazer login');
  }
}
