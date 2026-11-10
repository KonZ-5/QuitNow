import 'package:flutter/material.dart';
import '../theme.dart';
import '../utils/responsive.dart';
import '../widgets/adaptive_layout.dart';

// MINGGU 6: StatefulWidget diperlukan agar state tanggal & bulan
// kalender interaktif dapat diperbarui secara dinamis saat disentuh.
class JourneyTab extends StatefulWidget {
  final VoidCallback openSettings;

  const JourneyTab({super.key, required this.openSettings});

  @override
  State<JourneyTab> createState() => _JourneyTabState();
}

class _JourneyTabState extends State<JourneyTab> {
  DateTime displayedMonth = DateTime(2025, 6);
  DateTime selectedDate = DateTime(2025, 6, 20);

  final List<String> monthNames = [
    'JANUARI', 'FEBRUARI', 'MARET', 'APRIL', 'MEI', 'JUNI',
    'JULI', 'AGUSTUS', 'SEPTEMBER', 'OKTOBER', 'NOVEMBER', 'DESEMBER',
  ];

  int get daysInMonth {
    return DateTime(displayedMonth.year, displayedMonth.month + 1, 0).day;
  }

  int get firstDayOffset {
    return DateTime(displayedMonth.year, displayedMonth.month, 1).weekday % 7;
  }

  void _changeMonth(int amount) {
    setState(() {
      displayedMonth = DateTime(displayedMonth.year, displayedMonth.month + amount);
      final maxDay = DateTime(displayedMonth.year, displayedMonth.month + 1, 0).day;
      final safeDay = selectedDate.day > maxDay ? maxDay : selectedDate.day;
      selectedDate = DateTime(displayedMonth.year, displayedMonth.month, safeDay);
    });
  }

  void _selectDate(int day) {
    setState(() {
      selectedDate = DateTime(displayedMonth.year, displayedMonth.month, day);
    });
  }

  // MINGGU 6: Gesture horizontal untuk mendeteksi usapan (swipe) antar-bulan.
  void _handleCalendarSwipe(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (velocity < 0) {
      _changeMonth(1);
    } else if (velocity > 0) {
      _changeMonth(-1);
    }
  }

