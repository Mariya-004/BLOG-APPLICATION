import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';
import 'auth_service.dart';

const baseUrl = 'http://127.0.0.1:8000/api';

class ApiService {
  static Future<String?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'];
      await AuthService.saveToken(token);
      return token;
    }
    return null;
  }

  static Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts/'));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Post.fromJson(json)).toList();
    }
    return [];
  }

  static Future<Post?> fetchPostDetail(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/$id/'));
    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  static Future<bool> createPost(String title, String content) async {
    final token = await AuthService.getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/posts/create/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token $token',
      },
      body: jsonEncode({'title': title, 'content': content}),
    );
    return response.statusCode == 201;
  }
}
