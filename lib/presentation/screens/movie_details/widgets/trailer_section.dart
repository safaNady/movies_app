import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/core/colors_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class TrailerSection extends StatelessWidget {
  final String? backdropPath;
  final String? posterPath;
  final Future<String?> trailerVideoKeyFuture;

  const TrailerSection({
    Key? key,
    required this.backdropPath,
    required this.posterPath,
    required this.trailerVideoKeyFuture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: trailerVideoKeyFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const SizedBox(
            height: 200,
            child: Center(child: Text('Error loading trailer')),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          final videoKey = snapshot.data!;
          final trailerUrl = "https://www.youtube.com/watch?v=$videoKey";
          return Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://image.tmdb.org/t/p/w500${backdropPath ?? posterPath}",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: IconButton(
                onPressed: () => launchUrl(Uri.parse(trailerUrl)),
                icon: Icon(
                  Icons.play_circle,
                  size: 60.sp,
                  color: ColorsManager.white,
                ),
              ),
            ),
          );
        } else {
          return const SizedBox(
            height: 200,
            child: Center(child: Text('No trailer available.')),
          );
        }
      },
    );
  }
}
