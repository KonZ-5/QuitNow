import 'package:flutter/material.dart';
import '../theme.dart';
import '../utils/responsive.dart';
import '../widgets/bottom_nav.dart';
import 'home_tab.dart';
import 'journey_tab.dart';
import 'achievements_tab.dart';
import 'education_tab.dart';
import 'profile_tab.dart';
import 'setup_screen.dart';
import 'about_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  String activeTab = 'home';
  bool isEditing = false;
  bool isShowingAbout = false;
  String? selectedArticleId;

  @override
  Widget build(BuildContext context) {
    if (isEditing) {
      return SetupScreen(
        compact: true,
        onBack: () => setState(() => isEditing = false),
        onComplete: () => setState(() => isEditing = false),
      );
    }

    if (isShowingAbout) {
      return AboutQuitNowScreen(
        onBack: () => setState(() => isShowingAbout = false),
      );
    }

    final r = Responsive.of(context);

    final tabs = IndexedStack(
      index: _getTabIndex(activeTab),
      children: [
        HomeTab(
          navigateTab: (tab) => setState(() => activeTab = tab),
          onCheckin: () {},
        ),
        JourneyTab(
          openSettings: () => setState(() => isEditing = true),
        ),
        AchievementsTab(
          onBadgeSelect: (badge) {},
        ),
        EducationTab(
          openArticle: (id) => setState(() => selectedArticleId = id),
        ),
        ProfileTab(
          editJourney: () => setState(() => isEditing = true),
          openAbout: () => setState(() => isShowingAbout = true),
          confirm: (type) {},
        ),
      ],
    );

    return Scaffold(
      backgroundColor: AppColors.cream,
      // ADAPTIVE UI berdasarkan ORIENTASI / ukuran layar:
      //  - Landscape atau tablet : SideNav di kiri + konten di kanan (Row).
      //  - Portrait ponsel       : konten + BottomNav di bawah (Stack).
      body: r.useSideNav ? _buildSideNavLayout(tabs) : _buildBottomNavLayout(context, tabs),
    );
  }

  // LANDSCAPE / TABLET
  // Row: SideNav mengambil lebar tetap, Expanded memberi sisa lebar ke konten.
  // SafeArea melindungi dari notch & status bar pada keempat sisi.
  Widget _buildSideNavLayout(Widget tabs) {
    return SafeArea(
      child: Row(
        children: [
          SideNav(
            activeTab: activeTab,
            onTabChanged: (tab) => setState(() => activeTab = tab),
          ),
          Expanded(child: tabs),
        ],
      ),
    );
  }

  // PORTRAIT
  Widget _buildBottomNavLayout(BuildContext context, Widget tabs) {
    // Inset bawah (gesture bar) ditangani BottomNav; konten diberi padding
    // yang sama agar ruang kosong di bawah halaman tidak tertutup nav.
    final double bottomInset = MediaQuery.paddingOf(context).bottom;

    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: tabs,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomNav(
              activeTab: activeTab,
              onTabChanged: (tab) => setState(() => activeTab = tab),
            ),
          ),
        ],
      ),
    );
  }

  int _getTabIndex(String tab) {
    switch (tab) {
      case 'journey':
        return 1;
      case 'awards':
        return 2;
      case 'education':
        return 3;
      case 'profile':
        return 4;
      case 'home':
      default:
        return 0;
    }
  }
}
