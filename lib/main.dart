import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'config/theme/app_theme.dart';
import 'config/theme/app_colors.dart';
import 'features/home/home_screen.dart';
import 'features/home/api_test_screen.dart';
import 'features/reading/reading_detail_screen.dart';
import 'data/repositories/reading_repository.dart';
import 'features/settings/settings_screen.dart';
import 'features/splash/splash_screen.dart';
import 'core/services/app_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Local Storage Service
  final appService = AppService();
  await appService.init();

  // Set status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const KitabKuApp());
}

/// Root widget aplikasi KitabKu
class KitabKuApp extends StatelessWidget {
  const KitabKuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KitabKu',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}

/// Widget utama dengan bottom navigation bar modern
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  List<Widget> get _screens => [
        const HomeScreen(),
        ApiTestScreen(isActive: _currentIndex == 1),
        ReadingDetailScreen(reading: ReadingRepository.getYasinFadilah()),
        ReadingDetailScreen(reading: ReadingRepository.getTahlil()),
        ReadingDetailScreen(reading: ReadingRepository.getHusainiyah()),
        const SettingsScreen(),
      ];

  final List<_NavItem> _navItems = const [
    _NavItem(
        icon: Icons.home_rounded,
        activeIcon: Icons.home_rounded,
        label: 'Beranda'),
    _NavItem(
        icon: Icons.menu_book_rounded,
        activeIcon: Icons.menu_book_rounded,
        label: 'Al-Quran'),
    _NavItem(
        icon: Icons.library_books_outlined,
        activeIcon: Icons.library_books_rounded,
        label: 'Yasin'),
    _NavItem(
        icon: Icons.volunteer_activism_outlined,
        activeIcon: Icons.volunteer_activism_rounded,
        label: 'Tahlil'),
    _NavItem(
        icon: Icons.auto_stories_outlined,
        activeIcon: Icons.auto_stories_rounded,
        label: 'Husainiyah'),
    _NavItem(
        icon: Icons.settings_outlined,
        activeIcon: Icons.settings_rounded,
        label: 'Lainnya'),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics:
            const BouncingScrollPhysics(), // Membuat geseran terasa lebih ringan dan elastis
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: _screens,
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 30),
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.15),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
          border: Border.all(
            color: AppColors.border.withOpacity(0.5),
            width: 0.5,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_navItems.length, (index) {
                final isActive = _currentIndex == index;
                final item = _navItems[index];
                return _buildNavItem(
                  icon: isActive ? item.activeIcon : item.icon,
                  label: item.label,
                  isActive: isActive,
                  onTap: () {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 16 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? AppColors.primary : AppColors.textLight,
              size: 22,
            ),
            if (isActive) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Data class untuk item navigasi
class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
