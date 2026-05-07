class BookmarkModel {
  final int surahNomor;
  final int ayatNomor;
  final String surahName;
  final String ayatText;

  BookmarkModel({
    required this.surahNomor,
    required this.ayatNomor,
    required this.surahName,
    required this.ayatText,
  });

  Map<String, dynamic> toJson() => {
        'surahNomor': surahNomor,
        'ayatNomor': ayatNomor,
        'surahName': surahName,
        'ayatText': ayatText,
      };

  factory BookmarkModel.fromJson(Map<String, dynamic> json) => BookmarkModel(
        surahNomor: json['surahNomor'],
        ayatNomor: json['ayatNomor'],
        surahName: json['surahName'],
        ayatText: json['ayatText'],
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookmarkModel &&
          runtimeType == other.runtimeType &&
          surahNomor == other.surahNomor &&
          ayatNomor == other.ayatNomor;

  @override
  int get hashCode => surahNomor.hashCode ^ ayatNomor.hashCode;
}
