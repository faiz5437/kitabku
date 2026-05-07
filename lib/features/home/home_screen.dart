import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_styles.dart';
import '../../core/widgets/reading_card.dart';
import '../../core/widgets/doa_card.dart';
import '../../data/models/reading_model.dart';
import '../../data/repositories/reading_repository.dart';
import '../reading/reading_detail_screen.dart';
import '../doa/doa_detail_screen.dart';
import 'widgets/hero_banner.dart';

/// Halaman utama aplikasi KitabKu
/// Menampilkan hero banner, daftar surat, dan quick access doa
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final readings = ReadingRepository.getAllReadings();
    final doas = ReadingRepository.getAllDoa();

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Column(
        children: [
          // ── Fixed Top Header ──
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.menu_book_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'KitabKu',
                    style: AppTextStyles.heading2.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Sticky Hero Banner
          const HeroBanner(),

          // ── Scrollable Content ──
          Expanded(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // ── Section: Bacaan Surat ──
                SliverToBoxAdapter(
                  child: _SectionHeader(
                    title: 'Bacaan Surat',
                    subtitle: '${readings.length} surat tersedia',
                    icon: Icons.menu_book_rounded,
                  ),
                ),

                // ── List Surat ──
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final reading = readings[index];
                      return ReadingCard(
                        reading: reading,
                        index: index,
                        onTap: () => _openReading(context, reading),
                      );
                    },
                    childCount: readings.length,
                  ),
                ),

                // ── Section: Doa Harian ──
                SliverToBoxAdapter(
                  child: _SectionHeader(
                    title: 'Doa Harian',
                    subtitle: '${doas.length} doa pilihan',
                    icon: Icons.volunteer_activism_rounded,
                  ),
                ),

                // ── List Doa (Quick preview, 4 items) ──
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final doa = doas[index];
                      return DoaCard(
                        doa: doa,
                        onTap: () => _openDoa(context, doa),
                      );
                    },
                    childCount: doas.length > 4 ? 4 : doas.length,
                  ),
                ),

                // Bottom spacing for floating navbar
                const SliverToBoxAdapter(
                  child: SizedBox(height: 120),
                ),
              ],
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

  void _openDoa(BuildContext context, DoaModel doa) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DoaDetailScreen(doa: doa),
      ),
    );
  }
}

/// Header section dengan title, subtitle, dan icon
class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.heading3),
              Text(subtitle, style: AppTextStyles.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}
