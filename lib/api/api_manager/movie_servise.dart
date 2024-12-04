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
}
