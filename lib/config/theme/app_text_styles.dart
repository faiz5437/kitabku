import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typography system untuk aplikasi KitabKu
class AppTextStyles {
  AppTextStyles._();

  static String get _fontFamily => GoogleFonts.plusJakartaSans().fontFamily!;

  // ── Heading ──
  static TextStyle heading1 = GoogleFonts.plusJakartaSans(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
    height: 1.3,
  );

  static TextStyle heading2 = GoogleFonts.plusJakartaSans(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
    height: 1.3,
  );

  static TextStyle heading3 = GoogleFonts.plusJakartaSans(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // ── Body ──
  static TextStyle bodyLarge = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static TextStyle bodyMedium = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  static TextStyle bodySmall = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textLight,
    height: 1.4,
  );

  // ── Label ──
  static TextStyle label = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );

  static TextStyle labelBold = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    letterSpacing: 0.5,
  );

  // ── Arabic Text (menggunakan Amiri untuk teks Arab) ──
  static TextStyle arabicLarge = GoogleFonts.amiri(
    fontSize: 32,
    fontWeight: FontWeight.w400,
    color: AppColors.textArabic,
    height: 2.2,
    letterSpacing: 0,
  );

  static TextStyle arabicMedium = GoogleFonts.amiri(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: AppColors.textArabic,
    height: 2.0,
  );

  static TextStyle arabicSmall = GoogleFonts.amiri(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.textArabic,
    height: 1.8,
  );

  // ── Button ──
  static TextStyle button = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
    letterSpacing: 0.5,
  );

  // ── On Primary (White text) ──
  static TextStyle headingOnPrimary = GoogleFonts.plusJakartaSans(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textOnPrimary,
    letterSpacing: -0.3,
  );

  static TextStyle bodyOnPrimary = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white70,
    height: 1.5,
  );
}
