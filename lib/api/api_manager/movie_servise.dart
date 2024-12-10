import 'dart:convert';

import 'package:http/http.dart' as http;

class MovieService {
  final String apiKey = "8e409e3a76a31772edac2050419f95e8";
  final String baseUrl = "https://api.themoviedb.org/3";

  Future<List<dynamic>> fetchMovies(String endpoint) async {
    final url = "$baseUrl$endpoint?api_key=$apiKey&language=en-US&page=1";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body)['results'];
    } else {
      throw Exception("Failed to load movies");
    }
  }

  Future<List<dynamic>> fetchPopularMovies() {
    return fetchMovies("/movie/popular");
  }

  Future<List<dynamic>> fetchUpcomingMovies() {
    return fetchMovies("/movie/upcoming");
  }

  Future<List<dynamic>> fetchTopRatedMovies() {
    return fetchMovies("/movie/top_rated");
  }

  Future<List<dynamic>> fetchCategories() async {
    final url = "$baseUrl/genre/movie/list?api_key=$apiKey&language=en-US";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['genres'] as List<dynamic>; // Ensure you return the 'genres' list
    } else {
      throw Exception("Failed to load categories");
    }
  }

  Future<List<dynamic>> fetchMoviesByCategoryId(int genreId) async {
    final url = "$baseUrl/discover/movie?api_key=$apiKey&with_genres=$genreId&language=en-US&page=1";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body)['results'];
    } else {
      throw Exception("Failed to load movies by category");
    }
  }

  Future<Map<String, dynamic>> fetchMovieDetails(int movieId) async {
    final url = "$baseUrl/movie/$movieId?api_key=$apiKey&language=en-US";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load movie details");
    }
  }

  Future<List<dynamic>> fetchSimilarMovies(int movieId) async {
    final url = "$baseUrl/movie/$movieId/similar?api_key=$apiKey&language=en-US&page=1";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body)['results'];
    } else {
      throw Exception("Failed to load similar movies");
    }
  }

  Future<String?> fetchTrailerVideoKey(int movieId) async {
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final results = json.decode(response.body)['results'] as List<dynamic>;
      if (results.isNotEmpty) {
        final trailer = results.firstWhere(
              (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube',
          orElse: () => null,
        );
        return trailer?['key'];
      }
    } else {
      throw Exception('Failed to load trailer videos');
    }
    return null;
  }

}
