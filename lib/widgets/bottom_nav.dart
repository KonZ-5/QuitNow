import 'package:flutter/material.dart';
import '../theme.dart';

class BottomNav extends StatelessWidget {
  final String activeTab;
  final Function(String) onTabChanged;

  // PERBAIKAN: Mengubah gaya penulisan konstruktor lama menjadi super.key yang ringkas
  const BottomNav({
    super.key,
    required this.activeTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = [
      {'key': 'home', 'label': 'Beranda', 'icon': Icons.home_outlined},
      {'key': 'journey', 'label': 'Perjalanan', 'icon': Icons.show_chart},
      {'key': 'awards', 'label': 'Pencapaian', 'icon': Icons.emoji_events_outlined},
      {'key': 'education', 'label': 'Edukasi', 'icon': Icons.menu_book_outlined},
      {'key': 'profile', 'label': 'Profil', 'icon': Icons.person_outline},
    ];

    return Container(
      height: 76,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.ink, width: 3)),
      ),
      child: Row(
        children: tabs.map((tab) {
          final isActive = activeTab == tab['key'];
          return Expanded(
            child: InkWell(
              onTap: () => onTabChanged(tab['key'] as String),
              child: Container(
                color: isActive ? AppColors.mint : Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      tab['icon'] as IconData,
                      size: 21,
                      color: AppColors.ink,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      tab['label'] as String,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: AppColors.ink,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
