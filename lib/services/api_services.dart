import 'dart:convert';
import 'package:alab_technology_test/services/local_storage_services.dart';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Post>> getPosts(
      {int page = 1, int limit = 10, bool forceRefresh = false}) async {
    try {
      // Check if we should use cache
      if (!forceRefresh && await LocalStorageService.hasValidCache()) {
        final cachedPosts = await LocalStorageService.getCachedPosts();
        if (cachedPosts.isNotEmpty) {
          return _applyPagination(cachedPosts, page, limit);
        }
      }

      // Fetch from API
      final response = await http.get(
        Uri.parse('$baseUrl/posts'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Post> posts =
            data.map((json) => Post.fromJson(json)).toList();

        // Save to local storage
        await LocalStorageService.savePosts(posts);

        return _applyPagination(posts, page, limit);
      } else {
        throw Exception('Failed to load posts: ${response.statusCode}');
      }
    } catch (e) {
      // If API fails, try to load from cache
      final cachedPosts = await LocalStorageService.getCachedPosts();
      if (cachedPosts.isNotEmpty) {
        print('🔄 Using cached data due to API error: $e');
        return _applyPagination(cachedPosts, page, limit);
      } else {
        throw Exception('Failed to load posts: $e');
      }
    }
  }

  // Helper method for pagination
  List<Post> _applyPagination(List<Post> posts, int page, int limit) {
    final startIndex = (page - 1) * limit;
    final endIndex = startIndex + limit;

    if (startIndex >= posts.length) {
      return [];
    }

    return posts.sublist(
      startIndex,
      endIndex > posts.length ? posts.length : endIndex,
    );
  }
}
