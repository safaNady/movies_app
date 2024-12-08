import 'package:flutter/material.dart';
import 'package:movies_app/api/api_manager/movie_servise.dart';

class MoviesListViewModel extends ChangeNotifier {
  final MovieService _movieService = MovieService();
  List<dynamic> movies = [];
  bool isLoading = true;
  String? errorMessage;

  MoviesListViewModel(int categoryId) {
    fetchMoviesByCategoryId(categoryId);
  }

  Future<void> fetchMoviesByCategoryId(int categoryId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      movies = await _movieService.fetchMoviesByCategoryId(categoryId);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
