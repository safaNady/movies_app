import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/config/theme/app_style.dart';
import 'package:movies_app/core/colors_manager.dart';
import 'package:movies_app/presentation/screens/movie_details/view/movie_details_view.dart';

class MoreLikeThisSection extends StatelessWidget {
  final Future<List<dynamic>> similarMoviesFuture;

  const MoreLikeThisSection({
    Key? key,
    required this.similarMoviesFuture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: similarMoviesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          final movies = snapshot.data!;
          if (movies.isEmpty) {
            return Padding(
              padding: REdgeInsets.all(8.0),
              child: const Text("No similar movies available."),
            );
          }
          return Padding(
            padding: REdgeInsets.all(0.0),
            child: Container(
              color: ColorsManager.blackAccent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: REdgeInsets.all(8.0),
                    child: Text(
                      "More Like This",
                      style: AppTextStyles.movieTitle,
                    ),
                  ),
                  SizedBox(
                    height: 220.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        final movieId = movie['id'];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailsView(movieId: movieId),
                              ),
                            );
                          },
                          child: Padding(
                            padding: REdgeInsets.symmetric(horizontal: 8.w),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    // Movie Poster
                                    Image.network(
                                      'https://image.tmdb.org/t/p/w500${movie['poster_path'] ?? ''}',
                                      width: 100.w,
                                      height: 150.h,
                                      fit: BoxFit.cover,
                                    ),
                                    // Add Icon at top-left corner
                                    Positioned(
                                      top: 4.w,
                                      left: 4.w,
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          width: 24.w,
                                          height: 24.w,
                                          decoration: const BoxDecoration(
                                            color: Color.fromRGBO(255, 255, 255, 0.5),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 16.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(Icons.star, color: ColorsManager.selectedIcon, size: 10.sp),
                                      Text(
                                        movie['vote_average'].toString(),
                                        style: AppTextStyles.movieDetailsSectionDate,
                                      ),
                                    ],
                                  ),
                                ),SizedBox(
                                  width: 100.w,
                                  child: Text(
                                    movie['title'] ?? 'Unknown',
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: AppTextStyles.movieDetailsSectionDate,
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        movie['release_date'],
                                        style: AppTextStyles.dateSimilarSection,
                                      ),
                                      Text(
                                        "1h 59m",
                                        style: AppTextStyles.dateSimilarSection,
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Padding(
            padding: REdgeInsets.all(8.0),
            child: Text("No similar movies available."),
          );
        }
      },
    );
  }
}
