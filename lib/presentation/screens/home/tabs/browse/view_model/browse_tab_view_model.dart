import 'package:flutter/material.dart';
import 'package:movies_app/api/api_manager/movie_servise.dart';

class BrowseTabViewModel extends ChangeNotifier {
  final MovieService _movieService = MovieService();
  List<dynamic> categories = [];
  bool isLoading = true;
  String? errorMessage;

  BrowseTabViewModel() {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      categories = await _movieService.fetchCategories();
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
