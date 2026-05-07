import 'package:flutter/material.dart';
import 'package:kitab_ku/features/home/surah_detail_screen.dart';
import '../../data/models/surah_model.dart';
import '../../data/repositories/surah_repository.dart';
import '../../config/theme/app_colors.dart';

class ApiTestScreen extends StatefulWidget {
  final bool isActive;
  const ApiTestScreen({super.key, this.isActive = false});

  @override
  State<ApiTestScreen> createState() => _ApiTestScreenState();
}

class _ApiTestScreenState extends State<ApiTestScreen> with AutomaticKeepAliveClientMixin {
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
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header Al-Quran Premium
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.primary,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsetsDirectional.only(start: 20, bottom: 16),
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

          // Content List Surah
          FutureBuilder<List<SurahModel>>(
            future: _futureSurah,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return SliverFillRemaining(
                  child: Center(child: Text('Error: ${snapshot.error}')),
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
