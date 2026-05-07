import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_styles.dart';
import '../../data/models/reading_model.dart';

/// Card widget untuk menampilkan item doa
class DoaCard extends StatelessWidget {
  final DoaModel doa;
  final VoidCallback onTap;

  const DoaCard({
    super.key,
    required this.doa,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.backgroundCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border, width: 0.5),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.accent.withOpacity(0.1),
                        AppColors.accentLight.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.volunteer_activism_rounded,
                    color: AppColors.accent,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doa.title,
                        style: AppTextStyles.heading3.copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        doa.source,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Arrow
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: AppColors.textLight,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
