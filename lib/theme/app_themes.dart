import 'package:flutter/material.dart';
import 'package:flower_shop/theme/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,

    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.Green_text,
      ),
      headlineMedium:  TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.Green_text,
      ),
      bodyLarge:  TextStyle(
        fontSize: 16,
        color: AppColors.Green_text,
      ),
      bodyMedium:  TextStyle(
        fontSize: 14,
        color: AppColors.Green_text,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.Green_Defoult_main_btn,
        foregroundColor: AppColors.white,
        textStyle: TextStyle(fontSize:15 ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize:  Size(300, 35),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      labelStyle: TextStyle(color:AppColors.Black),
    ),
  );
}