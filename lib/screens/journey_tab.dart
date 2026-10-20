
import 'package:flutter/material.dart';
import '../theme.dart';

class JourneyTab extends StatelessWidget {
  final VoidCallback openSettings;

  const JourneyTab({super.key, required this.openSettings});

  @override
  Widget build(BuildContext context) {
    // PERUBAHAN 1:
    // Mengambil skema warna dan tipografi dari tema Material 3.
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
                children: [
                  // PERUBAHAN 2:
                  // Menggunakan labelSmall dari TextTheme.
                  Text(
                    'PERJALANANMU',
                    style: textTheme.labelSmall?.copyWith(
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // PERUBAHAN 3:
                  // Judul menggunakan headlineMedium Material 3.
                  Text(
                    'Terus melangkah.',
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

              // PERUBAHAN 4:
              // GestureDetector diganti dengan IconButton agar
              // interaksi mengikuti pola kontrol Material.
              Container(
                width: 44,
                height: 44,
                decoration: NeoBoxDecoration(
                  color: AppColors.white,
                  shadowOffset: 3,
                ),
                child: IconButton(
                  onPressed: openSettings,
                  tooltip: 'Pengaturan',
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.settings,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Duration Card
          // PERUBAHAN 5:
          // NeoBoxDecoration dipertahankan untuk menjaga
          // identitas visual QuitNow.
          Container(
            decoration: NeoBoxDecoration(
              color: AppColors.mint,
              shadowOffset: 4,
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  // PERUBAHAN 6:
                  // Expanded mencegah teks bertabrakan dengan ikon
                  // ketika layar memiliki lebar yang terbatas.
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // PERUBAHAN 7:
                      // Label durasi menggunakan labelSmall.
                      Text(
                        'WAKTU BEBAS ROKOK',
                        style: textTheme.labelSmall?.copyWith(
                          fontFamily: 'Space Grotesk',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 7),

                      // PERUBAHAN 8:
                      // Informasi durasi menggunakan headlineSmall.
                      Text(
                        '3 hari, 8 jam',
                        style: textTheme.headlineSmall?.copyWith(
                          fontFamily: 'Space Grotesk',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),

                      // PERUBAHAN 9:
                      // Teks sekunder menggunakan bodySmall.
                      Text(
                        'Dimulai 16 Juni 2025',
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          color: AppColors.text2,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Ikon durasi tetap menggunakan desain awal.
                Container(
                  width: 54,
                  height: 54,
                  decoration: NeoBoxDecoration(
                    color: AppColors.yellow,
                    shadowOffset: 3,
                  ),
                  child: Icon(
                    Icons.auto_awesome,
                    size: 31,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Calendar Card Simulation
          // PERUBAHAN 10:
          // Kalender tetap menggunakan Container dan GridView.
          // Struktur dan simulasi tanggal tidak diubah.
          Container(
            decoration: NeoBoxDecoration(
              color: AppColors.white,
              shadowOffset: 3,
            ),
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // PERUBAHAN 11:
                    // Ikon navigasi menggunakan IconButton
                    // agar lebih sesuai dengan pola interaksi Material.
                    IconButton(
                      onPressed: () {
                        // Navigasi bulan belum diimplementasikan.
                      },
                      tooltip: 'Bulan sebelumnya',
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        Icons.chevron_left,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    // PERUBAHAN 12:
                    // Judul kalender menggunakan titleMedium.
                    Text(
                      'JUNI 2025',
                      style: textTheme.titleMedium?.copyWith(
                        fontFamily: 'Space Grotesk',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.7,
                        color: colorScheme.onSurface,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        // Navigasi bulan belum diimplementasikan.
                      },
                      tooltip: 'Bulan berikutnya',
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        Icons.chevron_right,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // PERUBAHAN 13:
                // Grid kalender dipertahankan, dengan ukuran
                // sel dan warna tanggal yang konsisten.
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1,
                  ),
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    final day = index + 1;
                    final isDone = day >= 16 && day <= 19;
                    final isToday = day == 20;

                    return Container(
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: isDone
                            ? AppColors.mint
                            : AppColors.white,
                        border: isToday
                            ? Border.all(
                                color: colorScheme.onSurface,
                                width: 2,
                              )
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$day',
                        style: textTheme.bodySmall?.copyWith(
                          fontWeight: isDone || isToday
                              ? FontWeight.bold
                              : FontWeight.normal,
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
