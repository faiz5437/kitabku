import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_styles.dart';
import '../../data/models/reading_model.dart';
import 'islamic_number_frame.dart';

/// Card widget untuk menampilkan item bacaan di list
class ReadingCard extends StatelessWidget {
  final ReadingModel reading;
  final int index;
  final VoidCallback onTap;

  const ReadingCard({
    super.key,
    required this.reading,
    required this.index,
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
                // Islamic Number Frame
                IslamicNumberFrame(
                  number: index + 1,
                  size: 44,
                ),
                const SizedBox(width: 14),

                // Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        reading.title,
                        style: AppTextStyles.heading3.copyWith(fontSize: 15),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        reading.subtitle,
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),

                // Arrow & category badge
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.primarySoft,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        reading.category,
                        style: AppTextStyles.labelBold.copyWith(fontSize: 10),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: AppColors.textLight,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
