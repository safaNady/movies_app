import 'package:flutter/material.dart';
import 'package:movies_app/core/colors_manager.dart';
import 'package:movies_app/presentation/screens/movie_details/view_model/movie_details_view_model.dart';
import 'package:movies_app/presentation/screens/movie_details/widgets/more_like_this_section.dart';
import 'package:movies_app/presentation/screens/movie_details/widgets/movie_details_card.dart';
import 'package:movies_app/presentation/screens/movie_details/widgets/trailer_section.dart';
import 'package:provider/provider.dart';

class MovieDetailsView extends StatelessWidget {
  final int movieId;

  const MovieDetailsView({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieDetailsViewModel(movieId),

      child: Consumer<MovieDetailsViewModel>(
        builder: (context, viewModel, child) {
          return FutureBuilder<Map<String, dynamic>>(
            future: viewModel.movieDetailsFuture,
            builder: (context, movieSnapshot) {
              if (movieSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (movieSnapshot.hasError) {
                return Center(child: Text("Error: ${movieSnapshot.error}"));
              } else if (movieSnapshot.hasData) {
                final movieDetails = movieSnapshot.data!;
                return Scaffold(
                  backgroundColor: ColorsManager.appBar,
                  appBar: AppBar(
                    title: Text(movieDetails['title'] ?? 'Movie Details'),
                  ),
                  body: FutureBuilder<List<dynamic>>(
                    future: viewModel.categoriesFuture,
                    builder: (context, categorySnapshot) {
                      if (categorySnapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (categorySnapshot.hasError) {
                        return Center(child: Text("Error: ${categorySnapshot.error}"));
                      } else if (categorySnapshot.hasData) {
                        final categories = categorySnapshot.data!;
                        final genres = viewModel.getGenreName(movieDetails['genres'], categories);
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              TrailerSection(
                                backdropPath: movieDetails['backdrop_path'],
                                posterPath: movieDetails['poster_path'],
                                trailerVideoKeyFuture: viewModel.trailerVideoKeyFuture,
                              ),
                              MovieDetailCard(
                                title: movieDetails['title'] ?? 'Unknown Title',
                                releaseDate: movieDetails['release_date'] ?? 'Unknown Release Date',
                                posterPath: movieDetails['poster_path'] ?? '',
                                genres: genres,
                                overview: movieDetails['overview'] ?? 'No description available.',
                                rating: (movieDetails['vote_average'] ?? 0).toDouble(),
                                onAddToWatchlist: () {},
                              ),
                              MoreLikeThisSection(
                                similarMoviesFuture: viewModel.similarMoviesFuture,
                              ),
                            ],
                          ),
                        );
                      }
                      return const Center(child: Text("No categories available."));
                    },
                  ),
                );
              }
              return const Center(child: Text("No movie details available."));
            },
          );
        },
      ),
    );
  }
}
