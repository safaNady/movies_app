import 'package:flutter/material.dart';
import 'package:movies_app/api/api_manager/movie_servise.dart';

class HomeViewModel extends ChangeNotifier {
  final MovieService _movieService = MovieService();

  late Future<List<dynamic>> popularMoviesFuture;
  late Future<List<dynamic>> upcomingMoviesFuture;
  late Future<List<dynamic>> topRatedMoviesFuture;

  HomeViewModel() {
    fetchMovies();
  }

  void fetchMovies() {
    popularMoviesFuture = _movieService.fetchPopularMovies();
    upcomingMoviesFuture = _movieService.fetchUpcomingMovies();
    topRatedMoviesFuture = _movieService.fetchTopRatedMovies();
  }
}