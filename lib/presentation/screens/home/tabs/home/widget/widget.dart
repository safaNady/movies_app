import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/colors_manager.dart';

Widget buildCarousel(List<dynamic> movies) {
  return CarouselSlider.builder(
    itemCount: movies.length,
    itemBuilder: (context, index, realIndex) {
      final movie = movies[index];
      final imageUrl = "https://image.tmdb.org/t/p/w500${movie['poster_path']}";

      return GestureDetector(
        onTap: () {},
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
      );
    },
    options: CarouselOptions(
      height: 200,
      autoPlay: true,
      enlargeCenterPage: true,
      aspectRatio: 16 / 9,
      viewportFraction: 0.8,
    ),
  );
}

Widget buildMovieList(String title, Future<List<dynamic>> moviesFuture) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: const TextStyle(
              color: ColorsManager.white,
              fontSize: 15,
              fontWeight: FontWeight.w400),
        ),
      ),
      FutureBuilder<List<dynamic>>(
        future: moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            final movies = snapshot.data!;
            return SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  final imageUrl =
                      "https://image.tmdb.org/t/p/w200${movie['poster_path']}";

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 140,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            movie['title'],
                            style: const TextStyle(fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text("No movies available."));
          }
        },
      ),
    ],
  );
}
