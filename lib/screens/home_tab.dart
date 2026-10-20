import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/neo_button.dart';

class HomeTab extends StatelessWidget {
  final Function(String) navigateTab;
  final VoidCallback onCheckin;

  const HomeTab({
    super.key,
    required this.navigateTab,
    required this.onCheckin,
  });

  // Modal Dialog Check-In Harian
  void _showCheckinModal(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: const Color(0xB8171717),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            decoration: NeoBoxDecoration(
              color: AppColors.cream,
              shadowColor: AppColors.green,
              shadowOffset: 6,
              borderWidth: 3,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon Hati Kuning
                Container(
                  width: 58,
                  height: 58,
                  decoration: NeoBoxDecoration(
                    color: AppColors.yellow,
                    shadowOffset: 3,
                    borderWidth: 2,
                  ),
                  child: const Icon(
                    Icons.favorite_border,
                    size: 35,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 18),

                // Judul & Subjudul
                const Text(
                  'Bagaimana harimu?',
                  style: TextStyle(
                    fontFamily: 'Space Grotesk',
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Pilih yang paling mendekati perasaanmu saat ini.',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.text2,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),

                // Grid 4 Pilihan Mood
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2.7,
                  children: [
                    'Tenang',
                    'Bersemangat',
                    'Biasa saja',
                    'Butuh dukungan',
                  ].map((mood) {
                    return _MoodButton(
                      label: mood,
                      onTap: () {
                        Navigator.pop(context);
                        _showSuccessModal(context);
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                // Tombol "Nanti saja"
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'Nanti saja',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.ink,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Modal Sukses Setelah melakukan Check-in
  void _showSuccessModal(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: const Color(0xB8171717),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration: NeoBoxDecoration(
              color: AppColors.cream,
              shadowColor: AppColors.green,
              shadowOffset: 6,
              borderWidth: 3,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: NeoBoxDecoration(
                    color: AppColors.green,
                    shadowOffset: 3,
                    borderWidth: 2,
                  ),
                  child: const Icon(
                    Icons.check,
                    size: 34,
                    color: AppColors.ink,
                  ),
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
                const Text(
                  'Bagus, Rani!',
                  style: TextStyle(
                    fontFamily: 'Space Grotesk',
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Check-in hari ini berhasil dicatat. Terima kasih sudah hadir untuk dirimu.',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.text2,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                NeoButton(
                  text: 'Selesai',
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'SELAMAT PAGI!',
                    style: TextStyle(
                      fontFamily: 'Space Grotesk',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Halo, Rani.',
                    style: TextStyle(
                      fontFamily: 'Space Grotesk',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => navigateTab('profile'),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: NeoBoxDecoration(
                    color: AppColors.yellow,
                    shadowOffset: 3,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'RA',
                    style: TextStyle(
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Hero Card
          Container(
            decoration: NeoBoxDecoration(
              color: AppColors.green,
              shadowOffset: 6,
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'PERJALANAN BEBAS ROKOK',
                            style: TextStyle(
                              fontFamily: 'Space Grotesk',
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.8,
                            ),
                          ),
                          Icon(Icons.eco, size: 25, color: AppColors.ink),
                        ],
                      ),
                      const SizedBox(height: 14),
                      RichText(
                        text: const TextSpan(
                          text: '3 ',
                          style: TextStyle(
                            fontFamily: 'Space Grotesk',
                            fontSize: 72,
                            fontWeight: FontWeight.bold,
                            color: AppColors.ink,
                            height: 0.95,
                            letterSpacing: -5,
                          ),
                          children: [
                            TextSpan(
                              text: 'HARI',
                              style: TextStyle(fontSize: 31, letterSpacing: -1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Satu langkah kecil, kemajuan besar.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),

                // Stats Row
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: AppColors.ink, width: 2),
                    ),
                    color: AppColors.cream,
                  ),
                  child: Row(
                    children: const [
                      Expanded(
                        child: _StatItem(
                          value: '45',
                          label: 'Rokok\nDihindari',
                        ),
                      ),
                      Expanded(
                        child: _StatItem(
                          value: 'Rp75rb',
                          label: 'Estimasi\nDihemat',
                        ),
                      ),
                      Expanded(
                        child: _StatItem(
                          value: '43%',
                          label: 'Progres\n7 Hari',
                          isLast: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Check-in Card
          GestureDetector(
            onTap: () => _showCheckinModal(context),
            child: Container(
              decoration: NeoBoxDecoration(color: AppColors.white),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppColors.coral,
                      border: Border.all(color: AppColors.ink, width: 2),
                    ),
                    child: const Icon(Icons.favorite_border, color: AppColors.ink),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'CHECK-IN HARIAN',
                          style: TextStyle(
                            fontFamily: 'Space Grotesk',
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Bagaimana perasaanmu hari ini?',
                          style: TextStyle(
                            fontFamily: 'Space Grotesk',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: NeoBoxDecoration(
                      color: AppColors.yellow,
                      shadowOffset: 2,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: AppColors.ink,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Tips Hari Ini
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'TIPS HARI INI',
                style: TextStyle(
                  fontFamily: 'Space Grotesk',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.9,
                ),
              ),
              Text(
                '2 MENIT',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: AppColors.text2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          GestureDetector(
            onTap: () => navigateTab('education'),
            child: Container(
              decoration: NeoBoxDecoration(
                color: AppColors.white,
                shadowOffset: 3,
              ),
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 47,
                    height: 47,
                    decoration: BoxDecoration(
                      color: AppColors.mint,
                      border: Border.all(color: AppColors.ink, width: 1.5),
                    ),
                    child: const Icon(
                      Icons.eco,
                      size: 28,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Alihkan keinginan dalam 5 menit',
                          style: TextStyle(
                            fontFamily: 'Space Grotesk',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Minum air, tarik napas, lalu bergerak sebentar.',
                          style: TextStyle(
                            color: AppColors.text2,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward, color: AppColors.ink),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // PENCAPAIAN BERIKUTNYA (Sesuai Gambar Gambar Referensi)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'PENCAPAIAN BERIKUTNYA',
                style: TextStyle(
                  fontFamily: 'Space Grotesk',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.9,
                ),
              ),
              GestureDetector(
                onTap: () => navigateTab('awards'),
                child: const Text(
                  'Lihat semua',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          GestureDetector(
            onTap: () => navigateTab('awards'),
            child: Container(
              decoration: NeoBoxDecoration(
                color: AppColors.white,
                shadowOffset: 3,
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.yellow,
                      border: Border.all(color: AppColors.ink, width: 2),
                    ),
                    child: const Icon(
                      Icons.emoji_events,
                      size: 32,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  '7 HARI',
                                  style: TextStyle(
                                    fontFamily: 'Space Grotesk',
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Pejuang Mingguan',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.text2,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.mint,
                                border: Border.all(color: AppColors.ink),
                              ),
                              child: const Text(
                                '4 hari lagi',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Progress Bar Neo-Brutalism
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
                                    color: AppColors.ink,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Kamu sudah hampir setengah jalan. Teruskan!',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.text2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Health Note (Catatan Kesehatan)
          const Center(
            child: Text(
              'QuitNow mendukung perubahan positif, bukan pengganti saran tenaga kesehatan.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: AppColors.text2),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget Tombol Pilihan Mood
class _MoodButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _MoodButton({
    required this.label,
    required this.onTap,
  });

  @override
  State<_MoodButton> createState() => _MoodButtonState();
}

class _MoodButtonState extends State<_MoodButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
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
        transform: Matrix4.translationValues(
          _isPressed ? 1.0 : 0.0,
          _isPressed ? 1.0 : 0.0,
          0.0,
        ),
        alignment: Alignment.center,
        child: Text(
          widget.label,
          style: const TextStyle(
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

  const _StatItem({
    required this.value,
    required this.label,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 11),
      decoration: BoxDecoration(
        border: Border(
          right: isLast
              ? BorderSide.none
              : const BorderSide(color: AppColors.ink, width: 1.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Space Grotesk',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: AppColors.text2,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}