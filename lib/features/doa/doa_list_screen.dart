import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_styles.dart';
import '../../core/widgets/doa_card.dart';
import '../../data/repositories/reading_repository.dart';
import 'doa_detail_screen.dart';

/// Halaman daftar semua doa
class DoaListScreen extends StatelessWidget {
  const DoaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final doas = ReadingRepository.getAllDoa();

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Header ──
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.accent,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding: const EdgeInsetsDirectional.only(start: 20, bottom: 16),
              title: const Text(
                'Kumpulan Doa',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.accent, AppColors.accentLight],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -20,
                      bottom: -10,
                      child: Icon(
                        Icons.volunteer_activism_rounded,
                        size: 150,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Doa List ──
          SliverPadding(
            padding: const EdgeInsets.only(top: 12),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final doa = doas[index];
                  return DoaCard(
                    doa: doa,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DoaDetailScreen(doa: doa),
                        ),
                      );
                    },
                  );
                },
                childCount: doas.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 100),
          ),
        ],
      ),
    );
  }
}
