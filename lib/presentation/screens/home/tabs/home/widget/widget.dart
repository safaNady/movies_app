import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/colors_manager.dart';
import 'package:movies_app/presentation/screens/movie_details/view/movie_details_view.dart';
import 'package:movies_app/presentation/widgets/movie_image_with_add_btn.dart';

Widget buildCarousel(List<dynamic> movies, BuildContext context) {
  return CarouselSlider.builder(
    itemCount: movies.length,
    itemBuilder: (context, index, realIndex) {
      final movie = movies[index];
      final imageUrl = "https://image.tmdb.org/t/p/w500${movie['poster_path']}";

      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailsView(movieId: movie['id']),
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
           child:
           MovieImageWithAddButton(
               imageUrl: imageUrl,
               onAddPressed: (){},
               imageWidth: double.infinity,
               imageHeight: 215.h)
      //Image.network(
          //   imageUrl,
          //   fit: BoxFit.cover,
          //   width: double.infinity,
          // ),
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

Widget buildMovieList(String title, Future<List<dynamic>> moviesFuture, BuildContext context) {
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
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  final imageUrl =
                      "https://image.tmdb.org/t/p/w200${movie['poster_path']}";

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailsView(movieId: movie['id']),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child:MovieImageWithAddButton(
                                  imageUrl: imageUrl,
                                  onAddPressed: (){},
                                  imageWidth: 100.w,
                                  imageHeight: 170.h)
                              // Image.network(
                              //   imageUrl,
                              //   fit: BoxFit.cover,
                              //   width: 100,
                              //   height: 140,
                              // ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              movie['title'],
                              style: const TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
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
