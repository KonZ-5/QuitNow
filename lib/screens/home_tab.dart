import 'package:flutter/material.dart';
import '../theme.dart';
import '../utils/responsive.dart';
import '../widgets/adaptive_layout.dart';
import '../widgets/neo_button.dart';

class HomeTab extends StatelessWidget {
  final Function(String) navigateTab;
  final VoidCallback onCheckin;

  const HomeTab({
    super.key,
    required this.navigateTab,
    required this.onCheckin,
  });

  /// MINGGU 5: Container & Padding (Single-child layout) membungkus dialog.
  /// MINGGU 7: Cangkang dialog yang responsif dan adaptif.
  /// - ConstrainedBox  : Membatasi lebar dialog maksimum 420dp (agar tidak melar di tablet/web).
  /// - SingleChildScrollView : Dialog dapat digulir di layar pendek (landscape) sehingga tidak overflow vertikal.
  Widget _dialogShell(Responsive r, Widget child) {
    // MINGGU 7: Menyesuaikan padding internal secara adaptif untuk layar sangat sempit (isUltraNarrow).
    final double pad = r.isUltraNarrow ? 16 : 25;
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: r.isUltraNarrow ? 10 : 20,
        vertical: 16,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: SingleChildScrollView(
          // MINGGU 5: Padding memberi ruang agar bayangan Neo-Brutalist (offset 6) tidak terpotong.
          padding: const EdgeInsets.only(right: 6, bottom: 6),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(pad),
            decoration: NeoBoxDecoration(
              color: AppColors.cream,
              shadowColor: AppColors.green,
              shadowOffset: 6,
              borderWidth: 3,
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  void _showCheckinModal(BuildContext context) {
    // MINGGU 4: Penggunaan skema warna (ColorScheme) dan tipografi (TextTheme) Material Design 3.
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    // MINGGU 7: Responsive.of(context) mengambil metrik ukuran bingkai layar utama.
    final r = Responsive.of(context);

    showDialog(
      context: context,
      barrierColor: const Color(0xB8171717),
      builder: (dialogContext) {
        return _dialogShell(
          r,
          // MINGGU 6: Column menyusun komponen dialog secara vertikal.
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // MINGGU 3: Basic Components - Container & Icon dasar.
              Container(
                width: 58,
                height: 58,
                decoration: NeoBoxDecoration(
                    color: AppColors.yellow, shadowOffset: 3, borderWidth: 2),
                child: const Icon(Icons.favorite_border,
                    size: 35, color: AppColors.ink),
              ),
              const SizedBox(height: 18),
              // MINGGU 3 & MINGGU 4: Text dengan headlineSmall Material 3.
              Text(
                'Bagaimana harimu?',
                style: textTheme.headlineSmall?.copyWith(
                  fontFamily: 'Space Grotesk',
                  fontSize: r.isUltraNarrow ? 20 : 27,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pilih yang paling mendekati perasaanmu saat ini.',
                style: textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                  color: AppColors.text2,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              // MINGGU 6: GridView.builder untuk tampilan pilihan mood.
              // MINGGU 7: LayoutBuilder mengatur jumlah kolom grid berdasarkan batasan lebar (constraints).
              // Jika layar sangat sempit atau stacked (<230px), grid diubah menjadi 1 kolom vertikal.
              LayoutBuilder(
                builder: (context, constraints) {
                  final int columns =
                      (r.isStacked || constraints.maxWidth < 230) ? 1 : 2;
                  const moods = [
                    'Tenang',
                    'Bersemangat',
                    'Biasa saja',
                    'Butuh dukungan'
                  ];
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: moods.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      mainAxisExtent: 48, // MINGGU 5: Mempertahankan tinggi tombol agar tidak terpotong.
                    ),
                    itemBuilder: (context, i) {
                      return _MoodButton(
                        label: moods[i],
                        onTap: () {
                          Navigator.pop(dialogContext);
                          _showSuccessModal(context, r);
                        },
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              Center(
                // MINGGU 4: TextButton Material 3 dengan gaya underline.
                child: TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  style: TextButton.styleFrom(
                      foregroundColor: colorScheme.onSurface),
                  child: const Text(
                    'Nanti saja',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSuccessModal(BuildContext context, Responsive r) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    showDialog(
      context: context,
      barrierColor: const Color(0xB8171717),
      builder: (dialogContext) {
        return _dialogShell(
          r,
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: NeoBoxDecoration(
                    color: AppColors.green, shadowOffset: 3, borderWidth: 2),
                child: const Icon(Icons.check, size: 34, color: AppColors.ink),
              ),
              const SizedBox(height: 18),
              const Text(
                'BERHASIL DICATAT',
                style: TextStyle(
                  fontFamily: 'Space Grotesk',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Bagus, Rani!',
                style: textTheme.headlineSmall?.copyWith(
                  fontFamily: 'Space Grotesk',
                  fontSize: r.isUltraNarrow ? 20 : 27,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Check-in hari ini berhasil dicatat. Terima kasih sudah hadir untuk dirimu.',
                style: textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                  color: AppColors.text2,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              NeoButton(
                text: 'Selesai',
                onPressed: () => Navigator.pop(dialogContext),
              ),
            ],
          ),
        );
      },
    );
  }

  // HALAMAN UTAMA

  @override
  Widget build(BuildContext context) {
    final r = Responsive.of(context);
    final double pad = r.pagePadding;

    // MINGGU 6: SingleChildScrollView membuat seluruh halaman dapat digulir (Scrollable View).
    return SingleChildScrollView(
      // MINGGU 5: Padding mengatur batas ruang aman luar halaman.
      padding: EdgeInsets.fromLTRB(pad, 24, pad, r.pageBottomPadding),
      // MINGGU 7: CenteredContent membatasi lebar maksimum halaman untuk responsivitas layar lebar/tablet.
      child: CenteredContent(
        maxWidth: Responsive.maxContentWidth,
        // MINGGU 6: Column menyusun sekurutan bagian beranda secara vertikal.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, r),
            const SizedBox(height: 24),

            // MINGGU 7: AdaptiveColumns mengatur adaptasi layout:
            // - Portrait: 1 Kolom vertikal.
            // - Landscape / Tablet: 2 Kolom (kiri: kartu progres/hero, kanan: aksi & informasi).
            AdaptiveColumns(
              primary: [
                _buildHeroCard(context, r),
              ],
              secondary: [
                _buildCheckinCard(context, r),
                const SizedBox(height: 24),
                _buildTipsSection(context, r),
                const SizedBox(height: 24),
                _buildNextAchievement(context, r),
              ],
            ),

            const SizedBox(height: 24),
            const Center(
              child: Text(
                'QuitNow mendukung perubahan positif, bukan pengganti saran tenaga kesehatan.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: AppColors.text2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // HEADER SALAM
  Widget _buildHeader(BuildContext context, Responsive r) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bool narrow = r.isUltraNarrow;

    // MINGGU 6: AdaptiveRow (Row) menyusun teks salam dan avatar profil secara horizontal.
    return AdaptiveRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // MINGGU 6: Expanded memberikan ruang fleksibel pada kolom teks agar tidak overflow.
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SELAMAT PAGI!',
                style: textTheme.labelSmall?.copyWith(
                  fontFamily: 'Space Grotesk',
                  fontSize: narrow ? 9 : 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              // MINGGU 7: FittedBox mengecilkan ukuran teks nama secara otomatis jika berada di layar sempit.
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  'Halo, Rani.',
                  style: textTheme.headlineMedium?.copyWith(
                    fontFamily: 'Space Grotesk',
                    fontSize: r.pick(ultraNarrow: 22.0, compact: 30.0, expanded: 34.0),
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
        // MINGGU 4: Semantics memberikan dukungan aksesibilitas pembaca layar pada tombol profil.
        Semantics(
          button: true,
          label: 'Buka profil',
          child: GestureDetector(
            onTap: () => navigateTab('profile'),
            // MINGGU 3: Basic UI - Container avatar berbentuk kustom dengan inisial nama.
            child: Container(
              width: narrow ? 36 : 44,
              height: narrow ? 36 : 44,
              decoration:
                  NeoBoxDecoration(color: AppColors.yellow, shadowOffset: 3),
              alignment: Alignment.center,
              child: Text(
                'RA',
                style: TextStyle(
                  fontFamily: 'Space Grotesk',
                  fontWeight: FontWeight.bold,
                  fontSize: narrow ? 12 : 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // HERO CARD (KOTAK HIJAU PROGRES)
  Widget _buildHeroCard(BuildContext context, Responsive r) {
    final bool narrow = r.isUltraNarrow;

    // MINGGU 5: Container & Padding membentuk kartu hero berdekorasi Neo-Brutalist.
    return Container(
      decoration: NeoBoxDecoration(
          color: AppColors.green, shadowOffset: narrow ? 4 : 6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(narrow ? 12 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // MINGGU 6: Row/AdaptiveRow membungkus judul dan ikon daun.
                // MINGGU 7: Expanded pada teks mencegah right overflow horizontal.
                AdaptiveRow(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'PERJALANAN BEBAS ROKOK',
                        style: TextStyle(
                          fontFamily: 'Space Grotesk',
                          fontSize: narrow ? 10 : 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: narrow ? 0.5 : 0.8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.eco, size: narrow ? 20 : 25, color: AppColors.ink),
                  ],
                ),
                const SizedBox(height: 14),
                // MINGGU 3 & MINGGU 7: RichText dengan TextSpan berukuran besar, dilapisi FittedBox agar responsif.
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(
                      text: '3 ',
                      style: TextStyle(
                        fontFamily: 'Space Grotesk',
                        fontSize: narrow ? 48 : 72,
                        fontWeight: FontWeight.bold,
                        color: AppColors.ink,
                        height: 0.95,
                        letterSpacing: -3,
                      ),
                      children: [
                        TextSpan(
                          text: 'HARI',
                          style: TextStyle(
                            fontSize: narrow ? 22 : 31,
                            letterSpacing: -1,
                          ),
                        ),
                      ],
                    ),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Satu langkah kecil, kemajuan besar.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: narrow ? 12 : 14,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),

          // MINGGU 7: LAYOUTBUILDER & CONSTRAINTS STATISTIK
          // LayoutBuilder membaca batasan lebar KARTU HERU secara independen.
          // Jika lebar kartu < 300dp (misalnya pada layar sempit 220px-300px atau kolom kiri landscape),
          // baris statistik diubah 100% menjadi 1 kolom vertikal penuh ke bawah.
          LayoutBuilder(
            builder: (context, constraints) {
              final bool stacked = constraints.maxWidth < 300 || r.isStacked;
              return Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColors.ink, width: 2),
                  ),
                  color: AppColors.cream,
                ),
                child: stacked
                    ? const Column(
                        children: [
                          _StatItem(
                              value: '45',
                              label: 'Rokok Dihindari',
                              isFullWidth: true),
                          _StatItem(
                              value: 'Rp75rb',
                              label: 'Estimasi Dihemat',
                              isFullWidth: true),
                          _StatItem(
                              value: '43%',
                              label: 'Progres 4 Hari',
                              isLast: true,
                              isFullWidth: true),
                        ],
                      )
                    : const Row(
                        children: [
                          Expanded(
                              child: _StatItem(
                                  value: '45', label: 'Rokok\nDihindari')),
                          Expanded(
                              child: _StatItem(
                                  value: 'Rp75rb', label: 'Estimasi\nDihemat')),
                          Expanded(
                              child: _StatItem(
                                  value: '43%',
                                  label: 'Progres\n4 Hari',
                                  isLast: true)),
                        ],
                      ),
              );
            },
          ),
        ],
      ),
    );
  }

  // CHECK-IN CARD
  Widget _buildCheckinCard(BuildContext context, Responsive r) {
    final bool narrow = r.isUltraNarrow;

    return Semantics(
      button: true,
      label: 'Check-in harian. Bagaimana perasaanmu hari ini?',
      child: GestureDetector(
        onTap: () => _showCheckinModal(context),
        child: Container(
          width: double.infinity,
          decoration: NeoBoxDecoration(color: AppColors.white),
          padding: EdgeInsets.all(narrow ? 10 : 16),
          child: AdaptiveRow(
            children: [
              Container(
                width: narrow ? 36 : 45,
                height: narrow ? 36 : 45,
                decoration: BoxDecoration(
                    color: AppColors.coral,
                    border: Border.all(color: AppColors.ink, width: 2)),
                child: Icon(Icons.favorite_border,
                    size: narrow ? 20 : 24, color: AppColors.ink),
              ),
              SizedBox(width: narrow ? 8 : 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CHECK-IN HARIAN',
                      style: TextStyle(
                        fontFamily: 'Space Grotesk',
                        fontSize: narrow ? 9 : 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Bagaimana perasaanmu hari ini?',
                      style: TextStyle(
                        fontFamily: 'Space Grotesk',
                        fontSize: narrow ? 12 : 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: narrow ? 6 : 10),
              Container(
                width: narrow ? 32 : 42,
                height: narrow ? 32 : 42,
                decoration:
                    NeoBoxDecoration(color: AppColors.yellow, shadowOffset: 2),
                child: Icon(Icons.arrow_forward,
                    size: narrow ? 16 : 24, color: AppColors.ink),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // TIPS HARI INI
  Widget _buildTipsSection(BuildContext context, Responsive r) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bool narrow = r.isUltraNarrow;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AdaptiveRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'TIPS HARI INI',
                style: textTheme.titleSmall?.copyWith(
                  fontFamily: 'Space Grotesk',
                  fontSize: narrow ? 11 : 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.9,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            Text(
              '2 MENIT',
              style: textTheme.labelSmall?.copyWith(
                fontSize: narrow ? 9 : 11,
                fontWeight: FontWeight.bold,
                color: AppColors.text2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 11),
        Semantics(
          button: true,
          label: 'Buka edukasi: Alihkan keinginan dalam 5 menit',
          child: GestureDetector(
            onTap: () => navigateTab('education'),
            child: Container(
              width: double.infinity,
              decoration:
                  NeoBoxDecoration(color: AppColors.white, shadowOffset: 3),
              padding: EdgeInsets.all(narrow ? 10 : 14),
              child: AdaptiveRow(
                children: [
                  Container(
                    width: narrow ? 38 : 47,
                    height: narrow ? 38 : 47,
                    decoration: BoxDecoration(
                        color: AppColors.mint,
                        border: Border.all(color: AppColors.ink, width: 1.5)),
                    child: Icon(Icons.eco,
                        size: narrow ? 22 : 28, color: AppColors.ink),
                  ),
                  SizedBox(width: narrow ? 8 : 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Alihkan keinginan dalam 5 menit',
                          style: TextStyle(
                            fontFamily: 'Space Grotesk',
                            fontSize: narrow ? 12 : 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Minum air, tarik napas, lalu bergerak sebentar.',
                          style: TextStyle(
                              color: AppColors.text2,
                              fontSize: narrow ? 10 : 11),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: narrow ? 4 : 8),
                  Icon(Icons.arrow_forward,
                      size: narrow ? 18 : 24, color: AppColors.ink),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // PENCAPAIAN BERIKUTNYA
  Widget _buildNextAchievement(BuildContext context, Responsive r) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bool narrow = r.isUltraNarrow;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AdaptiveRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'PENCAPAIAN BERIKUTNYA',
                style: textTheme.titleSmall?.copyWith(
                  fontFamily: 'Space Grotesk',
                  fontSize: narrow ? 10 : 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.9,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
            TextButton(
              onPressed: () => navigateTab('awards'),
              style: TextButton.styleFrom(
                foregroundColor: colorScheme.onSurface,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                minimumSize: const Size(0, 36),
              ),
              child: Text(
                'Lihat semua',
                style: TextStyle(
                  fontSize: narrow ? 10 : 11,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 11),
        Semantics(
          button: true,
          label: 'Lihat pencapaian Pejuang Mingguan',
          child: GestureDetector(
            onTap: () => navigateTab('awards'),
            child: Container(
              width: double.infinity,
              decoration:
                  NeoBoxDecoration(color: AppColors.white, shadowOffset: 3),
              padding: EdgeInsets.all(narrow ? 10 : 16),
              child: AdaptiveRow(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: narrow ? 40 : 52,
                    height: narrow ? 40 : 52,
                    decoration: BoxDecoration(
                        color: AppColors.yellow,
                        border: Border.all(color: AppColors.ink, width: 2)),
                    child: Icon(Icons.emoji_events,
                        size: narrow ? 24 : 32, color: AppColors.ink),
                  ),
                  SizedBox(width: narrow ? 8 : 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AdaptiveRow(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '4 Hari',
                                    style: TextStyle(
                                      fontFamily: 'Space Grotesk',
                                      fontSize: narrow ? 14 : 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Pejuang Mingguan',
                                    style: TextStyle(
                                      fontSize: narrow ? 10 : 11,
                                      color: AppColors.text2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.mint,
                                  border: Border.all(color: AppColors.ink),
                                ),
                                child: Text(
                                  '4 hari lagi',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: narrow ? 8 : 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // MINGGU 5: FractionallySizedBox untuk persentase lebar progress bar.
                        Container(
                          height: 11,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            border: Border.all(color: AppColors.ink, width: 1.5),
                          ),
                          child: FractionallySizedBox(
                            widthFactor: 0.43,
                            alignment: Alignment.centerLeft,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppColors.darkGreen,
                                border: Border(
                                  right: BorderSide(
                                      color: AppColors.ink, width: 1.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Kamu sudah hampir setengah jalan. Teruskan!',
                          style: TextStyle(
                              fontSize: narrow ? 9 : 11,
                              color: AppColors.text2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MoodButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _MoodButton({required this.label, required this.onTap});

  @override
  State<_MoodButton> createState() => _MoodButtonState();
}

class _MoodButtonState extends State<_MoodButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // MINGGU 4: Material 3 Ripple feedback & efek bayangan tekan kustom.
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: _isPressed ? AppColors.green : AppColors.white,
          border: Border.all(color: AppColors.ink, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.ink,
              offset: _isPressed ? const Offset(1, 1) : const Offset(2, 2),
              blurRadius: 0,
            ),
          ],
        ),
        transform:
            Matrix4.translationValues(_isPressed ? 1.0 : 0.0, _isPressed ? 1.0 : 0.0, 0.0),
        alignment: Alignment.center,
        child: Text(
          widget.label,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: AppColors.ink,
              ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final bool isLast;
  final bool isFullWidth;

  const _StatItem({
    required this.value,
    required this.label,
    this.isLast = false,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: isFullWidth ? double.infinity : null,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: isFullWidth && !isLast
              ? const BorderSide(color: AppColors.ink, width: 1.5)
              : BorderSide.none,
          right: !isFullWidth && !isLast
              ? const BorderSide(color: AppColors.ink, width: 1.5)
              : BorderSide.none,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // MINGGU 7: FittedBox mencegah angka statistik terpotong jika kolom sangat sempit.
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              maxLines: 1,
              style: textTheme.titleMedium?.copyWith(
                fontFamily: 'Space Grotesk',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.ink,
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: textTheme.bodySmall
                ?.copyWith(fontSize: 10, color: AppColors.text2, height: 1.25),
          ),
        ],
      ),
    );
  }
}