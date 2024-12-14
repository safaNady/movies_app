import 'package:flutter/material.dart';
import 'package:movies_app/core/colors_manager.dart';
import 'package:movies_app/presentation/screens/home/tabs/movies_list/view_model/movies_list_view_model.dart';
import 'package:movies_app/presentation/screens/home/tabs/movies_list/widgets/movie.dart';
import 'package:provider/provider.dart';

class MoviesListView extends StatelessWidget {
  final Map<String, dynamic> category;

  const MoviesListView({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MoviesListViewModel(category['id']),
      child: Scaffold(
        backgroundColor: ColorsManager.blackAccent,
        appBar: AppBar(
          title: Text('${category['name']} Movies'),
        ),
        body: Consumer<MoviesListViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (viewModel.errorMessage != null) {
              return Center(child: Text('Error: ${viewModel.errorMessage}'));
            }
            if (viewModel.movies.isEmpty) {
              return const Center(child: Text('No movies available.'));
            }

            final movies = viewModel.movies;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return Movie(
                  movie: movie,
                  title: movie,
                  posterUrl: index,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
