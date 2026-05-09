import 'package:e_commers_by_provider/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF011627), // الخلفية الفاخرة
    primaryColor: const Color(0xFFFF9F1C),
    cardColor: const Color(0xFF0B2239),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF011627),
      elevation: 1,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFFDFFFC)),
      bodyMedium: TextStyle(fontSize: 16, color: Color(0xFFFDFFFC)),
    ),
  );
}