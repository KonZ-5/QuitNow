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
  String personalNote =
      "Hari ini aku pasti bisa melewati rintangan tanpa rokok!";
  bool isEditingNote = false;
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: personalNote);
  }

  @override
  void dispose() {
    // MINGGU 6: Membersihkan controller agar tidak terjadi memory leak.
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // MINGGU 4: Menggunakan skema warna dan tipografi Material 3.
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      // MINGGU 6: ListView digunakan sebagai layout utama
      // agar seluruh konten profil dapat di-scroll.
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
      children: [
        Text(
          'AKUN & PREFERENSI',
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
          'Profil',
          style: textTheme.headlineMedium?.copyWith(
            fontFamily: 'Space Grotesk',
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: -1,
            color: colorScheme.onSurface,
          ),
        ),

        const SizedBox(height: 24),

        // USER CARD
        Container(
          decoration: NeoBoxDecoration(
            color: AppColors.yellow,
            shadowOffset: 4,
          ),
          padding: const EdgeInsets.all(17),
          child: Row(
            // MINGGU 6: Row menyusun avatar dan informasi pengguna
            // secara horizontal.
            children: [
              Stack(
                // MINGGU 6: Stack menumpuk dekorasi kecil di atas avatar.
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 62,
                    height: 62,
                    decoration: NeoBoxDecoration(
                      color: AppColors.cream,
                      shadowOffset: 3,
                    ),
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

                  // Dekorasi avatar tidak mengganggu interaksi.
                  const Positioned(
                    right: 2,
                    bottom: 2,
                    child: IgnorePointer(
                      child: Icon(
                        Icons.star,
                        size: 13,
                        color: AppColors.green,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 15),

              // MINGGU 6: Expanded memberikan sisa ruang
              // untuk informasi nama dan tanggal bergabung.
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rani Ardana',
                      style: textTheme.titleMedium?.copyWith(
                        fontFamily: 'Space Grotesk',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Bergabung sejak Juni 2025',
                      style: textTheme.bodySmall?.copyWith(
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

        const SizedBox(height: 24),

        // CATATAN MOTIVASI
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Expanded mencegah judul bertabrakan dengan tombol ubah.
            Expanded(
              child: Text(
                'CATATAN MOTIVASI HARI INI',
                style: textTheme.titleSmall?.copyWith(
                  fontFamily: 'Space Grotesk',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ),

            // MINGGU 4: Material dan InkWell memberikan efek ripple.
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
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
          decoration: NeoBoxDecoration(
            color: AppColors.mint,
            shadowOffset: 3,
          ),
          padding: const EdgeInsets.all(16),
          child: isEditingNote
              ? TextField(
                  controller: _noteController,
                  maxLines: 3,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppColors.ink,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.ink,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.ink,
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.ink,
                        width: 2.5,
                      ),
                    ),
                    filled: true,
                    fillColor: AppColors.white,
                    contentPadding: EdgeInsets.all(12),
                  ),
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.format_quote,
                      size: 24,
                      color: AppColors.ink,
                    ),
                    const SizedBox(width: 10),

                    // Expanded membuat teks motivasi menggunakan
                    // ruang yang tersedia dan dapat membungkus baris.
                    Expanded(
                      child: Text(
                        personalNote,
                        style: textTheme.bodyMedium?.copyWith(
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

        // BAGIAN PERJALANAN
        Text(
          'PERJALANAN',
          style: textTheme.titleSmall?.copyWith(
            fontFamily: 'Space Grotesk',
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),

        const SizedBox(height: 11),

        Container(
          decoration: NeoBoxDecoration(
            color: AppColors.white,
            shadowOffset: 3,
          ),
          child: Material(
            color: Colors.transparent,
            child: ListTile(
              leading: const Icon(
                Icons.settings,
                color: AppColors.ink,
              ),
              title: const Text(
                'Edit perjalanan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              subtitle: const Text(
                'Ubah tanggal dan kebiasaan awal',
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.text2,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward,
                color: AppColors.ink,
              ),
              onTap: widget.editJourney,
            ),
          ),
        ),

        const SizedBox(height: 24),

        // BAGIAN PREFERENSI
        Text(
          'PREFERENSI',
          style: textTheme.titleSmall?.copyWith(
            fontFamily: 'Space Grotesk',
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),

        const SizedBox(height: 11),

        Container(
          decoration: NeoBoxDecoration(
            color: AppColors.white,
            shadowOffset: 3,
          ),
          child: Material(
            color: Colors.transparent,
            child: SwitchListTile(
              value: notif,

              // MINGGU 4: Warna switch disesuaikan dengan tema aplikasi.
              activeTrackColor: AppColors.green,
              inactiveThumbColor: AppColors.ink,
              inactiveTrackColor: AppColors.cream,

              title: const Text(
                'Notifikasi harian',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              subtitle: const Text(
                'Pengingat suportif pukul 08.00',
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.text2,
                ),
              ),
              onChanged: (val) {
                setState(() {
                  notif = val;
                });
              },
            ),
          ),
        ),

        const SizedBox(height: 24),

        // BAGIAN DATA & INFORMASI
        Text(
          'DATA & INFORMASI',
          style: textTheme.titleSmall?.copyWith(
            fontFamily: 'Space Grotesk',
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),

        const SizedBox(height: 11),

        Container(
          decoration: NeoBoxDecoration(
            color: AppColors.white,
            shadowOffset: 3,
          ),
          child: Material(
            color: Colors.transparent,
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.cream,
                  border: Border.all(
                    color: AppColors.ink,
                    width: 1.5,
                  ),
                ),
                child: const Icon(
                  Icons.info_outline,
                  size: 20,
                  color: AppColors.ink,
                ),
              ),
              title: const Text(
                'Tentang QuitNow',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              subtitle: const Text(
                'Privasi, bantuan, dan versi 1.0',
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.text2,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward,
                color: AppColors.ink,
              ),
              onTap: widget.openAbout,
            ),
          ),
        ),

        const SizedBox(height: 32),

        // TOMBOL HAPUS DATA
        Center(
          child: TextButton(
            onPressed: () => widget.confirm("delete"),
            style: TextButton.styleFrom(
              splashFactory: InkSparkle.splashFactory,
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

        // FOOTER
        Center(
          child: Text(
            "QUITNOW · MENDUKUNG SDG 3",
            style: textTheme.labelSmall?.copyWith(
              fontFamily: 'Space Grotesk',
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: AppColors.text2,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ],
    );
  }
}