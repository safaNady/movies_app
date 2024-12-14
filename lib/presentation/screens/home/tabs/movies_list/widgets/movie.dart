import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/config/theme/app_style.dart';
import 'package:movies_app/presentation/screens/movie_details/view/movie_details_view.dart';
import 'package:movies_app/presentation/widgets/movie_image_with_add_btn.dart';

class Movie extends StatelessWidget {
  final Map<String, dynamic> movie;

  const Movie(
      {super.key, required this.movie, required title, required posterUrl});

  String get title => title;

  String get posterUrl => posterUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.all(8),
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailsView(movieId: movie['id']),
            ),
          );
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
               child:MovieImageWithAddButton(
                   imageUrl: 'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                   onAddPressed: (){},
                 imageHeight: 240.h,
                 imageWidth: 150.w,
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