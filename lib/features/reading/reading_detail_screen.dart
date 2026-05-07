import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_styles.dart';
import '../../core/widgets/islamic_pattern_painter.dart';
import '../../data/models/reading_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

/// Halaman detail bacaan (Surat)
/// Menampilkan teks Arab, latin, dan terjemahan
class ReadingDetailScreen extends StatefulWidget {
  final ReadingModel reading;

  const ReadingDetailScreen({super.key, required this.reading});

  @override
  State<ReadingDetailScreen> createState() => _ReadingDetailScreenState();
}

class _ReadingDetailScreenState extends State<ReadingDetailScreen> {
  bool _showLatin = true;
  bool _showTranslation = true;
  double _arabicFontSize = 28;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Header ──
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.primary,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_rounded),
            ),
            actions: [
              IconButton(
                onPressed: _showSettingsSheet,
                icon: const Icon(Icons.tune_rounded),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.bookmark_outline_rounded),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.islamicGradient,
                ),
                child: IslamicPatternBackground(
                  patternOpacity: 0.06,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        // Decorative frame
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Text(
                                widget.reading.title,
                                style: AppTextStyles.headingOnPrimary.copyWith(
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.reading.subtitle,
                                style: AppTextStyles.bodyOnPrimary,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Bismillah
                        Text(
                          'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white.withOpacity(0.9),
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
            child: widget.reading.pdfPath != null
                ? Container(
                    height: MediaQuery.of(context).size.height - 200,
                    child: SfPdfViewer.asset(
                      widget.reading.pdfPath!,
                    ),
                  )
                : widget.reading.images != null
                    ? Column(
                        children: [
                          ...widget.reading.images!.map((imagePath) => Padding(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: Image.asset(
                                  imagePath,
                                  width: double.infinity,
                                  fit: BoxFit.fitWidth,
                                  errorBuilder: (context, error, stackTrace) {
                                    return _buildErrorImage();
                                  },
                                ),
                              )),
                          const SizedBox(height: 100),
                        ],
                      )
                    : widget.reading.imageUrl != null
                        ? Column(
                            children: [
                              // Check if network or asset
                              widget.reading.imageUrl!.startsWith('http')
                                  ? Image.network(
                                      widget.reading.imageUrl!,
                                      width: double.infinity,
                                      fit: BoxFit.fitWidth,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Container(
                                          height: 300,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.primary,
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          ),
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return _buildErrorImage();
                                      },
                                    )
                                  : Image.asset(
                                      widget.reading.imageUrl!,
                                      width: double.infinity,
                                      fit: BoxFit.fitWidth,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return _buildErrorImage();
                                      },
                                    ),
                              const SizedBox(height: 100),
                            ],
                          )
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Arabic text
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundCard,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.border,
                              width: 0.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.05),
                                blurRadius: 15,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Section label
                              Row(
                                children: [
                                  Container(
                                    width: 4,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: AppColors.gold,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Teks Arab',
                                    style: AppTextStyles.label.copyWith(
                                      color: AppColors.gold,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // Arabic content
                              Text(
                                widget.reading.arabicText,
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: AppTextStyles.arabicLarge.copyWith(
                                  fontSize: _arabicFontSize,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Latin text
                        if (_showLatin) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundCard,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.border,
                                width: 0.5,
                              ),
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
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Bacaan Latin',
                                      style: AppTextStyles.label.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  widget.reading.latinText,
                                  style: AppTextStyles.bodyLarge.copyWith(
                                    fontStyle: FontStyle.italic,
                                    height: 1.8,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        // Translation
                        if (_showTranslation) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.primarySoft.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.primary.withOpacity(0.1),
                                width: 0.5,
                              ),
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
                                        color: AppColors.accent,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Terjemahan',
                                      style: AppTextStyles.label.copyWith(
                                        color: AppColors.accent,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  widget.reading.translationText,
                                  style: AppTextStyles.bodyLarge.copyWith(
                                    height: 1.8,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorImage() {
    return Container(
      height: 200,
      color: Colors.grey[200],
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.broken_image_rounded, size: 40, color: Colors.grey),
            SizedBox(height: 8),
            Text('Gagal memuat gambar'),
          ],
        ),
      ),
    );
  }

  /// Bottom sheet untuk setting tampilan bacaan
  void _showSettingsSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundCard,
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
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('Pengaturan Tampilan',
                      style: AppTextStyles.heading3),
                  const SizedBox(height: 20),

                  // Font size slider
                  Text('Ukuran Teks Arab', style: AppTextStyles.bodyMedium),
                  Slider(
                    value: _arabicFontSize,
                    min: 20,
                    max: 40,
                    activeColor: AppColors.primary,
                    onChanged: (val) {
                      setSheetState(() => _arabicFontSize = val);
                      setState(() => _arabicFontSize = val);
                    },
                  ),
                  const SizedBox(height: 8),

                  // Toggle Latin
                  SwitchListTile(
                    title: Text('Tampilkan Latin',
                        style: AppTextStyles.bodyLarge),
                    value: _showLatin,
                    activeColor: AppColors.primary,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (val) {
                      setSheetState(() => _showLatin = val);
                      setState(() => _showLatin = val);
                    },
                  ),

                  // Toggle Translation
                  SwitchListTile(
                    title: Text('Tampilkan Terjemahan',
                        style: AppTextStyles.bodyLarge),
                    value: _showTranslation,
                    activeColor: AppColors.primary,
                    contentPadding: EdgeInsets.zero,
                    onChanged: (val) {
                      setSheetState(() => _showTranslation = val);
                      setState(() => _showTranslation = val);
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
