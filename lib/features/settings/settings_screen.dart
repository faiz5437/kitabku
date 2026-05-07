import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';
import '../../config/theme/app_text_styles.dart';
import '../../core/services/app_service.dart';

/// Halaman pengaturan aplikasi
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Header ──
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.primary,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              titlePadding:
                  const EdgeInsetsDirectional.only(start: 20, bottom: 16),
              title: const Text(
                'Pengaturan',
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
                        Icons.settings_rounded,
                        size: 150,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Settings Items ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // Tampilan Section
                  _buildSectionTitle('Tampilan'),
                  const SizedBox(height: 8),
                  _buildSettingsCard(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Row(
                          children: [
                            const Icon(Icons.text_fields_rounded, color: AppColors.primary, size: 20),
                            const SizedBox(width: 14),
                            const Text('Ukuran Teks Arab', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                            const Spacer(),
                            Text('${_appService.fontSizeArab.toInt()}'),
                          ],
                        ),
                      ),
                      Slider(
                        value: _appService.fontSizeArab,
                        min: 18,
                        max: 48,
                        activeColor: AppColors.primary,
                        onChanged: (val) => _appService.setFontSizeArab(val),
                      ),
                      const Divider(height: 1),
                      _SettingsTile(
                        icon: Icons.translate_rounded,
                        title: 'Tampilkan Latin',
                        subtitle: _appService.showLatin ? 'Aktif' : 'Non-aktif',
                        trailing: Switch(
                          value: _appService.showLatin,
                          activeColor: AppColors.primary,
                          onChanged: (val) => _appService.setShowLatin(val),
                        ),
                        onTap: () => _appService.setShowLatin(!_appService.showLatin),
                      ),
                      const Divider(height: 1),
                      _SettingsTile(
                        icon: Icons.language_rounded,
                        title: 'Tampilkan Terjemahan',
                        subtitle: _appService.showTranslation ? 'Aktif' : 'Non-aktif',
                        trailing: Switch(
                          value: _appService.showTranslation,
                          activeColor: AppColors.primary,
                          onChanged: (val) => _appService.setShowTranslation(val),
                        ),
                        onTap: () => _appService.setShowTranslation(!_appService.showTranslation),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Tentang Section
                  _buildSectionTitle('Tentang'),
                  const SizedBox(height: 8),
                  _buildSettingsCard(
                    children: [
                      _SettingsTile(
                        icon: Icons.info_outline_rounded,
                        title: 'Tentang Aplikasi',
                        subtitle: 'KitabKu v1.0.0',
                        onTap: () {},
                      ),
                      const Divider(height: 1),
                      _SettingsTile(
                        icon: Icons.star_outline_rounded,
                        title: 'Beri Rating',
                        subtitle: 'Dukung pengembangan',
                        onTap: () {},
                      ),
                      const Divider(height: 1),
                      _SettingsTile(
                        icon: Icons.share_rounded,
                        title: 'Bagikan Aplikasi',
                        subtitle: 'Ajak teman beribadah',
                        onTap: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Footer
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'KitabKu',
                          style: AppTextStyles.heading3.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Versi 1.0.0',
                          style: AppTextStyles.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'بِسْمِ اللَّهِ الرَّحْمَنِ الرَّحِيمِ',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: AppTextStyles.label.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 1,
          color: AppColors.textLight,
        ),
      ),
    );
  }

  Widget _buildSettingsCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border, width: 0.5),
      ),
      child: Column(children: children),
    );
  }
}

/// Tile widget untuk setiap item setting
class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.bodyLarge.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
                  Text(subtitle, style: AppTextStyles.bodySmall),
                ],
              ),
            ),
            trailing ??
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: AppColors.textLight,
                ),
          ],
        ),
      ),
    );
  }
}
