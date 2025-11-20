import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/post_model.dart';

class LocalStorageService {
  static const String _postsKey = 'cached_posts';
  static const String _lastSyncKey = 'last_sync_time';

  // Save posts to local storage
  static Future<void> savePosts(List<Post> posts) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Convert posts to JSON string
      final postsJson = posts.map((post) => post.toMap()).toList();
      final postsString = json.encode(postsJson);

      await prefs.setString(_postsKey, postsString);
      await prefs.setString(_lastSyncKey, DateTime.now().toIso8601String());

      print('✅ Posts saved to local storage: ${posts.length} posts');
    } catch (e) {
      print('❌ Error saving posts to local storage: $e');
    }
  }

  // Get cached posts from local storage
  static Future<List<Post>> getCachedPosts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final postsString = prefs.getString(_postsKey);

      if (postsString != null) {
        final List<dynamic> postsJson = json.decode(postsString);
        final List<Post> posts =
            postsJson.map((json) => Post.fromMap(json)).toList();

        print('✅ Loaded ${posts.length} posts from cache');
        return posts;
      }

      return [];
    } catch (e) {
      print('❌ Error loading cached posts: $e');
      return [];
    }
  }

  // Get last sync time
  static Future<DateTime?> getLastSyncTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastSyncString = prefs.getString(_lastSyncKey);

      if (lastSyncString != null) {
        return DateTime.parse(lastSyncString);
      }

      return null;
    } catch (e) {
      print('❌ Error getting last sync time: $e');
      return null;
    }
  }

  // Clear cached data
  static Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_postsKey);
      await prefs.remove(_lastSyncKey);
      print('✅ Cache cleared');
    } catch (e) {
      print('❌ Error clearing cache: $e');
    }
  }

  // Check if cache exists and is valid (less than 1 hour old)
  static Future<bool> hasValidCache() async {
    try {
      final lastSync = await getLastSyncTime();
      if (lastSync == null) return false;

      final now = DateTime.now();
      final difference = now.difference(lastSync);

      return difference.inHours < 1; // Cache valid for 1 hour
    } catch (e) {
      return false;
    }
  }
}
