import 'package:flutter/material.dart';
import 'package:movies_app/config/theme/app_style.dart';
import 'package:movies_app/core/colors_manager.dart';

class AppTheme {
  static ThemeData movieTheme = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
        color: ColorsManager.blackAccent,
        titleTextStyle: AppTextStyles.appBar),


    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: ColorsManager.selectedIcon,
      unselectedItemColor: ColorsManager.unselectedIcon,
      selectedIconTheme: IconThemeData(size: 36),
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
  );
}
