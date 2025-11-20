import 'dart:convert';
import 'package:alab_technology_test/models/post_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Post>> getPosts({int page = 1, int limit = 10}) async {
    try {
      // Simulate pagination - in real API you'd have page & limit parameters
      final response = await http.get(
        Uri.parse('$baseUrl/posts'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Post> posts =
            data.map((json) => Post.fromJson(json)).toList();

        // Implement client-side pagination since API doesn't support it
        final startIndex = (page - 1) * limit;
        final endIndex = startIndex + limit;

        if (startIndex >= posts.length) {
          return [];
        }

        return posts.sublist(
          startIndex,
          endIndex > posts.length ? posts.length : endIndex,
        );
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }
}
