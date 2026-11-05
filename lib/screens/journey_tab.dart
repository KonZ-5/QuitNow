import 'package:flutter/material.dart';
import '../theme.dart';

// MINGGU 6: StatefulWidget diperlukan agar bulan dan tanggal
// kalender dapat berubah ketika pengguna berinteraksi.
class JourneyTab extends StatefulWidget {
  final VoidCallback openSettings;

  const JourneyTab({super.key, required this.openSettings});

  @override
  State<JourneyTab> createState() => _JourneyTabState();
}

class _JourneyTabState extends State<JourneyTab> {
  // Bulan awal tetap Juni 2025 sesuai desain awal.
  DateTime displayedMonth = DateTime(2025, 6);

  // Tanggal awal yang dipilih tetap tanggal 20.
  DateTime selectedDate = DateTime(2025, 6, 20);

  // Nama bulan dalam bahasa Indonesia.
  final List<String> monthNames = [
    'JANUARI',
    'FEBRUARI',
    'MARET',
    'APRIL',
    'MEI',
    'JUNI',
    'JULI',
    'AGUSTUS',
    'SEPTEMBER',
    'OKTOBER',
    'NOVEMBER',
    'DESEMBER',
  ];

  // Menghitung jumlah hari dalam bulan yang sedang ditampilkan.
  int get daysInMonth {
    return DateTime(
      displayedMonth.year,
      displayedMonth.month + 1,
      0,
    ).day;
  }

  // Menghitung posisi tanggal 1 pada grid kalender.
  // weekday: Senin = 1 sampai Minggu = 7.
  // Modulo 7 membuat Minggu menjadi kolom pertama.
  int get firstDayOffset {
    return DateTime(
      displayedMonth.year,
      displayedMonth.month,
      1,
    ).weekday % 7;
  }

  // Mengganti bulan dan mempertahankan tanggal terpilih
  // selama tanggal tersebut tersedia pada bulan tujuan.
  void _changeMonth(int amount) {
    setState(() {
      displayedMonth = DateTime(
        displayedMonth.year,
        displayedMonth.month + amount,
      );

      final maxDay = DateTime(
        displayedMonth.year,
        displayedMonth.month + 1,
        0,
      ).day;

      final safeDay = selectedDate.day > maxDay
          ? maxDay
          : selectedDate.day;

      selectedDate = DateTime(
        displayedMonth.year,
        displayedMonth.month,
        safeDay,
      );
    });
  }

  // Memilih tanggal ketika pengguna menekan salah satu tanggal.
  void _selectDate(int day) {
    setState(() {
      selectedDate = DateTime(
        displayedMonth.year,
        displayedMonth.month,
        day,
      );
    });
  }

  // MINGGU 6: Gesture horizontal untuk berpindah bulan.
  void _handleCalendarSwipe(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;

    if (velocity < 0) {
      // Swipe ke kiri: bulan berikutnya.
      _changeMonth(1);
    } else if (velocity > 0) {
      // Swipe ke kanan: bulan sebelumnya.
      _changeMonth(-1);
    }
  }

  @override
  Widget build(BuildContext context) {
    // MINGGU 4: Mengambil skema warna dan tipografi Material 3.
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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

                Container(
                  width: 44,
                  height: 44,
                  decoration: NeoBoxDecoration(
                    color: AppColors.white,
                    shadowOffset: 3,
                  ),
                  child: IconButton(
                    onPressed: widget.openSettings,
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

            // DURATION CARD
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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

                  Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
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
                      Positioned(
                        top: -9,
                        right: -9,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: AppColors.coral,
                            border: Border.all(
                              color: AppColors.ink,
                              width: 1.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.star,
                            size: 13,
                            color: AppColors.ink,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // CALENDAR CARD
            // MINGGU 6: GestureDetector mendeteksi swipe kiri dan kanan
            // tanpa mengubah tampilan kalender.
            GestureDetector(
              onHorizontalDragEnd: _handleCalendarSwipe,
              child: Container(
                decoration: NeoBoxDecoration(
                  color: AppColors.white,
                  shadowOffset: 3,
                ),
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    // NAVIGASI BULAN
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          // Tombol bulan sebelumnya.
                          onPressed: () => _changeMonth(-1),
                          tooltip: 'Bulan sebelumnya',
                          visualDensity: VisualDensity.compact,
                          icon: Icon(
                            Icons.chevron_left,
                            color: colorScheme.onSurface,
                          ),
                        ),

                        Text(
                          '${monthNames[displayedMonth.month - 1]} ${displayedMonth.year}',
                          style: textTheme.titleMedium?.copyWith(
                            fontFamily: 'Space Grotesk',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.7,
                            color: colorScheme.onSurface,
                          ),
                        ),

                        IconButton(
                          // Tombol bulan berikutnya.
                          onPressed: () => _changeMonth(1),
                          tooltip: 'Bulan berikutnya',
                          visualDensity: VisualDensity.compact,
                          icon: Icon(
                            Icons.chevron_right,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // NAMA HARI
                    Row(
                      children: [
                        'MIN',
                        'SEN',
                        'SEL',
                        'RAB',
                        'KAM',
                        'JUM',
                        'SAB',
                      ].map((day) {
                        return Expanded(
                          child: Center(
                            child: Text(
                              day,
                              style: textTheme.labelSmall?.copyWith(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: AppColors.text2,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 10),

                    // GRID TANGGAL
                    // MINGGU 6: GridView.builder menyesuaikan
                    // jumlah tanggal dan posisi hari pada setiap bulan.
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: 1,
                      ),

                      // Jumlah tanggal + ruang kosong sebelum tanggal 1.
                      itemCount: firstDayOffset + daysInMonth,

                      itemBuilder: (context, index) {
                        // Ruang kosong sebelum tanggal pertama.
                        if (index < firstDayOffset) {
                          return const SizedBox.shrink();
                        }

                        final day = index - firstDayOffset + 1;

                        // Tampilan tanggal bebas rokok tetap mengikuti
                        // contoh desain awal untuk Juni 2025.
                        final isDone = displayedMonth.year == 2025 &&
                            displayedMonth.month == 6 &&
                            day >= 16 &&
                            day <= 19;

                        // Tanggal yang sedang dipilih pengguna.
                        final isSelected = selectedDate.year ==
                                displayedMonth.year &&
                            selectedDate.month == displayedMonth.month &&
                            selectedDate.day == day;

                        return GestureDetector(
                          // MINGGU 6: Setiap tanggal dapat ditekan.
                          onTap: () => _selectDate(day),
                          child: Container(
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: isDone
                                  ? AppColors.mint
                                  : AppColors.white,

                              // Garis tepi menandakan tanggal terpilih.
                              border: isSelected
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
                                fontWeight: isDone || isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                fontSize: 12,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}