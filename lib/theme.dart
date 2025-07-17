import 'package:flutter/material.dart';
import 'colors.dart';

final ThemeData appTheme = ThemeData(
  primarySwatch: AppColors.primarySwatch,
  colorScheme:
      ColorScheme.fromSwatch(
        primarySwatch: AppColors.primarySwatch,
        accentColor: AppColors.lilasClaro,
      ).copyWith(
        secondary: AppColors.lilasIntermediario,
        primary: AppColors.lilasEscuro,
      ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.lilasIntermediario,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.lilasEscuro,
    foregroundColor: Colors.white,
  ),
);
