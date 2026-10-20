import 'package:flutter/material.dart';
import '../theme.dart';

class JourneyTab extends StatelessWidget {
  final VoidCallback openSettings;

  const JourneyTab({super.key, required this.openSettings});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('PERJALANANMU', style: TextStyle(fontFamily: 'Space Grotesk', fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
                  SizedBox(height: 4),
                  Text('Terus melangkah.', style: TextStyle(fontFamily: 'Space Grotesk', fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: -1)),
                ],
              ),
              GestureDetector(
                onTap: openSettings,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: NeoBoxDecoration(color: AppColors.white, shadowOffset: 3),
                  alignment: Alignment.center,
                  child: const Icon(Icons.settings, color: AppColors.ink),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Duration Card
          Container(
            decoration: NeoBoxDecoration(color: AppColors.mint, shadowOffset: 4),
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('WAKTU BEBAS ROKOK', style: TextStyle(fontFamily: 'Space Grotesk', fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                    SizedBox(height: 7),
                    Text('3 hari, 8 jam', style: TextStyle(fontFamily: 'Space Grotesk', fontSize: 28, fontWeight: FontWeight.bold)),
                    SizedBox(height: 2), // PERBAIKAN: Dikembalikan ke kode asli yang benar
                    Text('Dimulai 16 Juni 2025', style: TextStyle(fontSize: 12, color: AppColors.text2)),
                  ],
                ),
                Container(
                  width: 54,
                  height: 54,
                  decoration: NeoBoxDecoration(color: AppColors.yellow, shadowOffset: 3),
                  child: const Icon(Icons.auto_awesome, size: 31, color: AppColors.ink),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Calendar Card Simulation
          Container(
            decoration: NeoBoxDecoration(color: AppColors.white, shadowOffset: 3),
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.chevron_left, color: AppColors.ink),
                    Text('JUNI 2025', style: TextStyle(fontFamily: 'Space Grotesk', fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 0.7)),
                    Icon(Icons.chevron_right, color: AppColors.ink),
                  ],
                ),
                const SizedBox(height: 18),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    final day = index + 1;
                    final isDone = day >= 16 && day <= 19;
                    final isToday = day == 20;

                    return Container(
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: isDone ? AppColors.mint : AppColors.white,
                        border: isToday ? Border.all(color: AppColors.ink, width: 2) : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$day',
                        style: TextStyle(
                          fontWeight: isDone || isToday ? FontWeight.bold : FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
