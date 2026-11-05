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
    // MINGGU 4: Penggunaan Skema Warna & Tipografi Material 3.
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // MINGGU 6 [POIN 1]: SingleChildScrollView membungkus Column (multi-child widget)
    // sehingga seluruh tab bisa di-scroll dan banyak section tersusun vertikal.
    return SingleChildScrollView(
      // MINGGU 5: Single-child layout Padding membungkus seluruh tab profil.
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AKUN & PREFERENSI',
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
            'Profil',
            // MINGGU 4: Judul halaman menggunakan headlineMedium Material 3.
            style: textTheme.headlineMedium?.copyWith(
              fontFamily: 'Space Grotesk',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 24),

          // User Card
          Container(
            decoration: NeoBoxDecoration(color: AppColors.yellow, shadowOffset: 4),
            padding: const EdgeInsets.all(17),
            // MINGGU 6 [POIN 2]: Row menyejajarkan avatar (kiri) dan nama (kanan).
            child: Row(
              children: [
                Container(
                  // MINGGU 5: Container dengan dimensi tetap untuk avatar pengguna.
                  width: 62,
                  height: 62,
                  decoration: NeoBoxDecoration(color: AppColors.cream, shadowOffset: 3),
                  alignment: Alignment.center,
                  // MINGGU 6 [BARU - POIN 4]: Stack sebagai wadah inisial avatar.
                  // alignment center membuat posisi teks "RA" IDENTIK dengan sebelumnya.
                  // Stack siap menampung lapisan tambahan (mis. badge/status) tanpa mengubah layout.
                  child: Stack(
                    alignment: Alignment.center,
                    children: const [
                      Text(
                        'RA',
                        style: TextStyle(
                          fontFamily: 'Space Grotesk',
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                // MINGGU 6 [POIN 3]: Expanded membuat kolom nama mengambil seluruh
                // sisa lebar di samping avatar.
                Expanded(
                  // MINGGU 6 [POIN 2]: Column menumpuk nama dan tanggal bergabung ke bawah.
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rani Ardana',
                        // MINGGU 4: Nama profil menggunakan titleMedium.
                        style: textTheme.titleMedium?.copyWith(
                          fontFamily: 'Space Grotesk',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Bergabung sejak Juni 2025',
                        style: textTheme.bodySmall?.copyWith(fontSize: 11, color: AppColors.text2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Catatan & Motivasi Pribadi
          // MINGGU 6 [POIN 2]: Row menyejajarkan judul section (kiri) dan tombol "Ubah catatan" (kanan).
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // MINGGU 6 [BARU - POIN 3]: Judul dibungkus Expanded agar mengambil sisa ruang
              // di samping tombol "Ubah catatan". Tampilan tidak berubah, hanya mencegah
              // overflow di layar sempit (teks otomatis wrap ke baris baru).
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
              // MINGGU 4: Material & InkWell untuk tombol aksi catatan dengan M3 ripple feedback.
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
                    style: textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: AppColors.ink,
                    ),
                    // MINGGU 4: Penyesuaian dekorasi TextField M3 Input Field.
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
                // MINGGU 6 [POIN 2]: Row menyejajarkan ikon kutip (kiri) dan teks catatan (kanan).
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.format_quote, size: 24, color: AppColors.ink),
                      const SizedBox(width: 10),
                      // MINGGU 6 [POIN 3]: Expanded agar teks catatan mengisi sisa lebar
                      // dan otomatis wrap ke baris baru.
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

          // Settings Section
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
            decoration: NeoBoxDecoration(color: AppColors.white, shadowOffset: 3),
            // MINGGU 4: Material wrapper agar efek riak M3 ListTile muncul sempurna di atas kartu putih.
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
            decoration: NeoBoxDecoration(color: AppColors.white, shadowOffset: 3),
            child: Material(
              color: Colors.transparent,
              child: SwitchListTile(
                value: notif,
                // MINGGU 4: Penyesuaian warna track & thumb Switch sesuai standar M3.
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
            // MINGGU 6 [DIUBAH]: TextButton bergaris bawah diganti kotak merah bergaya neo
            // (border ink + bayangan, sama seperti kartu lain di halaman ini) dengan ikon tempat sampah.
            child: Container(
              decoration: NeoBoxDecoration(color: Colors.red, shadowOffset: 3),
              // MINGGU 4: Material + InkWell agar tetap ada ripple M3 di atas kotak merah.
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => widget.confirm("delete"), // fungsi hapus TIDAK berubah
                  splashFactory: InkSparkle.splashFactory, // MINGGU 4: Ripple M3 Standard
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    // MINGGU 6 [POIN 2]: Row menyejajarkan ikon tempat sampah (kiri) dan teks (kanan).
                    // mainAxisSize.min supaya kotak hanya selebar isinya dan tetap di tengah halaman.
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // MINGGU 6 [BARU]: Ikon tempat sampah putih agar kontras di atas warna merah.
                        Icon(Icons.delete_outline, size: 20, color: AppColors.white),
                        SizedBox(width: 8),
                        // MINGGU 6 [DIUBAH]: garis bawah dihapus, teks jadi putih.
                        Text(
                          'Hapus seluruh data',
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

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
      ),
    );
  }
}