  @override
  Widget build(BuildContext context) {
    // MINGGU 7: Membaca konteks metrik layar responsif.
    final r = Responsive.of(context);
    final double pad = r.pagePadding;

    // MINGGU 6: ListView sebagai scroll utama halaman tab perjalanan.
    // MINGGU 7: CenteredContent membatasi lebar konten.
    // AdaptiveColumns memecah layout menjadi 2 kolom di layar lebar/landscape (Kiri: Durasi, Kanan: Kalender).
    return ListView(
      padding: EdgeInsets.fromLTRB(pad, 24, pad, r.pageBottomPadding),
      children: [
        CenteredContent(
          maxWidth: Responsive.maxContentWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, r),
              const SizedBox(height: 24),
              AdaptiveColumns(
                primary: [_buildDurationCard(context, r)],
                secondary: [_buildCalendarCard(context, r)],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // HEADER
  Widget _buildHeader(BuildContext context, Responsive r) {
    // MINGGU 4: Penggunaan Theme Material 3.
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return AdaptiveRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // MINGGU 6 & MINGGU 7: Expanded membatasi lebar Column agar tidak overflow saat layar sempit.
        Expanded(
          child: Column(
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
              // MINGGU 7: FittedBox menyesuaikan ukuran font judul utama secara proporsional.
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Terus melangkah.',
                  style: textTheme.headlineMedium?.copyWith(
                    fontFamily: 'Space Grotesk',
                    fontSize:
                        r.pick(ultraNarrow: 22.0, compact: 30.0, expanded: 34.0),
                    fontWeight: FontWeight.bold,
                    letterSpacing: -1,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // MINGGU 4: IconButton Material 3.
        Container(
          width: r.isUltraNarrow ? 38 : 44,
          height: r.isUltraNarrow ? 38 : 44,
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
    );
  }

  // DURATION CARD (KARTU WAKTU BEBAS ROKOK)
  Widget _buildDurationCard(BuildContext context, Responsive r) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bool narrow = r.isUltraNarrow;

    // MINGGU 5: Container & Padding membentuk kartu durasi.
    return Container(
      width: double.infinity,
      decoration: NeoBoxDecoration(
        color: AppColors.mint,
        shadowOffset: 4,
      ),
      padding: EdgeInsets.all(narrow ? 12 : 20),
      child: AdaptiveRow(
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
                    fontSize: narrow ? 9 : 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 7),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '3 hari, 8 jam',
                    style: textTheme.headlineSmall?.copyWith(
                      fontFamily: 'Space Grotesk',
                      fontSize: narrow ? 20 : 28,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Dimulai 16 Juni 2025',
                  style: textTheme.bodySmall?.copyWith(
                    fontSize: narrow ? 10 : 12,
                    color: AppColors.text2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: narrow ? 14 : 12),
          // MINGGU 6: Stack & Positioned menumpuk bintang dekoratif di atas ikon lencana.
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                width: narrow ? 42 : 54,
                height: narrow ? 42 : 54,
                decoration: NeoBoxDecoration(
                  color: AppColors.yellow,
                  shadowOffset: 3,
                ),
                child: Icon(
                  Icons.auto_awesome,
                  size: narrow ? 24 : 31,
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
    );
  }

  // CALENDAR CARD (KARTU KALENDER BULANAN)
  Widget _buildCalendarCard(BuildContext context, Responsive r) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bool narrow = r.isUltraNarrow;

    // MINGGU 6: GestureDetector mendeteksi usapan gestur horizontal.
    return GestureDetector(
      onHorizontalDragEnd: _handleCalendarSwipe,
      child: Container(
        width: double.infinity,
        decoration: NeoBoxDecoration(
          color: AppColors.white,
          shadowOffset: 3,
        ),
        padding: EdgeInsets.all(narrow ? 8 : 18),
        child: Column(
          children: [
            // NAVIGASI BULAN
            Row(
              children: [
                IconButton(
                  onPressed: () => _changeMonth(-1),
                  tooltip: 'Bulan sebelumnya',
                  visualDensity: VisualDensity.compact,
                  icon: Icon(
                    Icons.chevron_left,
                    color: colorScheme.onSurface,
                  ),
                ),
                // MINGGU 7: Expanded + FittedBox memastikan judul bulan mengecil otomatis bila ruang sempit.
                Expanded(
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '${monthNames[displayedMonth.month - 1]} ${displayedMonth.year}',
                        maxLines: 1,
                        style: textTheme.titleMedium?.copyWith(
                          fontFamily: 'Space Grotesk',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.7,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
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
                'MIN', 'SEN', 'SEL', 'RAB', 'KAM', 'JUM', 'SAB',
              ].map((day) {
                return Expanded(
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        day,
                        style: textTheme.labelSmall?.copyWith(
                          fontSize: narrow ? 7 : 9,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text2,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),

            // MINGGU 6 & MINGGU 7: GridView.builder 7 kolom dengan rasio 1:1.
            // Ukuran sel tanggal membesar dan mengecil secara otomatis mengikuti batas lebar kartu.
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1,
              ),
              itemCount: firstDayOffset + daysInMonth,
              itemBuilder: (context, index) {
                if (index < firstDayOffset) {
                  return const SizedBox.shrink();
                }

                final day = index - firstDayOffset + 1;
                final isDone = displayedMonth.year == 2025 &&
                    displayedMonth.month == 6 &&
                    day >= 16 &&
                    day <= 19;

                final isSelected = selectedDate.year == displayedMonth.year &&
                    selectedDate.month == displayedMonth.month &&
                    selectedDate.day == day;

                return GestureDetector(
                  onTap: () => _selectDate(day),
                  child: Container(
                    margin: EdgeInsets.all(narrow ? 1 : 2),
                    decoration: BoxDecoration(
                      color: isDone ? AppColors.mint : AppColors.white,
                      border: isSelected
                          ? Border.all(
                              color: colorScheme.onSurface,
                              width: 2,
                            )
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '$day',
                        style: textTheme.bodySmall?.copyWith(
                          fontWeight: isDone || isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: narrow ? 10 : 12,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}