import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/bottom_nav.dart';
import 'home_tab.dart';
import 'journey_tab.dart';
import 'achievements_tab.dart';
import 'education_tab.dart';
import 'profile_tab.dart';
import 'setup_screen.dart';
import 'about_screen.dart'; // Diimpor kembali

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

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: Stack(
        children: [
          IndexedStack(
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
                openAbout: () => setState(() => isShowingAbout = true), // Membuka page Tentang
                confirm: (type) {},
              ),
            ],
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