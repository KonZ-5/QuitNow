import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/neo_button.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onFinish;

  // PERBAIKAN: Mengubah konstruktor lama menggunakan super.key yang lebih ringkas
  const OnboardingScreen({super.key, required this.onFinish});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int step = 0;

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

  @override
  Widget build(BuildContext context) {
    final item = onboardingData[step];

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                          border: Border.all(color: AppColors.ink, width: 1.5),
                        ),
                        child: const Icon(Icons.eco, size: 20, color: AppColors.ink),
                      ),
                      const SizedBox(width: 7),
                      const Text(
                        "QuitNow",
                        style: TextStyle(
                          fontFamily: 'Space Grotesk',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: widget.onFinish,
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
              Container(
                height: 280,
                width: double.infinity,
                decoration: NeoBoxDecoration(
                  color: item["color"] as Color,
                  shadowOffset: 7,
                  borderWidth: 3,
                ),
                child: Center(child: _buildArt(item["art"] as String)),
              ),
              const SizedBox(height: 24),

              // Text Copy
              Text(
                "0${step + 1} / 03",
                style: const TextStyle(
                  fontFamily: 'Space Grotesk',
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                item["title"] as String,
                style: const TextStyle(
                  fontFamily: 'Space Grotesk',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.05,
                  letterSpacing: -1.0,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                item["text"] as String,
                style: const TextStyle(
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
                  Row(
                    children: List.generate(3, (i) {
                      return Container(
                        margin: const EdgeInsets.only(right: 6),
                        width: i == step ? 27 : 9,
                        height: 9,
                        decoration: BoxDecoration(
                          color: i == step ? AppColors.ink : AppColors.white,
                          border: Border.all(color: AppColors.ink, width: 1.5),
                        ),
                      );
                    }),
                  ),
                  NeoButton(
                    fullWidth: false,
                    text: step == 2 ? "Mulai" : "Lanjut",
                    icon: const Icon(Icons.arrow_forward, color: AppColors.ink),
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

  Widget _buildArt(String artType) {
    if (artType == "lungs") {
      return const Icon(Icons.air, size: 90, color: AppColors.ink);
    } else if (artType == "chart") {
      return const Icon(Icons.show_chart, size: 90, color: AppColors.ink);
    } else {
      return const Icon(Icons.emoji_events, size: 90, color: AppColors.ink);
    }
  }
}
