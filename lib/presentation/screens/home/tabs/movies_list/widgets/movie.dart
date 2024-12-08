import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/config/theme/app_style.dart';

class Movie extends StatelessWidget {
  final Map<String, dynamic> movie;

  const Movie({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(8),
      child: InkWell(
        onTap: (){},
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.network(
                movie['poster_path'] != null
                    ? 'https://image.tmdb.org/t/p/w500${movie['poster_path']}'
                    : 'https://via.placeholder.com/100',
                width: 150.w,
                height: 240.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 8.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie['title'] ?? 'Unknown', style: AppTextStyles.movieTitle),
                Text(movie['release_date'] ?? 'Unknown', style: AppTextStyles.movieReleaseDate),
              ],
            ),
          ],
        ),
      ),
    );
  }
}