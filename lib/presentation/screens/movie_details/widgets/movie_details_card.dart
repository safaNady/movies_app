import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/config/theme/app_style.dart';
import 'package:movies_app/core/colors_manager.dart';

class MovieDetailCard extends StatelessWidget {
  final String title;
  final String releaseDate;
  final String posterPath;
  final String genres;
  final String overview;
  final double rating;

  const MovieDetailCard({
    Key? key,
    required this.title,
    required this.releaseDate,
    required this.posterPath,
    required this.genres,
    required this.overview,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: REdgeInsets.all(8.0),
          child: Text(
            title,
            style: AppTextStyles.movieTitle,
          ),
        ),
        Padding(
          padding: REdgeInsets.all(8.0),
          child: Text(
            releaseDate,
            style: AppTextStyles.movieReleaseDate,
          ),
        ),
        Row(
          // 'https://image.tmdb.org/t/p/w500$posterPath',
          children: [
            Padding(
              padding: REdgeInsets.all(8.0),
              child:  Stack(
                children: [
                  // Movie Poster
                  Image.network(
                    'https://image.tmdb.org/t/p/w500$posterPath ?? ''}',
                    width: 130.w,
                    height: 220.h,
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
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2.w, color: ColorsManager.white),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    padding: REdgeInsets.all(8.0),
                    child: Text(genres,style: AppTextStyles.genres,),
                  ),
                  Padding(
                    padding: REdgeInsets.all(8.0),
                    child: Text(
                      overview,
                      style: AppTextStyles.overView,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: ColorsManager.selectedIcon, size: 20.sp),
                      Text(
                        rating.toString(),
                        style: AppTextStyles.movieDetailsSectionTitle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
