
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

  // PERUBAHAN 1:
  // Data onboarding tetap menggunakan struktur Map seperti sebelumnya.
  // Warna, judul, teks, dan ilustrasi tidak diubah.
  final onboardingData = [
    {
      "title": "Mulai Perjalanan Bebas Rokok",
      "text":
          "Buat langkah pertamamu menuju hidup yang lebih sehat, satu hari pada satu waktu.",
      "color": AppColors.green,
      "art": "lungs"
    },
    {
      "title": "Pantau Progres Setiap Hari",
      "text":
          "Lihat waktu, rokok yang dihindari, dan estimasi uang yang berhasil kamu hemat.",
      "color": AppColors.yellow,
      "art": "chart"
    },
    {
      "title": "Rayakan Setiap Pencapaian",
      "text":
          "Setiap hari layak dirayakan. Buka lencana baru dan terus bertumbuh.",
      "color": AppColors.coral,
      "art": "badge"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final item = onboardingData[step];

    // PERUBAHAN 2:
    // Mengambil skema warna dan tipografi dari tema aplikasi.
    // Jika theme.dart belum memiliki ColorScheme khusus,
    // tema default Material 3 tetap dapat digunakan.
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // PERUBAHAN 3:
      // Menggunakan warna surface dari ColorScheme Material 3.
      // Warna krem QuitNow tetap digunakan sebagai fallback.
      backgroundColor: colorScheme.surface == Colors.white
          ? AppColors.cream
          : colorScheme.surface,

      body: SafeArea(
        child: Padding(
          // PERUBAHAN 4:
          // Padding dipertahankan agar struktur layout tidak berubah.
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
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

                      // PERUBAHAN 5:
                      // Gaya nama aplikasi dibuat konsisten
                      // dengan tipografi tema Material 3.
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

                  // PERUBAHAN 6:
                  // TextButton mengikuti tema aplikasi,
                  // tetapi warna dan dekorasi teks tetap dipertahankan.
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

              // Art Box
              // PERUBAHAN 7:
              // NeoBoxDecoration tetap digunakan supaya identitas
              // desain QuitNow tidak berubah.
              // Warna aksen, border, dan bayangan tetap dipertahankan.
              Container(
                height: 280,
                width: double.infinity,
                decoration: NeoBoxDecoration(
                  color: item["color"] as Color,
                  shadowOffset: 7,
                  borderWidth: 3,
                ),
                child: Center(
                  child: _buildArt(item["art"] as String),
                ),
              ),

              const SizedBox(height: 24),

              // PERUBAHAN 8:
              // Indikator nomor halaman menggunakan label kecil
              // dari TextTheme agar hierarki tipografi konsisten.
              Text(
                "0${step + 1} / 03",
                style: textTheme.labelSmall?.copyWith(
                  fontFamily: 'Space Grotesk',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  color: colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 10),

              // PERUBAHAN 9:
              // Judul menggunakan headlineMedium Material 3.
              // Ukuran tetap 32 agar tampilan sebelumnya terjaga.
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

              // PERUBAHAN 10:
              // Teks penjelasan menggunakan bodyLarge dari TextTheme.
              // Ukuran, jarak baris, dan warna tetap mendekati desain awal.
              Text(
                item["text"] as String,
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColors.text2,
                  fontSize: 15,
                  height: 1.55,
                ),
              ),

              const Spacer(),

              // Actions & Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // PERUBAHAN 11:
                  // Indikator halaman tetap menggunakan desain awal.
                  // Hanya nilai ukuran dan warna yang dipertahankan
                  // agar konsisten dengan identitas visual QuitNow.
                  Row(
                    children: List.generate(3, (i) {
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
                    }),
                  ),

                  // PERUBAHAN 12:
                  // NeoButton dan seluruh logika perpindahan
                  // halaman tetap digunakan seperti sebelumnya.
                  NeoButton(
                    fullWidth: false,
                    text: step == 2 ? "Mulai" : "Lanjut",
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: AppColors.ink,
                    ),
                    onPressed: () {
                      if (step < 2) {
                        setState(() => step++);
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

  // PERUBAHAN 13:
  // Fungsi ilustrasi dipertahankan.
  // Ukuran dan warna ikon tidak diubah agar desain tetap sama.
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
