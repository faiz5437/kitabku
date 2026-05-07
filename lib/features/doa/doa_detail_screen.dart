import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_styles.dart';
import '../../core/widgets/islamic_pattern_painter.dart';
import '../../data/models/reading_model.dart';

/// Halaman detail doa
/// Menampilkan teks Arab, latin, terjemahan, dan sumber doa
class DoaDetailScreen extends StatelessWidget {
  final DoaModel doa;

  const DoaDetailScreen({super.key, required this.doa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Header ──
          SliverAppBar(
            expandedHeight: 160,
            pinned: true,
            backgroundColor: AppColors.accent,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_rounded),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share_rounded),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.bookmark_outline_rounded),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.accent,
                      AppColors.accentLight,
                    ],
                  ),
                ),
                child: IslamicPatternBackground(
                  patternOpacity: 0.05,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        // Icon
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.volunteer_activism_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          doa.title,
                          style: AppTextStyles.headingOnPrimary.copyWith(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            doa.source,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── Content ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Arabic text card
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundCard,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.gold.withOpacity(0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withOpacity(0.06),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Decorative top
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildDot(),
                            const SizedBox(width: 6),
                            _buildDot(size: 5),
                            const SizedBox(width: 6),
                            Icon(Icons.star,
                                size: 12, color: AppColors.gold),
                            const SizedBox(width: 6),
                            _buildDot(size: 5),
                            const SizedBox(width: 6),
                            _buildDot(),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Arabic text
                        Text(
                          doa.arabicText,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: AppTextStyles.arabicLarge.copyWith(
                            fontSize: 30,
                            height: 2.0,
                          ),
                        ),

                        const SizedBox(height: 24),
                        // Decorative bottom
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildDot(),
                            const SizedBox(width: 6),
                            _buildDot(size: 5),
                            const SizedBox(width: 6),
                            Icon(Icons.star,
                                size: 12, color: AppColors.gold),
                            const SizedBox(width: 6),
                            _buildDot(size: 5),
                            const SizedBox(width: 6),
                            _buildDot(),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Latin
                  _buildSection(
                    label: 'Bacaan Latin',
                    color: AppColors.primary,
                    child: Text(
                      doa.latinText,
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontStyle: FontStyle.italic,
                        height: 1.8,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Translation
                  _buildSection(
                    label: 'Terjemahan',
                    color: AppColors.accent,
                    child: Text(
                      doa.translationText,
                      style: AppTextStyles.bodyLarge.copyWith(
                        height: 1.8,
                      ),
                    ),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot({double size = 4}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.gold,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildSection({
    required String label,
    required Color color,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyles.label.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
