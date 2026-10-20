import 'package:flutter/material.dart';
import '../theme.dart';

class EducationTab extends StatefulWidget {
  // Callback opsional jika masih ingin digunakan dari luar, tapi sekarang interaksinya inline
  final Function(String)? openArticle;

  const EducationTab({super.key, this.openArticle});

  @override
  State<EducationTab> createState() => _EducationTabState();
}

class _EducationTabState extends State<EducationTab> {
  // Melacak indeks artikel mana yang sedang terbuka (null berarti tidak ada yang terbuka)
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'BACA & BERTUMBUH',
            style: TextStyle(
              fontFamily: 'Space Grotesk',
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Edukasi',
            style: TextStyle(
              fontFamily: 'Space Grotesk',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 24),

          // Lead Card
          Container(
            decoration: NeoBoxDecoration(
              color: AppColors.darkGreen,
              shadowOffset: 4,
            ),
            padding: const EdgeInsets.all(19),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'PILIHAN HARI INI',
                        style: TextStyle(
                          fontFamily: 'Space Grotesk',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Informasi kecil, dampak besar.',
                        style: TextStyle(
                          fontFamily: 'Space Grotesk',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.menu_book, size: 40, color: AppColors.yellow),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Article List dengan Inline Expandable Content
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: globalArticles.length,
            itemBuilder: (context, index) {
              final article = globalArticles[index];
              final isExpanded = expandedIndex == index;

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: NeoBoxDecoration(
                  color: AppColors.white,
                  shadowOffset: 3,
                ),
                child: Column(
                  children: [
                    // Bagian Utama Kartu (Bisa Diklik)
                    InkWell(
                      onTap: () {
                        setState(() {
                          // Jika diklik ulang, tutup (null). Jika belum, buka indeks ini.
                          expandedIndex = isExpanded ? null : index;
                        });
                        // Jika callback luar masih diperlukan, tetap dipanggil
                        if (widget.openArticle != null) {
                          widget.openArticle!(article.id);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Container(
                              width: 43,
                              height: 43,
                              decoration: BoxDecoration(
                                color: AppColors.cream,
                                border: Border.all(
                                  color: AppColors.ink,
                                  width: 1.5,
                                ),
                              ),
                              child: Icon(article.icon, color: AppColors.ink),
                            ),
                            const SizedBox(width: 13),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article.category,
                                    style: const TextStyle(
                                      fontFamily: 'Space Grotesk',
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    article.title,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Animasi rotasi panah saat terbuka
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

                    // Konten Tambahan yang Muncul ke Bawah Secara Animasi
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
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: AppColors.text2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Berhenti merokok adalah proses pemulihan bertahap. Tubuh mulai merespons perubahan positif lebih cepat dari yang kamu bayangkan.",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                                color: AppColors.ink,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              "Dalam beberapa jam pertama, kadar oksigen meningkat dan karbon monoksida mulai menurun drastis. Konsistenlah dengan langkah kecilmu setiap hari.",
                              style: TextStyle(
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
            },
          ),
        ],
      ),
    );
  }
}