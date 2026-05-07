import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/theme/app_colors.dart';
import '../../data/models/surah_detail_model.dart';
import '../../data/repositories/surah_repository.dart';
import '../../core/services/app_service.dart';
import '../../data/models/bookmark_model.dart';
import '../../core/widgets/islamic_number_frame.dart';

class SurahDetailScreen extends StatefulWidget {
  const SurahDetailScreen({super.key, required this.nomor, this.initialAyat});

  final int nomor;
  final int? initialAyat;

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  final SurahRepository _repository = SurahRepository();
  final AppService _appService = AppService();
  late Future<SurahDetailModel> _futureDetailSurah;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _targetKey = GlobalKey();
  bool _hasScrolled = false;
  bool _isInitialLoad = true;

  @override
  void initState() {
    super.initState();
    _futureDetailSurah = _repository.getDetailSurah(widget.nomor);
    _appService.addListener(_rebuild);
  }

  @override
  void dispose() {
    _appService.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<SurahDetailModel>(
        future: _futureDetailSurah,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Data tidak ditemukan'));
          }

          final surah = snapshot.data!;

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                expandedHeight: 150,
                floating: false,
                pinned: true,
                backgroundColor: AppColors.primary,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.tune_rounded, color: Colors.white),
                    onPressed: _showSettingsSheet,
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    surah.namaLatin,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          surah.nama,
                          style: GoogleFonts.getFont(
                            _appService.fontFamily,
                            color: Colors.white70,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${surah.arti} • ${surah.jumlahAyat} Ayat',
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: (!_appService.showLatin && !_appService.showTranslation)
                    ? SliverToBoxAdapter(
                        child: _buildMushafView(surah),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final ayat = surah.ayat[index];

                            // Trigger initial jump once to bring the target near the viewport
                            if (widget.initialAyat != null && _isInitialLoad) {
                              _isInitialLoad = false;
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                // Estimate position (approx 250px per verse)
                                double estimate = (widget.initialAyat! - 1) * 250.0;
                                if (estimate > 0) {
                                  _scrollController.jumpTo(estimate);
                                }
                              });
                            }

                            // Auto scroll logic for precise positioning
                            if (widget.initialAyat != null &&
                                ayat.nomorAyat == widget.initialAyat &&
                                !_hasScrolled) {
                              _hasScrolled = true;
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (_targetKey.currentContext != null) {
                                  Scrollable.ensureVisible(
                                    _targetKey.currentContext!,
                                    duration: const Duration(milliseconds: 600),
                                    curve: Curves.easeInOut,
                                  );
                                }
                              });
                              return Container(
                                key: _targetKey,
                                child: _buildAyatItem(
                                    ayat, surah.nomor, surah.namaLatin),
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
          );
        },
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
                  style: TextStyle(
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
                  _appService.toggleVerseBookmark(
                    BookmarkModel(
                      surahNomor: surahNomor,
                      ayatNomor: ayat.nomorAyat,
                      surahName: surahName,
                      ayatText: ayat.teksArab,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Teks Arab dengan GoogleFonts Amiri & Ukuran Dinamis
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
                style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
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
                      children: ['Amiri', 'Lateef', 'Scheherazade New', 'Noto Naskh Arabic'].map((font) {
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
