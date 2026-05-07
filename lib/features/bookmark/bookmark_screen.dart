import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_styles.dart';
import '../../core/services/app_service.dart';
import '../../data/repositories/surah_repository.dart';
import '../home/surah_detail_screen.dart';
import '../../data/models/bookmark_model.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  final AppService _appService = AppService();
  @override
  void initState() {
    super.initState();
    _appService.addListener(_rebuild);
  }

  @override
  void dispose() {
    _appService.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Builder(
        builder: (context) {
          final bookmarks = _appService.bookmarks;

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Header Bookmark
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
                    'Bookmark',
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
                        Positioned(
                          right: -20,
                          bottom: -10,
                          child: Icon(
                            Icons.bookmark_rounded,
                            size: 150,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              if (bookmarks.isEmpty)
                _buildEmptyState()
              else
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final bookmark = bookmarks[index];
                        return _buildBookmarkItem(context, bookmark);
                      },
                      childCount: bookmarks.length,
                    ),
                  ),
                ),
                
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.bookmark_outline_rounded,
                  size: 48,
                  color: AppColors.primary.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Belum Ada Bookmark',
                style: AppTextStyles.heading3.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 8),
              Text(
                'Tandai ayat favoritmu di halaman detail agar muncul di sini.',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textLight),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookmarkItem(BuildContext context, BookmarkModel bookmark) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.border.withOpacity(0.5)),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SurahDetailScreen(
                nomor: bookmark.surahNomor,
                initialAyat: bookmark.ayatNomor,
              ),
            ),
          );
        },
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          child: Text('${bookmark.surahNomor}',
              style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
        ),
        title: Text(
          '${bookmark.surahName} • Ayat ${bookmark.ayatNomor}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          bookmark.ayatText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.bookmark_rounded, color: AppColors.primary),
          onPressed: () => _appService.toggleVerseBookmark(bookmark),
        ),
      ),
    );
  }
}
