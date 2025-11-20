import 'package:alab_technology_test/services/api_services.dart';
import 'package:alab_technology_test/services/local_storage_services.dart';
import 'package:flutter/foundation.dart';
import '../models/post_model.dart';

class PostsProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  List<Post> _posts = [];
  bool _isLoading = false;
  bool _hasError = false;
  bool _isOffline = false;
  String _errorMessage = '';
  int _currentPage = 1;
  bool _hasMore = true;
  final int _postsPerPage = 10;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  bool get isOffline => _isOffline;
  String get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;

  Future<void> loadPosts({bool refresh = false}) async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      _hasError = false;
      _isOffline = false;
      
      if (refresh) {
        _currentPage = 1;
        _posts.clear();
        _hasMore = true;
      }

      notifyListeners();

      final List<Post> newPosts = await _apiService.getPosts(
        page: _currentPage,
        limit: _postsPerPage,
        forceRefresh: refresh,
      );

      // Check if we're using cached data
      final lastSync = await LocalStorageService.getLastSyncTime();
      final now = DateTime.now();
      if (lastSync != null && now.difference(lastSync).inHours >= 1) {
        _isOffline = true;
      }

      if (newPosts.isEmpty) {
        _hasMore = false;
      } else {
        _posts.addAll(newPosts);
        _currentPage++;
      }
      
      _hasError = false;
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      
      // Check if we have cached data
      final cachedPosts = await LocalStorageService.getCachedPosts();
      if (cachedPosts.isNotEmpty) {
        _isOffline = true;
        _hasError = false;
        
        // Apply pagination to cached data
        final startIndex = (_currentPage - 1) * _postsPerPage;
        final endIndex = startIndex + _postsPerPage;
        
        if (startIndex < cachedPosts.length) {
          final paginatedPosts = cachedPosts.sublist(
            startIndex,
            endIndex > cachedPosts.length ? cachedPosts.length : endIndex,
          );
          
          _posts.addAll(paginatedPosts);
          _currentPage++;
          _hasMore = endIndex < cachedPosts.length;
        } else {
          _hasMore = false;
        }
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshPosts() async {
    await loadPosts(refresh: true);
  }

  void clearError() {
    _hasError = false;
    _errorMessage = '';
    _isOffline = false;
    notifyListeners();
  }

  Future<void> clearCache() async {
    await LocalStorageService.clearCache();
    _posts.clear();
    _currentPage = 1;
    _hasMore = true;
    _isOffline = false;
    notifyListeners();
  }
}