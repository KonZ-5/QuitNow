import 'package:flutter/material.dart';
import '../theme.dart';

// MINGGU 6 [BARU]: Model data sederhana untuk item fitur.
// Dipakai oleh ListView.separated supaya 4 item fitur tidak ditulis manual satu-satu.
class _FeatureData {
  final IconData icon;
  final Color color;
  final String title;
  final String desc;

  const _FeatureData({
    required this.icon,
    required this.color,
    required this.title,
    required this.desc,
  });
}

class AboutQuitNowScreen extends StatelessWidget {
  final VoidCallback onBack;

  const AboutQuitNowScreen({
    super.key,
    required this.onBack,
  });

  // MINGGU 6 [BARU - POIN 5]: Daftar fitur dipindah menjadi data list.
  // Isi teks, warna, dan ikon SAMA PERSIS dengan versi sebelumnya.
  static const List<_FeatureData> _features = [
    _FeatureData(
      icon: Icons.timer_outlined,
      color: AppColors.mint,
      title: "Pemantauan Progres",
      desc: "Memantau durasi bebas rokok secara mendalam setiap hari.",
    ),
    _FeatureData(
      icon: Icons.account_balance_wallet_outlined,
      color: AppColors.yellow,
      title: "Estimasi Penghematan",
      desc: "Menghitung rokok yang dihindari dan estimasi uang yang dihemat.",
    ),
    _FeatureData(
      icon: Icons.emoji_events_outlined,
      color: AppColors.coral,
      title: "Pencapaian & Lencana",
      desc: "Merayakan setiap milestone perjalanan bebas rokokmu.",
    ),
    _FeatureData(
      icon: Icons.menu_book_outlined,
      color: AppColors.mint,
      title: "Edukasi & Tips Praktis",
      desc: "Akses informasi tepercaya untuk membangun gaya hidup sehat.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // MINGGU 4: Mengambil skema warna dan tipografi dari Theme context Material 3.
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // MINGGU 4: Menggunakan warna permukaan dari ColorScheme.
      backgroundColor: colorScheme.surface == Colors.white
          ? AppColors.cream
          : colorScheme.surface,
      body: SafeArea(
        // MINGGU 6 [POIN 1]: SingleChildScrollView membungkus Column (multi-child widget)
        // sehingga seluruh halaman bisa di-scroll. Column menyusun banyak child secara vertikal.
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Top Bar
              // MINGGU 5: Container dengan padding simetris sebagai pembungkus header.
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: const BoxDecoration(
                  color: AppColors.cream,
                  border: Border(bottom: BorderSide(color: AppColors.ink, width: 2)),
                ),
                // MINGGU 6 [POIN 2]: Row menyusun tombol kembali + judul secara horizontal.
                child: Row(
                  children: [
                    // MINGGU 4: Material & InkWell untuk mendukung Material 3 State Layers (Ripple Feedback).
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onBack,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          // MINGGU 5: Container dengan dimensi spesifik untuk tombol kembali.
                          width: 40,
                          height: 40,
                          decoration: NeoBoxDecoration(
                            color: AppColors.white,
                            shadowOffset: 0,
                            borderWidth: 2,
                          ),
                          child: const Icon(Icons.arrow_back, color: AppColors.ink),
                        ),
                      ),
                    ),
                    // MINGGU 5: SizedBox untuk menentukan jarak horizontal antar elemen.
                    const SizedBox(width: 14),
                    // MINGGU 6 [BARU - POIN 3]: Row judul dibungkus Expanded
                    // agar mengambil sisa ruang di samping tombol kembali.
                    // Tampilan tidak berubah, hanya mencegah overflow di layar sempit.
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: AppColors.green,
                              border: Border.all(color: AppColors.ink, width: 1.5),
                            ),
                            child: const Icon(Icons.eco, size: 18, color: AppColors.ink),
                          ),
                          const SizedBox(width: 8),
                          // MINGGU 6 [BARU - POIN 3]: Expanded kedua untuk teks judul,
                          // ditambah ellipsis supaya teks panjang tidak menabrak batas.
                          Expanded(
                            child: Text(
                              "Tentang QuitNow",
                              overflow: TextOverflow.ellipsis, // MINGGU 6 [BARU]
                              // MINGGU 4: Tipografi judul header mengacu pada TextTheme titleMedium.
                              style: textTheme.titleMedium?.copyWith(
                                fontFamily: 'Space Grotesk',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                // MINGGU 5: Single-child layout Padding untuk membungkus konten utama.
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Branding Card
                    // MINGGU 6 [BARU - POIN 4]: Stack membungkus hero card agar ada lapisan
                    // kedua (kotak badge "V1.0") yang menumpuk di atas kartu hijau.
                    // Lapisan 1 = Container kartu (ukuran Stack mengikuti kartu ini),
                    // lapisan 2 = Positioned badge di pojok kanan atas.
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                    Container(
                      width: double.infinity,
                      decoration: NeoBoxDecoration(
                        color: AppColors.green,
                        shadowOffset: 5,
                        borderWidth: 3,
                      ),
                      padding: const EdgeInsets.all(22),
                      // MINGGU 6 [POIN 2]: Column menumpuk ikon, nama aplikasi, dan versi ke bawah.
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.yellow,
                              border: Border.all(color: AppColors.ink, width: 2),
                            ),
                            child: const Icon(Icons.eco, size: 36, color: AppColors.ink),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "QuitNow",
                            // MINGGU 4: Tipografi merek utama menggunakan headlineMedium Material 3.
                            style: textTheme.headlineMedium?.copyWith(
                              fontFamily: 'Space Grotesk',
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -1,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Aplikasi Kesehatan Mobile",
                            // MINGGU 4: Label versi menggunakan labelSmall TextTheme.
                            style: textTheme.labelSmall?.copyWith(
                              fontFamily: 'Space Grotesk',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.ink,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // MINGGU 6 [BARU - POIN 4]: Lapisan atas Stack: kotak badge versi.
                    // Warna kuning + border ink 2 px sama dengan kotak ikon daun di sebelah kirinya.
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.yellow,
                          border: Border.all(color: AppColors.ink, width: 2),
                        ),
                        child: Text(
                          "V1.0",
                          style: textTheme.labelSmall?.copyWith(
                            fontFamily: 'Space Grotesk',
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppColors.ink,
                          ),
                        ),
                      ),
                    ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Deskripsi Utama QuitNow
                    Text(
                      "APA ITU QUITNOW?",
                      // MINGGU 4: Subjudul section menggunakan labelSmall Material 3.
                      style: textTheme.labelSmall?.copyWith(
                        fontFamily: 'Space Grotesk',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: NeoBoxDecoration(
                        color: AppColors.white,
                        shadowOffset: 3,
                      ),
                      padding: const EdgeInsets.all(18),
                      child: Text(
                        "QuitNow adalah aplikasi kesehatan mobile yang dirancang untuk membantu pengguna menjalani proses berhenti merokok melalui pemantauan progres harian, pencapaian target, edukasi kesehatan, dan pembentukan kebiasaan positif.",
                        // MINGGU 4: Teks deskripsi terhubung dengan bodyMedium Material 3.
                        style: textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          color: AppColors.ink,
                          height: 1.6,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Seksi Fitur Utama
                    Text(
                      "FITUR UNGGULAN",
                      style: textTheme.labelSmall?.copyWith(
                        fontFamily: 'Space Grotesk',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // MINGGU 6 [DIUBAH - POIN 5]: 4 pemanggilan _buildFeatureItem manual
                    // (yang dipisah SizedBox(height: 12)) diganti dengan ListView.separated.
                    // Hasil tampilan sama: jarak antar item tetap 12 px.
                    ListView.separated(
                      // shrinkWrap + NeverScrollableScrollPhysics wajib karena ListView ini
                      // berada di dalam SingleChildScrollView (agar tidak bentrok scroll).
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      // padding zero agar ListView tidak menambah padding bawaan.
                      padding: EdgeInsets.zero,
                      // Clip.none supaya bayangan neo (shadow offset) di sisi kanan/bawah
                      // item tidak terpotong oleh batas ListView.
                      clipBehavior: Clip.none,
                      itemCount: _features.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = _features[index];
                        return _buildFeatureItem(
                          context: context,
                          icon: item.icon,
                          color: item.color,
                          title: item.title,
                          desc: item.desc,
                        );
                      },
                    ),
                    const SizedBox(height: 28),

                    // Komitmen SDG 3
                    Container(
                      decoration: NeoBoxDecoration(
                        color: AppColors.yellow,
                        shadowOffset: 4,
                      ),
                      padding: const EdgeInsets.all(18),
                      // MINGGU 6 [POIN 2]: Row menyejajarkan kotak ikon (kiri) dan teks (kanan).
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              border: Border.all(color: AppColors.ink, width: 2),
                            ),
                            child: const Icon(Icons.favorite, color: AppColors.coral, size: 26),
                          ),
                          const SizedBox(width: 14),
                          // MINGGU 6 [POIN 3]: Expanded membuat kolom teks mengambil
                          // seluruh sisa lebar di samping kotak ikon.
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "MENDUKUNG SDG 3",
                                  style: textTheme.labelSmall?.copyWith(
                                    fontFamily: 'Space Grotesk',
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.9,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "QuitNow berkomitmen mendukung Kehidupan Sehat dan Sejahtera.",
                                  style: textTheme.bodySmall?.copyWith(
                                    fontSize: 11,
                                    color: AppColors.ink,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Copyright Note
                    Center(
                      child: Text(
                        "QUITNOW · HAK CIPTA DILINDUNGI",
                        style: textTheme.labelSmall?.copyWith(
                          fontFamily: 'Space Grotesk',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text2,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required String title,
    required String desc,
  }) {
    // MINGGU 4: Menyelaraskan teks item fitur dengan TextTheme Material 3.
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: NeoBoxDecoration(
        color: AppColors.white,
        shadowOffset: 3,
      ),
      // MINGGU 5: Padding simetris untuk item fitur.
      padding: const EdgeInsets.all(14),
      // MINGGU 6 [POIN 2]: Row = kotak ikon di kiri, Column teks di kanan.
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: AppColors.ink, width: 1.5),
            ),
            // MINGGU 6 [BARU - POIN 4]: Stack dipakai sebagai wadah ikon.
            // alignment center membuat posisi ikon IDENTIK dengan sebelumnya.
            // Stack siap menampung lapisan tambahan (mis. badge) tanpa mengubah layout.
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(icon, color: AppColors.ink, size: 22),
              ],
            ),
          ),
          const SizedBox(width: 14),
          // MINGGU 6 [POIN 3]: Expanded agar teks mengisi sisa lebar & otomatis wrap ke baris baru.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.titleSmall?.copyWith(
                    fontFamily: 'Space Grotesk',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  desc,
                  style: textTheme.bodySmall?.copyWith(
                    fontSize: 11,
                    color: AppColors.text2,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}