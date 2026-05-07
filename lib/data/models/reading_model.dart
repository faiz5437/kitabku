import 'package:flutter/material.dart';

/// Model untuk item bacaan (Surat, Dzikir, dll)
class ReadingModel {
  final String id;
  final String title;
  final String subtitle;
  final String category;
  final IconData icon;
  final String arabicText;
  final String latinText;
  final String translationText;
  final String? imageUrl;
  final List<String>? images;
  final int totalAyat;

  const ReadingModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.icon,
    required this.arabicText,
    required this.latinText,
    required this.translationText,
    this.imageUrl,
    this.images,
    this.totalAyat = 0,
  });
}

/// Model untuk item doa
class DoaModel {
  final String id;
  final String title;
  final String arabicText;
  final String latinText;
  final String translationText;
  final String source;

  const DoaModel({
    required this.id,
    required this.title,
    required this.arabicText,
    required this.latinText,
    required this.translationText,
    required this.source,
  });
}
