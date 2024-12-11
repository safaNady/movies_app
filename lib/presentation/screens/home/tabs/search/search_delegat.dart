import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/core/colors_manager.dart';

class Search extends SearchDelegate {
  final String apiKey2 =
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ZTQwOWUzYTc2YTMxNzcyZWRhYzIwNTA0MTlmOTVlOCIsIm5iZiI6MTczMzI0Mjg0Mi43NDU5OTk4LCJzdWIiOiI2NzRmMmZkYTBhNWY3ZmRiMTM2OTU3MGEiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.2eoiudtCp9sNFH3xUCzfx8dmO1Dp3-wMbkuDiX5wDW0';

  Future<List<dynamic>> search(String query) async {
    final url =
        Uri.parse('https://api.themoviedb.org/3/search/movie?query=$query');
    final response = await http.get(
      url,
      headers: {
        'Authorization': apiKey2,
        'Content-Type': 'application/json;charset=utf-8',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['results'];
    } else {
      throw Exception('Failed to load movies');
    }
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: ColorsManager.blackAccent,
        ),
        inputDecorationTheme:
            const InputDecorationTheme(border: InputBorder.none));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        size: 20,
        color: ColorsManager.white,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: ColorsManager.black,
      child: FutureBuilder<List<dynamic>>(
        future: search(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Error fetching movies',
                    style: TextStyle(color: ColorsManager.white)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.movie, size: 80, color: Colors.grey),
                  SizedBox(height: 10),
                  Text('No movies found',
                      style:
                          TextStyle(color: ColorsManager.white, fontSize: 18)),
                ],
              ),
            );
          } else {
            final movies = snapshot.data!;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  leading: movie['poster_path'] != null
                      ? Image.network(
                          'https://image.tmdb.org/t/p/w92${movie['poster_path']}',
                          fit: BoxFit.cover)
                      : const Icon(Icons.movie, size: 50, color: Colors.grey),
                  title: Text(movie['title'],
                      style: const TextStyle(color: ColorsManager.white)),
                  subtitle: Text(
                    movie['release_date'] ?? 'No release date',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: ColorsManager.black,
      child: FutureBuilder<List<dynamic>>(
        future: search(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Error fetching movies',
                    style: TextStyle(color: ColorsManager.white)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Container(
              color: ColorsManager.black,
            );
          } else {
            final movies = snapshot.data!;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  leading: movie['poster_path'] != null
                      ? Image.network(
                          'https://image.tmdb.org/t/p/w92${movie['poster_path']}',
                          fit: BoxFit.cover)
                      : const Icon(Icons.movie, size: 50, color: Colors.grey),
                  title: Text(movie['title'],
                      style: const TextStyle(color: ColorsManager.white)),
                  subtitle: Text(
                    movie['release_date'] ?? 'No release date',
                    style: const TextStyle(color: ColorsManager.white),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
