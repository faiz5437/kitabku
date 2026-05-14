import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_styles.dart';
import '../../core/services/app_service.dart';
import '../../data/models/reading_model.dart';

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
  final ScrollController _scrollController = ScrollController();
  bool _isCollapsed = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Simpan sebagai terakhir dibaca
    AppService().setLastRead(widget.reading.id, widget.reading.title);
  }

  void _onScroll() {
    final isCollapsed = _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight - 20);
    if (isCollapsed != _isCollapsed) {
      setState(() => _isCollapsed = isCollapsed);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color.fromARGB(255, 255, 255, 255),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Container(
          color: const Color.fromARGB(255, 255, 255, 255)
              .withOpacity(0.05), // Kembali ke biru sangat samar
          child: SafeArea(
            child: Column(
              children: [
                // ── Fixed Header ──
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: AppColors.islamicGradient,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Watermark Icon
                        Positioned(
                          right: 40,
                          top: -10,
                          bottom: -10,
                          child: Icon(
                            Icons.menu_book_rounded,
                            size: 80,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                        // Header Content
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              if (!(widget.reading.id == 'yasin-fadilah' ||
                                  widget.reading.id == 'tahlil' ||
                                  widget.reading.id == 'husainiyah'))
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              const SizedBox(width: 4),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.reading.title,
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Container(
                                    height: 2,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              // Settings Button
                              if (widget.reading.images == null &&
                                  widget.reading.imageUrl == null)
                                IconButton(
                                  onPressed: _showSettingsSheet,
                                  icon: const Icon(Icons.tune_rounded,
                                      color: Colors.white, size: 20),
                                ),
                              const Icon(
                                Icons.menu_book_rounded,
                                color: Colors.white,
                                size: 32,
                              ),
                              const SizedBox(width: 12),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Scrollable Content ──
                Expanded(
                  child: Container(
                    color: AppColors.backgroundPrimary,
                    child: CustomScrollView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        // Shadow di bawah header
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

                        // ── Content ──
                        SliverToBoxAdapter(
                          child: widget.reading.images != null
                              ? Column(
                                  children: [
                                    ...widget.reading.images!
                                        .map((imagePath) => Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 0),
                                              child: Image.asset(
                                                imagePath,
                                                width: double.infinity,
                                                fit: BoxFit.fitWidth,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
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
                                        widget.reading.imageUrl!
                                                .startsWith('http')
                                            ? Image.network(
                                                widget.reading.imageUrl!,
                                                width: double.infinity,
                                                fit: BoxFit.fitWidth,
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Container(
                                                    height: 300,
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        color:
                                                            AppColors.primary,
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
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return _buildErrorImage();
                                                },
                                              )
                                            : Image.asset(
                                                widget.reading.imageUrl!,
                                                width: double.infinity,
                                                fit: BoxFit.fitWidth,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return _buildErrorImage();
                                                },
                                              ),
                                        const SizedBox(height: 100),
                                      ],
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          // Arabic text
                                          Container(
                                            padding: const EdgeInsets.all(24),
                                            decoration: BoxDecoration(
                                              color: AppColors.backgroundCard,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              border: Border.all(
                                                color: AppColors.border,
                                                width: 0.5,
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors.primary
                                                      .withOpacity(0.05),
                                                  blurRadius: 15,
                                                  offset: const Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                // Section label
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 4,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        color: AppColors.gold,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 8),
                                                    Text(
                                                      'Teks Arab',
                                                      style: AppTextStyles.label
                                                          .copyWith(
                                                        color: AppColors.gold,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 20),

                                                // Arabic content
                                                Text(
                                                  widget.reading.arabicText,
                                                  textAlign: TextAlign.right,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: AppTextStyles
                                                      .arabicLarge
                                                      .copyWith(
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
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                border: Border.all(
                                                  color: AppColors.border,
                                                  width: 0.5,
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 4,
                                                        height: 20,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              AppColors.primary,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(2),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        'Bacaan Latin',
                                                        style: AppTextStyles
                                                            .label
                                                            .copyWith(
                                                          color:
                                                              AppColors.primary,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Text(
                                                    widget.reading.latinText,
                                                    style: AppTextStyles
                                                        .bodyLarge
                                                        .copyWith(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      height: 1.8,
                                                      color: AppColors
                                                          .textSecondary,
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
                                                color: AppColors.primarySoft
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                border: Border.all(
                                                  color: AppColors.primary
                                                      .withOpacity(0.1),
                                                  width: 0.5,
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 4,
                                                        height: 20,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              AppColors.accent,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(2),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      Text(
                                                        'Terjemahan',
                                                        style: AppTextStyles
                                                            .label
                                                            .copyWith(
                                                          color:
                                                              AppColors.accent,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 16),
                                                  Text(
                                                    widget.reading
                                                        .translationText,
                                                    style: AppTextStyles
                                                        .bodyLarge
                                                        .copyWith(
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
                  ),
                ),
              ],
            ),
          ),
        ),
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

  void _showSettingsSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Pengaturan Tampilan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  SwitchListTile(
                    title: const Text('Tampilkan Latin'),
                    value: _showLatin,
                    activeColor: AppColors.primary,
                    onChanged: (value) {
                      setSheetState(() => _showLatin = value);
                      setState(() => _showLatin = value);
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Tampilkan Terjemahan'),
                    value: _showTranslation,
                    activeColor: AppColors.primary,
                    onChanged: (value) {
                      setSheetState(() => _showTranslation = value);
                      setState(() => _showTranslation = value);
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text('Ukuran Font Arab'),
                  Slider(
                    value: _arabicFontSize,
                    min: 20,
                    max: 40,
                    divisions: 10,
                    label: _arabicFontSize.round().toString(),
                    activeColor: AppColors.primary,
                    onChanged: (value) {
                      setSheetState(() => _arabicFontSize = value);
                      setState(() => _arabicFontSize = value);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
