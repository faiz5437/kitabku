import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../data/models/bookmark_model.dart';

class AppService extends ChangeNotifier {
  static final AppService _instance = AppService._internal();
  factory AppService() => _instance;
  AppService._internal();

  late SharedPreferences _prefs;

  // Settings
  double _fontSizeArab = 24.0;
  bool _showLatin = true;
  bool _showTranslation = true;
  String _fontFamily = 'Amiri';

  // Bookmarks (Simpan sebagai list of BookmarkModel)
  List<BookmarkModel> _bookmarks = [];

  double get fontSizeArab => _fontSizeArab;
  bool get showLatin => _showLatin;
  bool get showTranslation => _showTranslation;
  String get fontFamily => _fontFamily;
  List<BookmarkModel> get bookmarks => _bookmarks;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _fontSizeArab = _prefs.getDouble('fontSizeArab') ?? 24.0;
    _showLatin = _prefs.getBool('showLatin') ?? true;
    _showTranslation = _prefs.getBool('showTranslation') ?? true;
    _fontFamily = _prefs.getString('fontFamily') ?? 'Amiri';

    final bookmarkString = _prefs.getString('bookmarks') ?? '[]';
    try {
      final List<dynamic> bookmarkJson = jsonDecode(bookmarkString);
      // Cek apakah data lama (int) atau data baru (Map)
      if (bookmarkJson.isNotEmpty && bookmarkJson.first is int) {
        // Data lama, abaikan atau reset untuk mencegah crash
        _bookmarks = [];
        await _prefs.setString('bookmarks', '[]');
      } else {
        _bookmarks = bookmarkJson
            .map((j) => BookmarkModel.fromJson(j as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      debugPrint('Error decoding bookmarks: $e');
      _bookmarks = [];
    }

    notifyListeners();
  }

  // Setters for settings
  Future<void> setFontSizeArab(double size) async {
    _fontSizeArab = size;
    await _prefs.setDouble('fontSizeArab', size);
    notifyListeners();
  }

  Future<void> setShowLatin(bool value) async {
    _showLatin = value;
    await _prefs.setBool('showLatin', value);
    notifyListeners();
  }

  Future<void> setShowTranslation(bool value) async {
    _showTranslation = value;
    await _prefs.setBool('showTranslation', value);
    notifyListeners();
  }

  Future<void> setFontFamily(String font) async {
    _fontFamily = font;
    await _prefs.setString('fontFamily', font);
    notifyListeners();
  }

  // Bookmark actions
  bool isVerseBookmarked(int surahNomor, int ayatNomor) {
    return _bookmarks
        .any((b) => b.surahNomor == surahNomor && b.ayatNomor == ayatNomor);
  }

  Future<void> toggleVerseBookmark(BookmarkModel bookmark) async {
    final index = _bookmarks.indexWhere(
      (b) =>
          b.surahNomor == bookmark.surahNomor &&
          b.ayatNomor == bookmark.ayatNomor,
    );

    if (index != -1) {
      _bookmarks.removeAt(index);
    } else {
      _bookmarks.add(bookmark);
    }

    await _prefs.setString(
        'bookmarks', jsonEncode(_bookmarks.map((b) => b.toJson()).toList()));
    notifyListeners();
  }
}
