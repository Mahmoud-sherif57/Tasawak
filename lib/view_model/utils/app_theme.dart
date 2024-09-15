import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    fontFamily: "AlegreyaSans",
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 38,
        color: AppColors.primaryColor2,
        fontWeight: FontWeight.w500,
      ),
      headlineMedium: TextStyle(
        fontSize: 30,
        color:  AppColors.primaryColor2,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        color:  AppColors.primaryColor2,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(color:  AppColors.primaryColor2, fontSize: 20),
      titleMedium: TextStyle(
        fontSize: 18,
        color:  AppColors.primaryColor2,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color:  AppColors.primaryColor2,
      ),
      displaySmall: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color:  AppColors.primaryColor2,
      ),
    ),
  );
}
