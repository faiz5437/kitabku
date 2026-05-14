import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_styles.dart';
import '../../core/services/app_service.dart';
import '../../data/models/surah_model.dart';
import '../../data/models/surah_detail_model.dart';
import '../../data/repositories/surah_repository.dart';
import '../../data/models/bookmark_model.dart';
import '../../core/widgets/islamic_number_frame.dart';

class SurahDetailScreen extends StatefulWidget {
  final int nomor;
  final int? initialAyat;

  const SurahDetailScreen({
    Key? key,
    required this.nomor,
    this.initialAyat,
  }) : super(key: key);

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  final AppService _appService = AppService();
  final SurahRepository _surahRepository = SurahRepository();
  late Future<SurahDetailModel> _futureDetailSurah;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _targetKey = GlobalKey();
  bool _hasScrolled = false;
  bool _isInitialLoad = true;

  @override
  void initState() {
    super.initState();
    _futureDetailSurah = _surahRepository.getDetailSurah(widget.nomor);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _refreshData() {
    setState(() {
      _futureDetailSurah = _surahRepository.getDetailSurah(widget.nomor);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFE3F2FD),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        body: FutureBuilder<SurahDetailModel>(
          future: _futureDetailSurah,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            } else if (snapshot.hasError) {
              return RefreshIndicator(
                onRefresh: () async {
                  _refreshData();
                  await _futureDetailSurah;
                },
                color: AppColors.primary,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: _buildErrorView(),
                    ),
                  ],
                ),
              );
            } else if (!snapshot.hasData) {
              return const Center(child: Text('Data tidak ditemukan'));
            }

            final surah = snapshot.data!;

