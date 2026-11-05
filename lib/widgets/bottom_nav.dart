import 'package:flutter/material.dart';
import '../theme.dart';
import '../utils/responsive.dart';

class _NavTab {
  final String key;
  final String label;
  final IconData icon;
  const _NavTab(this.key, this.label, this.icon);
}

const List<_NavTab> _navTabs = [
  _NavTab('home', 'Beranda', Icons.home_outlined),
  _NavTab('journey', 'Perjalanan', Icons.show_chart),
  _NavTab('awards', 'Pencapaian', Icons.emoji_events_outlined),
  _NavTab('education', 'Edukasi', Icons.menu_book_outlined),
  _NavTab('profile', 'Profil', Icons.person_outline),
];

/// Satu item navigasi (ikon + label). Dipakai oleh [BottomNav] dan [SideNav].
class _NavItem extends StatelessWidget {
  final _NavTab tab;
  final bool isActive;
  final VoidCallback onTap;
  final double iconSize;
  final double fontSize;
  final double gap;

  const _NavItem({
    required this.tab,
    required this.isActive,
    required this.onTap,
    required this.iconSize,
    required this.fontSize,
    required this.gap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: isActive,
      label: tab.label,
      child: InkWell(
        onTap: onTap,
        child: Container(
          color: isActive ? AppColors.mint : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(tab.icon, size: iconSize, color: AppColors.ink),
              SizedBox(height: gap),
              // CONSTRAINT: FittedBox mengecilkan label bila lebar yang
              // diberikan parent (Expanded) tidak cukup -> tidak overflow
              // di layar sempit maupun saat font sistem diperbesar.
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  tab.label,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: AppColors.ink,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Navigasi bawah (mode PORTRAIT / ponsel).
class BottomNav extends StatelessWidget {
  final String activeTab;
  final Function(String) onTabChanged;

  const BottomNav({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);

    // Inset bawah (gesture bar iPhone / navigation bar Android).
    final double bottomInset = MediaQuery.paddingOf(context).bottom;
    final double navHeight = r.isUltraNarrow ? 66 : 76;

    return Container(
      height: navHeight + bottomInset,
      padding: EdgeInsets.only(bottom: bottomInset),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.ink, width: 3)),
      ),
      // Layar <= 330 dp: tiap item minimal 64 dp dan daftar dapat digeser
      // horizontal, sehingga label tetap terbaca dan tidak overflow.
      child: r.isStacked
          ? ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              children: _navTabs.map((tab) {
                return SizedBox(
                  width: (r.width / _navTabs.length).clamp(64.0, 120.0).toDouble(),
                  child: _NavItem(
                    tab: tab,
                    isActive: activeTab == tab.key,
                    onTap: () => onTabChanged(tab.key),
                    iconSize: 18,
                    fontSize: 8.5,
                    gap: 3,
                  ),
                );
              }).toList(),
            )
          : Row(
              children: _navTabs.map((tab) {
                // Expanded: 5 tab membagi lebar parent secara sama rata.
                return Expanded(
                  child: _NavItem(
                    tab: tab,
                    isActive: activeTab == tab.key,
                    onTap: () => onTabChanged(tab.key),
                    iconSize: r.isUltraNarrow ? 17 : 21,
                    fontSize: r.isUltraNarrow ? 7.5 : 9,
                    gap: r.isUltraNarrow ? 2 : 5,
                  ),
                );
              }).toList(),
            ),
    );
  }
}

/// Navigasi samping (mode LANDSCAPE / tablet).
///
/// ADAPTIVE UI: pada landscape tinggi layar sangat terbatas, sehingga
/// navigasi dipindah ke sisi kiri agar area konten tetap luas.
class SideNav extends StatelessWidget {
  final String activeTab;
  final Function(String) onTabChanged;

  const SideNav({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final double navWidth = r.isExpanded ? 104 : 84;
    final double itemHeight = r.isShort ? 60 : 76;

    return Container(
      width: navWidth,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(right: BorderSide(color: AppColors.ink, width: 3)),
      ),
      // ListView: bila tinggi layar tidak cukup untuk 5 item, daftar
      // dapat digulir sehingga tidak overflow.
      child: ListView(
        padding: EdgeInsets.zero,
        children: _navTabs.map((tab) {
          return SizedBox(
            height: itemHeight,
            child: _NavItem(
              tab: tab,
              isActive: activeTab == tab.key,
              onTap: () => onTabChanged(tab.key),
              iconSize: r.isShort ? 20 : 24,
              fontSize: r.isExpanded ? 11 : 9.5,
              gap: r.isShort ? 3 : 5,
            ),
          );
        }).toList(),
      ),
    );
  }
}
