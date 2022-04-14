import 'package:flutter/material.dart';
import 'package:movie_infos/outils/app_colors.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: AppColors.createMaterialColor(const Color(0xff18b7d9)),
  scaffoldBackgroundColor: AppColors.backgroundDarkColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.backgroundDarkColor,
    elevation: 0.4,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: AppColors.createMaterialColor(const Color(0xff18b7d9)),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.4,
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
);
