import 'package:flutter/material.dart';
import '../theme.dart';

// MINGGU 6 [DIUBAH]: StatelessWidget diganti StatefulWidget karena carousel
// perlu menyimpan halaman yang sedang aktif (_currentPage) dan PageController.
class AchievementsTab extends StatefulWidget {
  final Function(BadgeItem) onBadgeSelect;

  const AchievementsTab({super.key, required this.onBadgeSelect});

  @override
  State<AchievementsTab> createState() => _AchievementsTabState();
}

class _AchievementsTabState extends State<AchievementsTab> {
  // MINGGU 6 [BARU - POIN 6]: Controller untuk Carousel (PageView) kartu ringkasan.
  late final PageController _pageController;
  // MINGGU 6 [BARU - POIN 6]: Indeks halaman carousel yang sedang tampil (0 = "1 dari 6").
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    // MINGGU 6 [BARU - POIN 6]: Carousel dibuka di halaman terakhir yang sudah terbuka
    // (saat ini "2 dari 6"), jadi tampilan awal SAMA dengan desain sebelumnya.
    final unlockedCount = globalBadges.where((b) => b.unlocked).length;
    final lastIndex = globalBadges.isEmpty ? 0 : globalBadges.length - 1;
    _currentPage = (unlockedCount - 1).clamp(0, lastIndex).toInt();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose(); // MINGGU 6 [BARU]: controller wajib dibuang agar tidak bocor memori.
    super.dispose();
  }

  // MINGGU 6 [BARU - POIN 6]: Pindah halaman carousel (dipanggil tombol panah kiri/kanan).
  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    // MINGGU 4: Penggunaan Skema Warna & Tipografi Material 3.
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // MINGGU 6 [BARU - POIN 6]: Jumlah total lencana = jumlah halaman carousel.
    final total = globalBadges.length;

    // MINGGU 6 [POIN 1]: SingleChildScrollView membungkus Column (multi-child widget)
    // sehingga halaman bisa di-scroll dan banyak widget tersusun vertikal.
    return SingleChildScrollView(
      // MINGGU 5: Single-child layout Padding membungkus seluruh halaman pencapaian.
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'KOLEKSIMU',
            // MINGGU 4: Label header menggunakan labelSmall Material 3.
            style: textTheme.labelSmall?.copyWith(
              fontFamily: 'Space Grotesk',
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Pencapaian',
            // MINGGU 4: Judul utama menggunakan headlineMedium Material 3.
            style: textTheme.headlineMedium?.copyWith(
              fontFamily: 'Space Grotesk',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 24),

          // Summary Card
          // MINGGU 6 [DIUBAH - POIN 6]: Kartu ringkasan "2 dari 6" diubah menjadi CAROUSEL.
          // Bisa digeser (swipe) atau lewat tombol panah di bawahnya.
          // Halaman 1 dari 6 s/d 2 dari 6 = hijau (terbuka), 3 dari 6 s/d 6 dari 6 = abu-abu (terkunci).
          // (Seksi "LENCANA TERBUKA" yang lama sudah dihapus sesuai permintaan ketua kelompok.)
          SizedBox(
            // MINGGU 6 [DIPERBAIKI]: tinggi dinaikkan 100 -> 118 karena kartu aslinya setinggi
            // +-110 px (3 baris teks) + 4 px ruang bayangan neo. Sebelumnya 100 px menyebabkan
            // "BOTTOM OVERFLOWED BY 14 PIXELS". Sisa ruang kecil dibiarkan sebagai cadangan.
            height: 118,
            // MINGGU 6 [POIN 4]: Stack + Positioned(right: -4) dipakai agar lebar kartu
            // tetap SAMA dengan desain awal; 4 px ekstra hanya untuk ruang bayangan neo
            // sehingga bayangan tidak terpotong oleh PageView.
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 0,
                  right: -4,
                  top: 0,
                  bottom: 0,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: total,
                    onPageChanged: (i) => setState(() => _currentPage = i),
                    itemBuilder: (context, index) =>
                        _buildSummaryCard(index, total, textTheme),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // MINGGU 6 [BARU - POIN 6]: Kontrol carousel: panah kiri, penanda halaman, panah kanan.
          // MINGGU 6 [POIN 2]: Row menyejajarkan panah kiri, titik penanda, dan panah kanan.
          Row(
            children: [
              _buildArrowButton(
                icon: Icons.arrow_back,
                enabled: _currentPage > 0,
                onTap: () => _goToPage(_currentPage - 1),
              ),
              // MINGGU 6 [POIN 3]: Expanded agar penanda titik mengisi ruang di antara dua panah.
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(total, (i) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: i == _currentPage ? AppColors.ink : Colors.transparent,
                        border: Border.all(color: AppColors.ink, width: 1.5),
                      ),
                    );
                  }),
                ),
              ),
              _buildArrowButton(
                icon: Icons.arrow_forward,
                enabled: _currentPage < total - 1,
                onTap: () => _goToPage(_currentPage + 1),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Badges Grid
          // MINGGU 6 [POIN 5]: GridView.builder menampilkan koleksi lencana 2 kolom.
          // shrinkWrap + NeverScrollableScrollPhysics karena berada di dalam SingleChildScrollView.
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            // MINGGU 6 [BARU]: Clip.none supaya bayangan neo di sisi kanan/bawah
            // kartu tidak terpotong oleh batas GridView.
            clipBehavior: Clip.none,
            // MINGGU 6 [BARU]: padding zero agar GridView tidak menambah padding bawaan.
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 17,
              mainAxisSpacing: 17,
              childAspectRatio: 0.85,
            ),
            itemCount: globalBadges.length,
            itemBuilder: (context, index) {
              final b = globalBadges[index];
              return Container(
                decoration: NeoBoxDecoration(
                  color: b.unlocked ? AppColors.white : AppColors.muted,
                  shadowOffset: 4,
                ),
                // MINGGU 4: Material + InkWell untuk merespons sentuhan dengan M3 State Layers (Ripple).
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => widget.onBadgeSelect(b),
                    child: Padding(
                      // MINGGU 5: Padding dalam untuk konten kartu lencana.
                      padding: const EdgeInsets.all(12),
                      // MINGGU 6 [POIN 2]: Column menumpuk ikon, jumlah hari, dan nama lencana.
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
                            // MINGGU 6 [BARU - POIN 4]: Stack sebagai wadah ikon lencana.
                            // alignment center membuat posisi ikon IDENTIK dengan sebelumnya.
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  b.unlocked ? Icons.emoji_events : Icons.shield_outlined,
                                  size: 32,
                                  color: AppColors.ink,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${b.days} HARI',
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            b.name,
                            style: textTheme.bodySmall?.copyWith(
                              fontSize: 10,
                              color: AppColors.text2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // MINGGU 6 [BARU - POIN 6]: Satu halaman carousel = kartu ringkasan "N dari 6".
  // Terbuka  -> kartu hijau, kotak ikon kuning, ikon piala (sama persis desain lama).
  // Terkunci -> kartu abu-abu, kotak ikon abu-abu, ikon perisai (sama dengan lencana terkunci di grid).
  Widget _buildSummaryCard(int index, int total, TextTheme textTheme) {
    final unlocked = globalBadges[index].unlocked;

    // MINGGU 6 [DIPERBAIKI]: Align(topCenter) melonggarkan batas tinggi dari PageView,
    // sehingga kartu memakai tinggi alaminya (sama seperti desain awal) dan tidak overflow.
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
      // 4 px kanan-bawah = ruang bayangan neo (lihat Positioned right: -4 di atas).
      padding: const EdgeInsets.only(right: 4, bottom: 4),
      child: Container(
        width: double.infinity,
        decoration: NeoBoxDecoration(
          color: unlocked ? AppColors.green : AppColors.muted,
          shadowOffset: 4,
        ),
        // MINGGU 5: Padding internal untuk kartu ringkasan.
        padding: const EdgeInsets.all(18),
        // MINGGU 6 [POIN 2]: Row menyejajarkan kotak ikon (kiri) dan teks (kanan).
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: unlocked ? AppColors.yellow : AppColors.muted,
                border: Border.all(color: AppColors.ink, width: 2),
              ),
              child: Icon(
                unlocked ? Icons.emoji_events : Icons.shield_outlined,
                size: 36,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(width: 15),
            // MINGGU 6 [POIN 3]: Expanded membuat kolom teks mengambil sisa lebar
            // di samping kotak ikon.
            Expanded(
              // MINGGU 6 [POIN 2]: Column menumpuk 3 baris teks ringkasan ke bawah.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // MINGGU 6 [BARU]: label menyesuaikan status halaman carousel.
                    unlocked ? 'SUDAH TERBUKA' : 'BELUM TERBUKA',
                    style: textTheme.labelSmall?.copyWith(
                      fontFamily: 'Space Grotesk',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    // MINGGU 6 [BARU]: angka mengikuti halaman: "1 dari 6" ... "6 dari 6".
                    '${index + 1} dari $total',
                    style: textTheme.headlineSmall?.copyWith(
                      fontFamily: 'Space Grotesk',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Setiap progres pantas dirayakan.',
                    style: textTheme.bodySmall?.copyWith(fontSize: 11),
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

  // MINGGU 6 [BARU - POIN 6]: Tombol panah carousel. Gayanya sama dengan tombol kembali
  // di halaman About (putih, border ink 2 px, tanpa bayangan). Memudar saat sudah di ujung.
  Widget _buildArrowButton({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.35,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onTap : null,
          child: Container(
            width: 36,
            height: 36,
            decoration: NeoBoxDecoration(
              color: AppColors.white,
              shadowOffset: 0,
              borderWidth: 2,
            ),
            child: Icon(icon, size: 20, color: AppColors.ink),
          ),
        ),
      ),
    );
  }
}