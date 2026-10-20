import 'package:flutter/material.dart';
import '../theme.dart';

class ProfileTab extends StatefulWidget {
  final VoidCallback editJourney;
  final VoidCallback openAbout;
  final Function(String) confirm;

  const ProfileTab({
    super.key,
    required this.editJourney,
    required this.openAbout,
    required this.confirm,
  });

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool notif = true;
  String personalNote = "Hari ini aku pasti bisa melewati rintangan tanpa rokok!";
  bool isEditingNote = false;
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: personalNote);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'AKUN & PREFERENSI',
            style: TextStyle(
              fontFamily: 'Space Grotesk',
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Profil',
            style: TextStyle(
              fontFamily: 'Space Grotesk',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 24),

          // User Card
          Container(
            decoration: NeoBoxDecoration(color: AppColors.yellow, shadowOffset: 4),
            padding: const EdgeInsets.all(17),
            child: Row(
              children: [
                Container(
                  width: 62,
                  height: 62,
                  decoration: NeoBoxDecoration(color: AppColors.cream, shadowOffset: 3),
                  alignment: Alignment.center,
                  child: const Text(
                    'RA',
                    style: TextStyle(
                      fontFamily: 'Space Grotesk',
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                // [DIUBAH] Mengelompokkan teks profil pengguna di bawah satu const Column untuk efisiensi
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rani Ardana',
                      style: TextStyle(
                        fontFamily: 'Space Grotesk',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Bergabung sejak Juni 2025',
                      style: TextStyle(fontSize: 11, color: AppColors.text2),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Catatan & Motivasi Pribadi
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'CATATAN MOTIVASI HARI INI',
                style: TextStyle(
                  fontFamily: 'Space Grotesk',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // [DIUBAH] Menggunakan Material & InkWell untuk tombol 'Ubah Catatan / Simpan' 
              // agar memiliki M3 ripple feedback saat disentuh.
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(4),
                  onTap: () {
                    setState(() {
                      if (isEditingNote) {
                        personalNote = _noteController.text;
                      }
                      isEditingNote = !isEditingNote;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(
                      isEditingNote ? 'Simpan' : 'Ubah catatan',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          Container(
            decoration: NeoBoxDecoration(color: AppColors.mint, shadowOffset: 3),
            padding: const EdgeInsets.all(16),
            child: isEditingNote
                ? TextField(
                    controller: _noteController,
                    maxLines: 3,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: AppColors.ink,
                    ),
                    // [DIUBAH] Penyesuaian dekorasi TextField agar konsisten dengan M3 Input Field
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.ink, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.ink, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.ink, width: 2.5),
                      ),
                      filled: true,
                      fillColor: AppColors.white,
                      contentPadding: EdgeInsets.all(12),
                    ),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.format_quote, size: 24, color: AppColors.ink),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          personalNote,
                          style: const TextStyle(
                            fontFamily: 'Space Grotesk',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 24),

          // Settings Section
          const Text(
            'PERJALANAN',
            style: TextStyle(
              fontFamily: 'Space Grotesk',
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 11),
          Container(
            decoration: NeoBoxDecoration(color: AppColors.white, shadowOffset: 3),
            // [DIUBAH] Membungkus ListTile dengan Material agar efek riak M3 muncul sempurna di atas kartu putih
            child: Material(
              color: Colors.transparent,
              child: ListTile(
                leading: const Icon(Icons.settings, color: AppColors.ink),
                title: const Text(
                  'Edit perjalanan',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                subtitle: const Text(
                  'Ubah tanggal dan kebiasaan awal',
                  style: TextStyle(fontSize: 10, color: AppColors.text2),
                ),
                trailing: const Icon(Icons.arrow_forward, color: AppColors.ink),
                onTap: widget.editJourney,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Preferences Section
          const Text(
            'PREFERENSI',
            style: TextStyle(
              fontFamily: 'Space Grotesk',
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 11),
          Container(
            decoration: NeoBoxDecoration(color: AppColors.white, shadowOffset: 3),
            child: Material(
              color: Colors.transparent,
              child: SwitchListTile(
                value: notif,
                // [DIUBAH] Menyesuaikan warna track & thumb Switch agar sesuai warna M3
                // activeColor: AppColors.ink,
                activeTrackColor: AppColors.green,
                inactiveThumbColor: AppColors.ink,
                inactiveTrackColor: AppColors.cream,
                title: const Text(
                  'Notifikasi harian',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                subtitle: const Text(
                  'Pengingat suportif pukul 08.00',
                  style: TextStyle(fontSize: 10, color: AppColors.text2),
                ),
                onChanged: (val) => setState(() => notif = val),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Data & Informasi Section
          const Text(
            'DATA & INFORMASI',
            style: TextStyle(
              fontFamily: 'Space Grotesk',
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 11),
          Container(
            decoration: NeoBoxDecoration(color: AppColors.white, shadowOffset: 3),
            child: Material(
              color: Colors.transparent,
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.cream,
                    border: Border.all(color: AppColors.ink, width: 1.5),
                  ),
                  child: const Icon(Icons.info_outline, size: 20, color: AppColors.ink),
                ),
                title: const Text(
                  'Tentang QuitNow',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                subtitle: const Text(
                  'Privasi, bantuan, dan versi 1.0',
                  style: TextStyle(fontSize: 10, color: AppColors.text2),
                ),
                trailing: const Icon(Icons.arrow_forward, color: AppColors.ink),
                onTap: widget.openAbout,
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Tombol Hapus Data
          Center(
            child: TextButton(
              onPressed: () => widget.confirm("delete"),
              style: TextButton.styleFrom(
                splashFactory: InkSparkle.splashFactory, // Standard M3 Ripple Effect
              ),
              child: const Text(
                'Hapus seluruh data',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          const Center(
            child: Text(
              "QUITNOW · MENDUKUNG SDG 3",
              style: TextStyle(
                fontFamily: 'Space Grotesk',
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: AppColors.text2,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}