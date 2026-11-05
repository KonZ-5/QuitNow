
import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/neo_button.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onFinish;

  const OnboardingScreen({super.key, required this.onFinish});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int step = 0;

  // MATERI 6: PageController digunakan untuk mengontrol Carousel (PageView).
  // Controller ini mengatur perpindahan halaman melalui tombol Lanjut.
  final PageController _pageController = PageController();

  final onboardingData = [
    {
      "title": "Mulai Perjalanan Bebas Rokok",
      "text": "Buat langkah pertamamu menuju hidup yang lebih sehat, satu hari pada satu waktu.",
      "color": AppColors.green,
      "art": "lungs"
    },
    {
      "title": "Pantau Progres Setiap Hari",
      "text": "Lihat waktu, rokok yang dihindari, dan estimasi uang yang berhasil kamu hemat.",
      "color": AppColors.yellow,
      "art": "chart"
    },
    {
      "title": "Rayakan Setiap Pencapaian",
      "text": "Setiap hari layak dirayakan. Buka lencana baru dan terus bertumbuh.",
      "color": AppColors.coral,
      "art": "badge"
    },
  ];

  // MATERI 6: dispose digunakan untuk melepaskan PageController
  // ketika halaman onboarding tidak lagi digunakan.
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // MINGGU 4: Mengakses skema warna dan tipografi Material 3.
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface == Colors.white
          ? AppColors.cream
          : colorScheme.surface,
      body: SafeArea(
        child: Padding(
          // MINGGU 5: Padding memberikan jarak aman pada tepi layar.
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

          // MATERI 6: Column merupakan Multi-Child Widget
          // yang menyusun beberapa widget secara vertikal.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              // MATERI 6: Row menyusun logo dan tombol Lewati secara horizontal.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          border: Border.all(
                            color: AppColors.ink,
                            width: 1.5,
                          ),
                        ),
                        child: const Icon(
                          Icons.eco,
                          size: 20,
                          color: AppColors.ink,
                        ),
                      ),
                      const SizedBox(width: 7),
                      Text(
                        "QuitNow",
                        style: textTheme.titleLarge?.copyWith(
                          fontFamily: 'Space Grotesk',
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: widget.onFinish,
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.onSurface,
                    ),
                    child: const Text(
                      "Lewati",
                      style: TextStyle(
                        color: AppColors.ink,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // MATERI 6: Expanded memberikan ruang fleksibel
              // untuk Carousel agar mengisi area yang tersedia.
              Expanded(
                child: PageView.builder(
                  // MATERI 6: PageView digunakan sebagai Carousel.
                  // Pengguna dapat menggeser onboarding ke kiri dan kanan.
                  controller: _pageController,
                  itemCount: onboardingData.length,

                  // MATERI 6: onPageChanged memperbarui indikator
                  // ketika pengguna berpindah slide secara manual.
                  onPageChanged: (index) {
                    setState(() {
                      step = index;
                    });
                  },

                  itemBuilder: (context, index) {
                    final item = onboardingData[index];

                    // MATERI 6: SingleChildScrollView menjaga
                    // konten tetap dapat digulir pada layar pendek.
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Art Box
                          Container(
                            height: 280,
                            width: double.infinity,
                            decoration: NeoBoxDecoration(
                              color: item["color"] as Color,
                              shadowOffset: 7,
                              borderWidth: 3,
                            ),

                            // MATERI 6: Stack memungkinkan beberapa
                            // widget ditumpuk dalam satu area.
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Ikon utama tetap berada di tengah.
                                Center(
                                  child: _buildArt(
                                    item["art"] as String,
                                  ),
                                ),

                                // MATERI 6: Positioned menempatkan
                                // ikon dekorasi di sudut kanan atas.
                                Positioned(
                                  top: 14,
                                  right: 14,
                                  child: Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      border: Border.all(
                                        color: AppColors.ink,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.auto_awesome,
                                      size: 19,
                                      color: AppColors.ink,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Indikator nomor halaman.
                          Text(
                            "0${index + 1} / 03",
                            style: textTheme.labelSmall?.copyWith(
                              fontFamily: 'Space Grotesk',
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              color: colorScheme.onSurface,
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Judul onboarding.
                          Text(
                            item["title"] as String,
                            style: textTheme.headlineMedium?.copyWith(
                              fontFamily: 'Space Grotesk',
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              height: 1.05,
                              letterSpacing: -1.0,
                              color: colorScheme.onSurface,
                            ),
                          ),

                          const SizedBox(height: 14),

                          // Deskripsi onboarding.
                          Text(
                            item["text"] as String,
                            style: textTheme.bodyLarge?.copyWith(
                              color: AppColors.text2,
                              fontSize: 15,
                              height: 1.55,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Actions & Dots
              // MATERI 6: Row menyusun indikator dan tombol secara horizontal.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // MATERI 6: ListView.builder menampilkan indikator
                  // halaman secara horizontal dan efisien.
                  SizedBox(
                    width: 90,
                    height: 15,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: onboardingData.length,
                      itemBuilder: (context, i) {
                        return Container(
                          margin: const EdgeInsets.only(right: 6),
                          width: i == step ? 27 : 9,
                          height: 9,
                          decoration: BoxDecoration(
                            color: i == step
                                ? AppColors.ink
                                : AppColors.white,
                            border: Border.all(
                              color: AppColors.ink,
                              width: 1.5,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Tombol Lanjut dan Mulai tetap dipertahankan.
                  NeoButton(
                    fullWidth: false,
                    text: step == 2 ? "Mulai" : "Lanjut",
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: AppColors.ink,
                    ),
                    onPressed: () {
                      if (step < onboardingData.length - 1) {
                        // MATERI 6: animateToPage menggeser Carousel
                        // dengan animasi ketika tombol Lanjut ditekan.
                        _pageController.animateToPage(
                          step + 1,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        widget.onFinish();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArt(String artType) {
    if (artType == "lungs") {
      return const Icon(
        Icons.air,
        size: 90,
        color: AppColors.ink,
      );
    } else if (artType == "chart") {
      return const Icon(
        Icons.show_chart,
        size: 90,
        color: AppColors.ink,
      );
    } else {
      return const Icon(
        Icons.emoji_events,
        size: 90,
        color: AppColors.ink,
      );
    }
  }
}
