import 'package:flutter/material.dart';
import 'package:kitab_ku/features/home/surah_detail_screen.dart';
import 'package:kitab_ku/features/bookmark/bookmark_screen.dart';
import '../../data/models/surah_model.dart';
import '../../data/repositories/surah_repository.dart';
import '../../config/theme/app_colors.dart';

class ApiTestScreen extends StatefulWidget {
  final bool isActive;
  const ApiTestScreen({super.key, this.isActive = false});

  @override
  State<ApiTestScreen> createState() => _ApiTestScreenState();
}

class _ApiTestScreenState extends State<ApiTestScreen>
    with AutomaticKeepAliveClientMixin {
  final SurahRepository _repository = SurahRepository();
  late Future<List<SurahModel>> _futureSurah;

  @override
  bool get wantKeepAlive => true; // Menjaga halaman tetap hidup di memori

  @override
  void initState() {
    super.initState();
    _futureSurah = _repository.getDaftarSurah();
  }

  @override
  void didUpdateWidget(ApiTestScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Jika halaman sebelumnya tidak aktif dan sekarang aktif, lakukan reload
    if (!oldWidget.isActive && widget.isActive) {
      _refreshData();
    }
  }

  void _refreshData() {
    setState(() {
      _futureSurah = _repository.getDaftarSurah();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: CustomScrollView(
        slivers: [
          // Header Al-Quran Premium
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.primary,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BookmarkScreen()),
                  );
                },
                icon: const Icon(Icons.bookmark_rounded, color: Colors.white),
                tooltip: 'Bookmarks',
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding:
                  const EdgeInsetsDirectional.only(start: 20, bottom: 16),
              title: const Text(
                'Al-Quran',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                ),
                child: Stack(
                  children: [
                    // Dekorasi Ikon Transparan
                    Positioned(
                      right: -20,
                      bottom: -10,
                      child: Icon(
                        Icons.menu_book_rounded,
                        size: 150,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Shadow di bawah SliverAppBar
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

          // Content List Surah
          FutureBuilder<List<SurahModel>>(
            future: _futureSurah,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return SliverFillRemaining(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      _refreshData();
                      await _futureSurah;
                    },
                    color: AppColors.primary,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: _buildErrorView(),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: Text('Tidak ada data')),
                );
              }

              final listSurah = snapshot.data!;

              return SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final surah = listSurah[index];
                      return _buildSurahItem(context, surah);
                    },
                    childCount: listSurah.length,
                  ),
                ),
              );
            },
          ),

          // Spacing untuk navbar
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshData,
        backgroundColor: AppColors.primary,
        mini: true,
        child: const Icon(Icons.refresh, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon error
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.wifi_off_rounded,
                size: 64,
                color: Colors.red.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 24),

            // Judul
            const Text(
              'Koneksi Gagal',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),

            // Deskripsi
            Text(
              'Tidak dapat memuat data Al-Quran.\nPastikan koneksi internet Anda aktif\ndan coba lagi.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 28),

            // Tombol Coba Lagi
            ElevatedButton.icon(
              onPressed: _refreshData,
              icon: const Icon(Icons.refresh_rounded, size: 20),
              label: const Text('Coba Lagi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSurahItem(BuildContext context, SurahModel surah) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SurahDetailScreen(nomor: surah.nomor),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.border.withOpacity(0.5)),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '${surah.nomor}',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          title: Text(
            surah.namaLatin,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(
            '${surah.arti} • ${surah.jumlahAyat} Ayat',
            style: TextStyle(color: AppColors.textLight, fontSize: 13),
          ),
          trailing: Text(
            surah.nama,
            style: TextStyle(
              fontSize: 20,
              color: AppColors.primary,
              fontFamily: 'Arabic',
            ),
          ),
        ),
      ),
    );
  }
}
