import 'package:alab_technology_test/services/api_services.dart';
import 'package:flutter/foundation.dart';
import '../models/post_model.dart';


class PostsProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  List<Post> _posts = [];
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';
  int _currentPage = 1;
  bool _hasMore = true;
  final int _postsPerPage = 10;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;

  Future<void> loadPosts({bool refresh = false}) async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      _hasError = false;
      
      if (refresh) {
        _currentPage = 1;
        _posts.clear();
        _hasMore = true;
      }

      notifyListeners();

      final newPosts = await _apiService.getPosts(
        page: _currentPage,
        limit: _postsPerPage,
      );

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
    notifyListeners();
  }
}