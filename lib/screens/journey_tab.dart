import 'package:flutter/material.dart';
import '../theme.dart';

class JourneyTab extends StatelessWidget {
  final VoidCallback openSettings;

  const JourneyTab({super.key, required this.openSettings});

  @override
  Widget build(BuildContext context) {
    // MINGGU 4: Mengambil Skema Warna & Tipografi Material 3.
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      // MINGGU 5: Single-child layout (Padding) pembungkus scrollable area.
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PERJALANANMU',
                    // MINGGU 4: Tipografi labelSmall Material 3.
                    style: textTheme.labelSmall?.copyWith(
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Terus melangkah.',
                    // MINGGU 4: Tipografi headlineMedium Material 3.
                    style: textTheme.headlineMedium?.copyWith(
                      fontFamily: 'Space Grotesk',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              // MINGGU 5: Container tunggal untuk membatasi ukuran tombol aksi.
              Container(
                width: 44,
                height: 44,
                decoration: NeoBoxDecoration(
                  color: AppColors.white,
                  shadowOffset: 3,
                ),
                // MINGGU 4: Penggunaan IconButton agar sesuai kontrol Material.
                child: IconButton(
                  onPressed: openSettings,
                  tooltip: 'Pengaturan',
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.settings, color: colorScheme.onSurface),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Duration Card
          Container(
            decoration: NeoBoxDecoration(color: AppColors.mint, shadowOffset: 4),
            // MINGGU 5: Padding internal untuk konten di dalam kartu durasi.
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'WAKTU BEBAS ROKOK',
                        // MINGGU 4: Menggunakan labelSmall.
                        style: textTheme.labelSmall?.copyWith(
                          fontFamily: 'Space Grotesk',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        '3 hari, 8 jam',
                        // MINGGU 4: Informasi utama durasi menggunakan headlineSmall.
                        style: textTheme.headlineSmall?.copyWith(
                          fontFamily: 'Space Grotesk',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Dimulai 16 Juni 2025',
                        // MINGGU 4: Teks sekunder menggunakan bodySmall.
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: AppColors.text2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 54,
                  height: 54,
                  decoration: NeoBoxDecoration(color: AppColors.yellow, shadowOffset: 3),
                  child: Icon(Icons.auto_awesome, size: 31, color: colorScheme.onSurface),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Calendar Card
          Container(
            decoration: NeoBoxDecoration(color: AppColors.white, shadowOffset: 3),
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // MINGGU 4: Navigasi bulan menggunakan IconButton Material.
                    IconButton(
                      onPressed: () {},
                      tooltip: 'Bulan sebelumnya',
                      visualDensity: VisualDensity.compact,
                      icon: Icon(Icons.chevron_left, color: colorScheme.onSurface),
                    ),
                    Text(
                      'JUNI 2025',
                      // MINGGU 4: Judul kalender menggunakan titleMedium.
                      style: textTheme.titleMedium?.copyWith(
                        fontFamily: 'Space Grotesk',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.7,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      tooltip: 'Bulan berikutnya',
                      visualDensity: VisualDensity.compact,
                      icon: Icon(Icons.chevron_right, color: colorScheme.onSurface),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1,
                  ),
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    final day = index + 1;
                    final isDone = day >= 16 && day <= 19;
                    final isToday = day == 20;

                    return Container(
                      // MINGGU 5: Margin Container sebagai pengatur jarak sel kalender.
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: isDone ? AppColors.mint : AppColors.white,
                        border: isToday
                            ? Border.all(color: colorScheme.onSurface, width: 2)
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$day',
                        // MINGGU 4: Penyesuaian tipografi tanggal menggunakan bodySmall.
                        style: textTheme.bodySmall?.copyWith(
                          fontWeight: isDone || isToday ? FontWeight.bold : FontWeight.normal,
                          fontSize: 12,
                          color: colorScheme.onSurface,
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