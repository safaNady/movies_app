import 'dart:ui';
import 'package:flutter/src/painting/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/colors_manager.dart';

class AppTextStyles{
  static TextStyle appBar = GoogleFonts.inter( fontSize: 22.sp,
    fontWeight: FontWeight.w400,
    color: ColorsManager.white,
  );

  static TextStyle movieTitle = GoogleFonts.inter( fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    color: ColorsManager.white,
  );

  static TextStyle movieReleaseDate = GoogleFonts.inter( fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: ColorsManager.white,
  );

  static TextStyle movieDetailsSectionTitle = GoogleFonts.inter( fontSize: 18.sp,
    fontWeight: FontWeight.w400,
    color: ColorsManager.white,
  );

  static TextStyle movieDetailsSectionDate = GoogleFonts.inter( fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    color: ColorsManager.date
  );

  static TextStyle genres= GoogleFonts.inter( fontSize: 10.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.genres
  );

  static TextStyle movieNameSimilarSection= GoogleFonts.inter( fontSize: 10.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.white
  );

  static TextStyle dateSimilarSection= GoogleFonts.inter( fontSize: 8.sp,
      fontWeight: FontWeight.w400,
      color: ColorsManager.white
  );

  static TextStyle overView = GoogleFonts.inter( fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: ColorsManager.genres,
  );
}