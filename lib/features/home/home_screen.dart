import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_styles.dart';
import '../../core/widgets/reading_card.dart';
import '../../data/models/reading_model.dart';
import '../../data/repositories/reading_repository.dart';
import '../reading/reading_detail_screen.dart';
import 'widgets/hero_banner.dart';

/// Halaman utama aplikasi KitabKu
/// Menampilkan hero banner dan daftar bacaan utama
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final List<ReadingModel> _allReadings = ReadingRepository.getAllReadings();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ReadingModel> get _filteredReadings {
    if (_searchQuery.isEmpty) return _allReadings;
    return _allReadings.where((reading) {
      return reading.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          reading.category.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredReadings = _filteredReadings;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Column(
        children: [
          // ── FIXED TOP AREA (Non-Scrollable) ──
          Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundPrimary,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // 1. Hero Banner (Hanya muncul jika tidak sedang mencari)
                  if (_searchQuery.isEmpty) const HeroBanner(),

                  // 2. Search Bar (Sekarang di bawah Hero Banner)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 2, 16, 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Cari bacaan atau surat...',
                          hintStyle: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary.withOpacity(0.5),
                          ),
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: AppColors.primary,
                          ),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? IconButton(
                                  icon:
                                      const Icon(Icons.close_rounded, size: 20),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() {
                                      _searchQuery = '';
                                    });
                                  },
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── SCROLLABLE CONTENT (Hanya Daftar Kartu Surat) ──
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // List Surat
                  if (filteredReadings.isEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.search_off_rounded,
                              size: 64,
                              color: AppColors.textSecondary.withOpacity(0.2),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Tidak menemukan "${_searchQuery}"',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final reading = filteredReadings[index];
                          return ReadingCard(
                            reading: reading,
                            index: index,
                            onTap: () => _openReading(context, reading),
                          );
                        },
                        childCount: filteredReadings.length,
                      ),
                    ),

                  // Spasi bawah agar tidak tertutup navbar
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 120),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openReading(BuildContext context, ReadingModel reading) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReadingDetailScreen(reading: reading),
      ),
    );
  }
}
