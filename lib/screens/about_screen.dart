import 'package:flutter/material.dart';
import '../theme.dart';

class AboutQuitNowScreen extends StatelessWidget {
  final VoidCallback onBack;

  const AboutQuitNowScreen({
    super.key,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Top Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: const BoxDecoration(
                  color: AppColors.cream,
                  border: Border(bottom: BorderSide(color: AppColors.ink, width: 2)),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: onBack,
                      child: Container(
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
                    const SizedBox(width: 14),
                    Row(
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
                        const Text(
                          "Tentang QuitNow",
                          style: TextStyle(
                            fontFamily: 'Space Grotesk',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero Branding Card
                    Container(
                      width: double.infinity,
                      decoration: NeoBoxDecoration(
                        color: AppColors.green,
                        shadowOffset: 5,
                        borderWidth: 3,
                      ),
                      padding: const EdgeInsets.all(22),
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
                          const Text(
                            "QuitNow",
                            style: TextStyle(
                              fontFamily: 'Space Grotesk',
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Aplikasi Kesehatan Mobile · Versi 1.0",
                            style: TextStyle(
                              fontFamily: 'Space Grotesk',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.ink,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Deskripsi Utama QuitNow
                    const Text(
                      "APA ITUS QUITNOW?",
                      style: TextStyle(
                        fontFamily: 'Space Grotesk',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: NeoBoxDecoration(
                        color: AppColors.white,
                        shadowOffset: 3,
                      ),
                      padding: const EdgeInsets.all(18),
                      child: const Text(
                        "QuitNow adalah aplikasi kesehatan mobile yang dirancang untuk membantu pengguna menjalani proses berhenti merokok melalui pemantauan progres harian, pencapaian target, edukasi kesehatan, dan pembentukan kebiasaan positif.",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.ink,
                          height: 1.6,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Seksi Fitur Utama
                    const Text(
                      "FITUR UNGGULAN",
                      style: TextStyle(
                        fontFamily: 'Space Grotesk',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 10),

                    _buildFeatureItem(
                      icon: Icons.timer_outlined,
                      color: AppColors.mint,
                      title: "Pemantauan Progres",
                      desc: "Memantau durasi bebas rokok secara mendalam setiap hari.",
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureItem(
                      icon: Icons.account_balance_wallet_outlined,
                      color: AppColors.yellow,
                      title: "Estimasi Penghematan",
                      desc: "Menghitung rokok yang dihindari dan estimasi uang yang dihemat.",
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureItem(
                      icon: Icons.emoji_events_outlined,
                      color: AppColors.coral,
                      title: "Pencapaian & Lencana",
                      desc: "Merayakan setiap milestone perjalanan bebas rokokmu.",
                    ),
                    const SizedBox(height: 12),
                    _buildFeatureItem(
                      icon: Icons.menu_book_outlined,
                      color: AppColors.mint,
                      title: "Edukasi & Tips Praktis",
                      desc: "Akses informasi tepercaya untuk membangun gaya hidup sehat.",
                    ),
                    const SizedBox(height: 28),

                    // Komitmen SDG 3
                    Container(
                      decoration: NeoBoxDecoration(
                        color: AppColors.yellow,
                        shadowOffset: 4,
                      ),
                      padding: const EdgeInsets.all(18),
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "MENDUKUNG SDG 3",
                                  style: TextStyle(
                                    fontFamily: 'Space Grotesk',
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.9,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "QuitNow berkomitmen mendukung Kehidupan Sehat dan Sejahtera.",
                                  style: TextStyle(
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
                    const Center(
                      child: Text(
                        "QUITNOW · HAK CIPTA DILINDUNGI",
                        style: TextStyle(
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
    required IconData icon,
    required Color color,
    required String title,
    required String desc,
  }) {
    return Container(
      decoration: NeoBoxDecoration(
        color: AppColors.white,
        shadowOffset: 3,
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(color: AppColors.ink, width: 1.5),
            ),
            child: Icon(icon, color: AppColors.ink, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Space Grotesk',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  desc,
                  style: const TextStyle(
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