            return Column(
              children: [
                // Fixed Header Area (Light Blue Background)
                Container(
                  color: const Color.fromARGB(255, 255, 255, 255)
                      .withOpacity(0.05), // Kembali ke biru sangat samar
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
                      child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            // Watermark Icon (Moved to Center & Lower)
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: -25,
                              child: Icon(
                                Icons.menu_book_rounded,
                                size: 100,
                                color: Colors.white.withOpacity(0.08),
                              ),
                            ),
                            // Decorative accents (Same as Hero Banner)
                            Positioned(
                              right: -20,
                              top: -20,
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.05),
                                ),
                              ),
                            ),
                            Positioned(
                              left: -10,
                              bottom: -10,
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.04),
                                ),
                              ),
                            ),
                            // Header Content
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  const SizedBox(width: 4),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Surah ${surah.namaLatin}',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Container(
                                        height: 2,
                                        width: 120, // Diperpanjang ke kanan
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.6),
                                          borderRadius:
                                              BorderRadius.circular(1),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.tune_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    onPressed: _showSettingsSheet,
                                  ),
                                  const Icon(
                                    Icons.menu_book_rounded,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                  const SizedBox(width: 12),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Scrollable Content
                Expanded(
                  child: Container(
                    color: AppColors.backgroundPrimary,
                    child: CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        // Shadow di bawah header
                        SliverToBoxAdapter(
                          child: Container(
                            height: 4,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(16),
                          sliver: (!_appService.showLatin &&
                                  !_appService.showTranslation)
                              ? SliverToBoxAdapter(
                                  child: _buildMushafView(surah),
                                )
                              : SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      final ayat = surah.ayat[index];

                                      // Trigger initial jump once to bring the target near the viewport
                                      if (widget.initialAyat != null &&
                                          _isInitialLoad) {
                                        _isInitialLoad = false;
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          // Estimate position (approx 250px per verse)
                                          double estimate =
                                              (widget.initialAyat! - 1) * 250.0;
                                          if (estimate > 0) {
                                            _scrollController.jumpTo(estimate);
                                          }
                                        });
                                      }

                                      // Auto scroll logic for precise positioning
                                      if (widget.initialAyat != null &&
                                          ayat.nomorAyat ==
                                              widget.initialAyat &&
                                          !_hasScrolled) {
                                        _hasScrolled = true;
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          if (_targetKey.currentContext !=
                                              null) {
                                            Scrollable.ensureVisible(
                                              _targetKey.currentContext!,
                                              duration: const Duration(
                                                  milliseconds: 600),
                                              curve: Curves.easeInOut,
                                            );
                                          }
                                        });
                                        return Container(
                                          key: _targetKey,
                                          child: _buildAyatItem(ayat,
                                              surah.nomor, surah.namaLatin),
                                        );
                                      }

                                      return _buildAyatItem(
                                          ayat, surah.nomor, surah.namaLatin);
                                    },
                                    childCount: surah.ayat.length,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAyatItem(AyatModel ayat, int surahNomor, String surahName) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${ayat.nomorAyat}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const Spacer(),
              // Tombol Bookmark Ayat
              IconButton(
                icon: Icon(
                  _appService.isVerseBookmarked(surahNomor, ayat.nomorAyat)
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  color: AppColors.primary,
                ),
                onPressed: () {
                  final bookmark = BookmarkModel(
                    surahNomor: surahNomor,
                    ayatNomor: ayat.nomorAyat,
                    surahName: surahName,
                    ayatText: ayat.teksArab,
                  );
                  _appService.toggleVerseBookmark(bookmark);
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(_appService.isVerseBookmarked(
                              surahNomor, ayat.nomorAyat)
                          ? 'Ayat berhasil disimpan ke bookmark'
                          : 'Ayat dihapus dari bookmark'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            ayat.teksArab,
            textAlign: TextAlign.right,
            style: GoogleFonts.getFont(
              _appService.fontFamily,
              fontSize: _appService.fontSizeArab,
              fontWeight: FontWeight.bold,
              height: 2.2,
              color: AppColors.textPrimary,
            ),
          ),

          // Teks Latin (Kondisional)
          if (_appService.showLatin) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Text(
                ayat.teksLatin,
                style: const TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],

          // Terjemahan (Kondisional)
          if (_appService.showTranslation) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: Text(
                ayat.teksIndonesia,
                style: const TextStyle(
                    fontSize: 14, color: AppColors.textSecondary),
              ),
            ),
          ],
          const SizedBox(height: 16),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildMushafView(SurahDetailModel surah) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (surah.nomor != 1 && surah.nomor != 9)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Text(
                'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
                style: GoogleFonts.getFont(
                  _appService.fontFamily,
                  fontSize: _appService.fontSizeArab * 1.2,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: RichText(
            textAlign: TextAlign.justify,
            text: TextSpan(
              children: surah.ayat.map((ayat) {
                return TextSpan(
                  children: [
                    TextSpan(
                      text: '${ayat.teksArab} ',
                      style: GoogleFonts.getFont(
                        _appService.fontFamily,
                        fontSize: _appService.fontSizeArab,
                        fontWeight: FontWeight.bold,
                        height: 2.5,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: IslamicNumberFrame(
                          number: ayat.nomorAyat,
                          size: 32,
                          color: AppColors.primary.withOpacity(0.5),
                        ),
                      ),
                    ),
                    const TextSpan(text: ' '),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 60, color: Colors.red),
          const SizedBox(height: 16),
          const Text('Gagal memuat data surah'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: _refreshData,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Coba Lagi'),
          ),
        ],
      ),
    );
  }

  void _showSettingsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Pengaturan Tampilan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 16),
                  const Text('Ukuran Font Arab'),
                  Slider(
                    value: _appService.fontSizeArab,
                    min: 18,
                    max: 40,
                    activeColor: AppColors.primary,
                    onChanged: (value) {
                      _appService.setFontSizeArab(value);
                      setSheetState(() {});
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text('Pilih Jenis Font'),
                  const SizedBox(height: 8),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        'Amiri',
                        'Lateef',
                        'Scheherazade New',
                        'Noto Naskh Arabic'
                      ].map((font) {
                        final isSelected = _appService.fontFamily == font;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(font),
                            selected: isSelected,
                            selectedColor: AppColors.primary.withOpacity(0.2),
                            onSelected: (selected) {
                              if (selected) {
                                _appService.setFontFamily(font);
                                setSheetState(() {});
                              }
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Tampilkan Latin'),
                    value: _appService.showLatin,
                    activeColor: AppColors.primary,
                    onChanged: (value) {
                      _appService.setShowLatin(value);
                      setSheetState(() {});
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Tampilkan Terjemahan'),
                    value: _appService.showTranslation,
                    activeColor: AppColors.primary,
                    onChanged: (value) {
                      _appService.setShowTranslation(value);
                      setSheetState(() {});
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
