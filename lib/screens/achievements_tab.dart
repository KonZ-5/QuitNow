import 'package:flutter/material.dart';
import '../theme.dart';

class AchievementsTab extends StatelessWidget {
  final Function(BadgeItem) onBadgeSelect;

  // PERBAIKAN: Mengubah konstruktor lama menggunakan super.key yang lebih ringkas
  const AchievementsTab({super.key, required this.onBadgeSelect});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('KOLEKSIMU', style: TextStyle(fontFamily: 'Space Grotesk', fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
          const SizedBox(height: 4),
          const Text('Pencapaian', style: TextStyle(fontFamily: 'Space Grotesk', fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: -1)),
          const SizedBox(height: 24),

          // Summary Card
          Container(
            decoration: NeoBoxDecoration(color: AppColors.green, shadowOffset: 4),
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(color: AppColors.yellow, border: Border.all(color: AppColors.ink, width: 2)),
                  child: const Icon(Icons.emoji_events, size: 36, color: AppColors.ink),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('SUDAH TERBUKA', style: TextStyle(fontFamily: 'Space Grotesk', fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                    SizedBox(height: 5),
                    Text('2 dari 6', style: TextStyle(fontFamily: 'Space Grotesk', fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 3),
                    Text('Setiap progres pantas dirayakan.', style: TextStyle(fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Badges Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 17,
              mainAxisSpacing: 17,
              childAspectRatio: 0.85,
            ),
            itemCount: globalBadges.length,
            itemBuilder: (context, index) {
              final b = globalBadges[index];
              return GestureDetector(
                onTap: () => onBadgeSelect(b),
                child: Container(
                  decoration: NeoBoxDecoration(
                    color: b.unlocked ? AppColors.white : AppColors.muted,
                    shadowOffset: 4,
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: b.unlocked
                              ? (b.color == "yellow" ? AppColors.yellow : AppColors.green)
                              : AppColors.muted,
                          border: Border.all(color: AppColors.ink, width: 2),
                        ),
                        child: Icon(
                          b.unlocked ? Icons.emoji_events : Icons.shield_outlined,
                          size: 32,
                          color: AppColors.ink,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('${b.days} HARI', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text(b.name, style: const TextStyle(fontSize: 10, color: AppColors.text2)),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
