import 'package:evently/utils/app_colors.dart';
import 'package:evently/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.bgLightMode,
    focusColor: AppColors.lightGrey,
    shadowColor: AppColors.superLightGrey,
    iconTheme: IconThemeData(color: AppColors.mainColor),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.mainLightColor,
      unselectedItemColor: AppColors.lightGrey,
      selectedLabelStyle: AppStyles.reg12mainLightColor,
      unselectedLabelStyle: AppStyles.reg12GreyColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.mainColor,
      shape: StadiumBorder(),
      foregroundColor: AppColors.white,
    ),
    cardColor: AppColors.mainColor,
    dividerColor: AppColors.mainDarkColor,
    highlightColor: AppColors.white,
    textTheme: TextTheme(
      headlineLarge: AppStyles.semi20black,
      headlineMedium: AppStyles.medium16black,
      bodyLarge: AppStyles.reg14grey,
      headlineSmall: AppStyles.semi24MainColor,
      labelMedium: AppStyles.medium16mainColor,
      labelSmall: AppStyles.medium16mainColor,
      labelLarge: AppStyles.semi14maincolor,
      bodyMedium: AppStyles.semi16mainLightColor,
      bodySmall: AppStyles.medium14black,
      titleLarge: AppStyles.reg14mainLightColor,
      titleMedium: AppStyles.medium20black,
      titleSmall: AppStyles.medium18main,
      displayMedium: AppStyles.semi14maincolor,
      displayLarge: AppStyles.medium20black,
      displaySmall: AppStyles.semi14white,
    ),
  );
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.bgDarkMode,
    focusColor: AppColors.mainColor,
    shadowColor: AppColors.strokeBordekColor,
    iconTheme: IconThemeData(color: AppColors.white),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.mainDarkColor,
      selectedItemColor: AppColors.mainLightColor,
      unselectedItemColor: AppColors.lightGrey,
      selectedLabelStyle: AppStyles.reg12mainDarkColor,
      unselectedLabelStyle: AppStyles.reg12GreyColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.mainLightColor,
      shape: StadiumBorder(),
      foregroundColor: AppColors.white,
    ),
    buttonTheme: ButtonThemeData(
      shape: Border.all(width: 1, color: AppColors.mainLightColor),
    ),
    cardColor: AppColors.mainLightColor,
    dividerColor: AppColors.mainLightColor,
    highlightColor: AppColors.mainLightColor,
    textTheme: TextTheme(
      headlineLarge: AppStyles.semi20white,
      headlineMedium: AppStyles.medium16white,
      bodyLarge: AppStyles.reg14grey,
      headlineSmall: AppStyles.semi24whiteColor,
      labelMedium: AppStyles.medium16mainLightColor,
      labelSmall: AppStyles.medium16mainColor,
      labelLarge: AppStyles.semi14MainLightColor,
      bodyMedium: AppStyles.semi16mainLightColor,
      bodySmall: AppStyles.medium14white,
      titleLarge: AppStyles.reg14mainLightColor,
      titleMedium: AppStyles.medium20black,
      titleSmall: AppStyles.medium18mainLight,
      displayMedium: AppStyles.semi14white,
      displayLarge: AppStyles.medium20white,
      displaySmall: AppStyles.semi14white,
    ),
  );
}
