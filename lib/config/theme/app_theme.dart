import 'package:flutter/material.dart';
import 'app_colors.dart';

/// ThemeData utama untuk aplikasi KitabKu
class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundPrimary,
      fontFamily: 'Poppins',

      // ── Color Scheme ──
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.backgroundSecondary,
        background: AppColors.backgroundPrimary,
        onPrimary: AppColors.textOnPrimary,
        onSurface: AppColors.textPrimary,
      ),

      // ── AppBar ──
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textOnPrimary,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textOnPrimary,
          fontFamily: 'Poppins',
        ),
      ),

      // ── Card ──
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.backgroundCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),

      // ── Bottom Navigation ──
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.backgroundSecondary,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textLight,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          fontFamily: 'Poppins',
        ),
      ),

      // ── Divider ──
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
      ),

      // ── Elevated Button ──
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}
