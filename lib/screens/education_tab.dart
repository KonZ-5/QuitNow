import 'package:flutter/material.dart';
import '../theme.dart';
import '../utils/responsive.dart';
import '../widgets/adaptive_layout.dart';

class EducationTab extends StatefulWidget {
  final Function(String)? openArticle;

  const EducationTab({super.key, this.openArticle});

  @override
  State<EducationTab> createState() => _EducationTabState();
}

class _EducationTabState extends State<EducationTab> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    // MINGGU 4: Penggunaan Skema Warna & Tipografi Material 3.
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    // MINGGU 7: Membaca ukuran layar (screen size) untuk menentukan nilai responsif.
    final r = Responsive.of(context);
    final bool narrow = r.isUltraNarrow;

    // MINGGU 6 [POIN 1]: SingleChildScrollView membungkus Column (multi-child widget)
    // sehingga seluruh tab bisa di-scroll dan banyak widget tersusun vertikal.
    return SingleChildScrollView(
      // MINGGU 5: Single-child layout Padding membungkus seluruh tab edukasi.
      // MINGGU 7: Padding tab melakukan adaptasi tata letak (layout adaptation) terhadap ukuran layar.
      padding: EdgeInsets.fromLTRB(r.pagePadding, 24, r.pagePadding, r.pageBottomPadding),
      // MINGGU 7: CenteredContent membatasi lebar maksimal konten (constraint) pada layar besar.
      child: CenteredContent(
        maxWidth: Responsive.maxContentWidth,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BACA & BERTUMBUH',
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
            'Edukasi',
            // MINGGU 4: Judul utama menggunakan headlineMedium.
            style: textTheme.headlineMedium?.copyWith(
              fontFamily: 'Space Grotesk',
              // MINGGU 7: Ukuran font beradaptasi (layout adaptation) berdasarkan deteksi ukuran layar.
              fontSize: r.pick(ultraNarrow: 22.0, compact: 30.0, expanded: 34.0),
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 24),

          // Lead Card
          Container(
            decoration: NeoBoxDecoration(
              color: AppColors.darkGreen,
              shadowOffset: 4,
            ),
            // MINGGU 5: Padding internal kartu pilihan hari ini.
            // MINGGU 7: Padding Lead Card melakukan adaptasi tata letak (layout adaptation) terhadap layar sempit.
            padding: EdgeInsets.all(narrow ? 12 : 19),
            // MINGGU 6 [POIN 2]: Row menyejajarkan teks (kiri) dan ikon buku (kanan).
            // MINGGU 7: AdaptiveRow mengatur tata letak teks dan ikon berdasarkan ketersediaan ruang layar.
            child: AdaptiveRow(
              children: [
                // MINGGU 6 [POIN 3]: Expanded membuat kolom teks mengambil seluruh sisa
                // lebar di samping ikon, sehingga ikon tetap menempel di kanan.
                Expanded(
                  // MINGGU 6 [POIN 2]: Column menumpuk label dan judul ke bawah.
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PILIHAN HARI INI',
                        style: TextStyle(
                          fontFamily: 'Space Grotesk',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Informasi kecil, dampak besar.',
                        style: TextStyle(
                          fontFamily: 'Space Grotesk',
                          // MINGGU 7: Ukuran font deskripsi beradaptasi dengan ukuran layar (screen size).
                          fontSize: narrow ? 15 : 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                // MINGGU 7: Jarak antar elemen membesar atau mengecil sebagai bagian dari adaptasi layout (layout adaptation).
                SizedBox(width: narrow ? 8 : 12),
                Icon(Icons.menu_book, size: narrow ? 28 : 40, color: AppColors.yellow),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Article List
          // MINGGU 6 [POIN 5]: ListView.builder menampilkan daftar artikel dari globalArticles.
          // shrinkWrap + NeverScrollableScrollPhysics wajib karena ListView ini
          // berada di dalam SingleChildScrollView (agar tidak bentrok scroll).
          // MINGGU 7: LayoutBuilder mengatur jumlah kolom artikel berdasarkan batasan lebar (constraints).
          LayoutBuilder(builder: (context, constraints) {
            Widget buildArticle(BuildContext context, int index) {
              final article = globalArticles[index];
              final isExpanded = expandedIndex == index;

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: NeoBoxDecoration(
                  color: AppColors.white,
                  shadowOffset: 3,
                ),
                // MINGGU 6 [POIN 2]: Column menumpuk baris artikel dan konten tambahan (accordion).
                child: Column(
                  children: [
                    // MINGGU 4: Material & InkWell untuk mendukung Material 3 State Layers (Ripple Feedback).
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            expandedIndex = isExpanded ? null : index;
                          });
                          if (widget.openArticle != null) {
                            widget.openArticle!(article.id);
                          }
                        },
                        child: Padding(
                          // MINGGU 5: Padding ruang dalam baris artikel.
                          // MINGGU 7: Padding dalam baris artikel melakukan adaptasi layout (layout adaptation).
                          padding: EdgeInsets.all(narrow ? 10 : 15),
                          // MINGGU 6 [POIN 2]: Row = ikon (kiri), teks (tengah), panah (kanan).
                          // MINGGU 7: AdaptiveRow digunakan agar baris item artikel beradaptasi secara fleksibel.
                          child: AdaptiveRow(
                            children: [
                              Container(
                                // MINGGU 7: Dimensi wadah ikon beradaptasi dengan ukuran layar (screen size).
                                width: narrow ? 36 : 43,
                                height: narrow ? 36 : 43,
                                decoration: BoxDecoration(
                                  color: AppColors.cream,
                                  border: Border.all(
                                    color: AppColors.ink,
                                    width: 1.5,
                                  ),
                                ),
                                // MINGGU 6 [BARU - POIN 4]: Stack sebagai wadah ikon artikel.
                                // alignment center membuat posisi ikon IDENTIK dengan sebelumnya.
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Icon(article.icon, color: AppColors.ink),
                                  ],
                                ),
                              ),
                              // MINGGU 7: Lebar pembatas elemen antar kolom teks melakukan adaptasi layout (layout adaptation).
                              SizedBox(width: narrow ? 8 : 13),
                              // MINGGU 6 [POIN 3]: Expanded agar teks mengisi sisa lebar
                              // dan otomatis wrap ke baris baru, panah tetap di kanan.
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      article.category,
                                      // MINGGU 4: Kategori menggunakan labelSmall.
                                      style: textTheme.labelSmall?.copyWith(
                                        fontFamily: 'Space Grotesk',
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      article.title,
                                      // MINGGU 4: Judul artikel menggunakan titleSmall.
                                      style: textTheme.titleSmall?.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              AnimatedRotation(
                                turns: isExpanded ? 0.25 : 0.0,
                                duration: const Duration(milliseconds: 200),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: AppColors.ink,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Konten Tambahan yang Muncul ke Bawah
                    AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        decoration: const BoxDecoration(
                          color: AppColors.mint,
                          border: Border(
                            top: BorderSide(
                              color: AppColors.ink,
                              width: 1.5,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            // MINGGU 6 [POIN 2]: Row menyejajarkan ikon jam dan teks waktu baca.
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  size: 14,
                                  color: AppColors.text2,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${article.time} baca",
                                  style: textTheme.bodySmall?.copyWith(
                                    fontSize: 10,
                                    color: AppColors.text2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Berhenti merokok adalah proses pemulihan bertahap. Tubuh mulai merespons perubahan positif lebih cepat dari yang kamu bayangkan.",
                              style: textTheme.bodyMedium?.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                                color: AppColors.ink,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Dalam beberapa jam pertama, kadar oksigen meningkat dan karbon monoksida mulai menurun drastis. Konsistenlah dengan langkah kecilmu setiap hari.",
                              style: textTheme.bodySmall?.copyWith(
                                fontSize: 11,
                                color: AppColors.text2,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      crossFadeState: isExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 250),
                    ),
                  ],
                ),
              );
            }

            // MINGGU 7: Logika adaptasi layout artikel menjadi 2 kolom grid berdasarkan batasan (constraints) lebar layar maksimum.
            if (constraints.maxWidth >= 560) {
              Widget column(int start) => Column(
                    children: [
                      for (int i = start; i < globalArticles.length; i += 2)
                        buildArticle(context, i),
                    ],
                  );
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: column(0)),
                  const SizedBox(width: 20),
                  Expanded(child: column(1)),
                ],
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              clipBehavior: Clip.none,
              padding: EdgeInsets.zero,
              itemCount: globalArticles.length,
              itemBuilder: buildArticle,
            );
          }),
        ],
      ),
      ),
    );
  }
}