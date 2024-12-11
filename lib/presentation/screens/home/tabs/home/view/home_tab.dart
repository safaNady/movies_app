import 'package:flutter/material.dart';
import 'package:movies_app/core/colors_manager.dart';
import 'package:movies_app/presentation/screens/home/tabs/home/view_model/home_view_model.dart';
import 'package:movies_app/presentation/screens/home/tabs/home/widget/widget.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Scaffold(
        backgroundColor: ColorsManager.blackAccent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<HomeViewModel>(
                builder: (context, viewModel, child) {
                  return FutureBuilder<List<dynamic>>(
                    future: viewModel.popularMoviesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("Error: ${snapshot.error}"));
                      } else if (snapshot.hasData) {
                        return buildCarousel(snapshot.data!, context);
                      } else {
                        return const Center(child: Text("No movies available."));
                      }
                    },
                  );
                },
              ),
              Consumer<HomeViewModel>(
                builder: (context, viewModel, child) {
                  return buildMovieList("New Releases", viewModel.upcomingMoviesFuture, context);
                },
              ),
              Consumer<HomeViewModel>(
                builder: (context, viewModel, child) {
                  return buildMovieList("Recommended", viewModel.topRatedMoviesFuture, context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}