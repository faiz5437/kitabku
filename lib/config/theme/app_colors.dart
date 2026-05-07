import 'package:flutter/material.dart';

/// Kumpulan warna utama aplikasi KitabKu
/// Tema: Putih Biru Muda dengan nuansa Islamic
class AppColors {
  AppColors._();

  // ── Primary Colors ──
  static const Color primary = Color(0xFF4A90D9);
  static const Color primaryLight = Color(0xFF7CB3F0);
  static const Color primaryDark = Color(0xFF2D6BB5);
  static const Color primarySoft = Color(0xFFD6E8FA);

  // ── Secondary / Accent ──
  static const Color accent = Color(0xFF1B7A6E);
  static const Color accentLight = Color(0xFF2AA899);
  static const Color gold = Color(0xFFD4A853);
  static const Color goldLight = Color(0xFFF5E6C4);

  // ── Background ──
  static const Color backgroundPrimary = Color(0xFFF5F9FF);
  static const Color backgroundSecondary = Color(0xFFFFFFFF);
  static const Color backgroundCard = Color(0xFFFFFFFF);
  static const Color backgroundPattern = Color(0xFFEAF2FC);

  // ── Text ──
  static const Color textPrimary = Color(0xFF1A2A3A);
  static const Color textSecondary = Color(0xFF5A6B7D);
  static const Color textLight = Color(0xFF8A9BB0);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textArabic = Color(0xFF1A2A3A);

  // ── Border & Divider ──
  static const Color border = Color(0xFFE0E8F0);
  static const Color divider = Color(0xFFF0F4F8);

  // ── Gradient ──
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4A90D9), Color(0xFF7CB3F0)],
  );

  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF4A90D9), Color(0xFF5BA0E8), Color(0xFFF5F9FF)],
    stops: [0.0, 0.7, 1.0],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF0F6FF)],
  );

  static const LinearGradient islamicGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4A90D9), Color(0xFF1B7A6E)],
  );
}
