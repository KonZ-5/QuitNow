
import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/neo_button.dart';

class SetupScreen extends StatefulWidget {
  final VoidCallback onComplete;
  final VoidCallback? onBack;
  final bool compact;

  const SetupScreen({
    super.key,
    required this.onComplete,
    this.onBack,
    this.compact = false,
  });

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final _dateController = TextEditingController(text: "2025-06-16");
  final _dailyController = TextEditingController(text: "15");
  final _priceController = TextEditingController(text: "25000");
  final _packController = TextEditingController(text: "20");

  String error = "";

  // PERUBAHAN 1:
  // Menambahkan dispose untuk membersihkan TextEditingController
  // ketika halaman tidak lagi digunakan.
  @override
  void dispose() {
    _dateController.dispose();
    _dailyController.dispose();
    _priceController.dispose();
    _packController.dispose();
    super.dispose();
  }

  // Validasi data tetap menggunakan logika asli.
  void _submit() {
    final daily = int.tryParse(_dailyController.text) ?? 0;
    final price = int.tryParse(_priceController.text) ?? 0;
    final pack = int.tryParse(_packController.text) ?? 0;

    if (_dateController.text.isEmpty ||
        daily < 1 ||
        price < 1000 ||
        pack < 1) {
      setState(() => error = "Periksa kembali data yang belum lengkap.");
      return;
    }

    setState(() => error = "");
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    // PERUBAHAN 2:
    // Menggunakan ColorScheme dan TextTheme Material 3
    // sebagai acuan warna dan tipografi.
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // Warna latar QuitNow tetap dipertahankan.
      backgroundColor: AppColors.cream,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Brand
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.onBack != null
                      // PERUBAHAN 3:
                      // GestureDetector diganti IconButton agar
                      // interaksi mengikuti pola kontrol Material.
                      ? Container(
                          width: 44,
                          height: 44,
                          decoration: NeoBoxDecoration(
                            color: AppColors.white,
                            shadowOffset: 3,
                          ),
                          child: IconButton(
                            onPressed: widget.onBack,
                            tooltip: 'Kembali',
                            padding: EdgeInsets.zero,
                            icon: Icon(
                              Icons.arrow_back,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        )
                      : Row(
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

                            // PERUBAHAN 4:
                            // Nama aplikasi menggunakan titleLarge.
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

                  // Label langkah tetap memakai gaya visual QuitNow.
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.yellow,
                      border: Border.all(
                        color: AppColors.ink,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      widget.compact ? "PENGATURAN" : "LANGKAH 1/1",
                      style: textTheme.labelSmall?.copyWith(
                        fontFamily: 'Space Grotesk',
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        letterSpacing: 0.7,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 36),

              // Intro

              // PERUBAHAN 5:
              // Label pengantar menggunakan labelSmall Material 3.
              Text(
                "MULAI DI SINI",
                style: textTheme.labelSmall?.copyWith(
                  fontFamily: 'Space Grotesk',
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  letterSpacing: 1.1,
                  color: colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 7),

              // PERUBAHAN 6:
              // Judul menggunakan headlineMedium.
              // Ukuran dan karakter font tetap dipertahankan.
              Text(
                widget.compact
                    ? "Edit perjalananmu"
                    : "Ceritakan kebiasaanmu",
                style: textTheme.headlineMedium?.copyWith(
                  fontFamily: 'Space Grotesk',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.3,
                  color: colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 14),

              // PERUBAHAN 7:
              // Deskripsi menggunakan bodyLarge.
              const Text(
                "Data ini membantu kami membuat estimasi progres yang lebih relevan untukmu.",
                style: TextStyle(
                  color: AppColors.text2,
                  fontSize: 15,
                  height: 1.55,
                ),
              ),

              const SizedBox(height: 24),

              // Form Card
              // PERUBAHAN 8:
              // NeoBoxDecoration tetap digunakan agar
              // identitas visual proyek tidak berubah.
              Container(
                decoration: NeoBoxDecoration(
                  color: AppColors.white,
                  shadowOffset: 5,
                ),
                padding: const EdgeInsets.all(21),
                child: Column(
                  children: [
                    _buildField(
                      "Tanggal mulai berhenti",
                      _dateController,
                      TextInputType.datetime,
                    ),

                    const SizedBox(height: 18),

                    _buildField(
                      "Rokok per hari",
                      _dailyController,
                      TextInputType.number,
                      hint: "Rata-rata sebelum berhenti",
                    ),

                    const SizedBox(height: 18),

                    // PERUBAHAN 9:
                    // Field harga dan jumlah batang tetap dalam Row.
                    // Expanded dipertahankan agar lebarnya seimbang.
                    Row(
                      children: [
                        Expanded(
                          child: _buildField(
                            "Harga per bungkus",
                            _priceController,
                            TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildField(
                            "Batang per bungkus",
                            _packController,
                            TextInputType.number,
                          ),
                        ),
                      ],
                    ),

                    // Pesan validasi tetap menggunakan desain awal.
                    if (error.isNotEmpty) ...[
                      const SizedBox(height: 18),

                      // PERUBAHAN 10:
                      // Pesan error diberi role alert melalui
                      // Semantics agar lebih mudah dikenali pembaca layar.
                      Semantics(
                        liveRegion: true,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.lightRed,
                            border: Border.all(
                              color: AppColors.ink,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.info_outline,
                                size: 18,
                                color: AppColors.ink,
                              ),
                              const SizedBox(width: 7),
                              Expanded(
                                child: Text(
                                  error,
                                  style: textTheme.bodySmall?.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.onSurface,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Informasi privasi tetap dipertahankan.
              Row(
                children: [
                  const Icon(
                    Icons.shield_outlined,
                    size: 19,
                    color: AppColors.text2,
                  ),
                  const SizedBox(width: 9),

                  // PERUBAHAN 11:
                  // Flexible mencegah teks terlalu panjang
                  // menyebabkan overflow pada layar kecil.
                  Flexible(
                    child: Text(
                      "Datamu disimpan hanya di perangkat ini.",
                      style: textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        color: AppColors.text2,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // PERUBAHAN 12:
              // NeoButton dan fungsi _submit tetap dipertahankan.
              NeoButton(
                text: widget.compact
                    ? "Simpan perubahan"
                    : "Mulai Perjalanan",
                icon: const Icon(
                  Icons.arrow_forward,
                  color: AppColors.ink,
                ),
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // PERUBAHAN 13:
  // TextField tetap menggunakan struktur awal.
  // Penyesuaian berfokus pada tipografi, warna, dan status fokus
  // agar konsisten dengan sistem visual aplikasi.
  Widget _buildField(
    String label,
    TextEditingController controller,
    TextInputType type, {
    String? hint,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.titleSmall?.copyWith(
            fontFamily: 'Space Grotesk',
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: colorScheme.onSurface,
          ),
        ),

        const SizedBox(height: 7),

        TextField(
          controller: controller,
          keyboardType: type,

          style: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),

          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.cream,
            hintText: hint,

            // PERUBAHAN 14:
            // Mengatur gaya hint dan padding melalui InputDecoration.
            hintStyle: textTheme.bodySmall?.copyWith(
              color: AppColors.text2,
            ),

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),

            // Border normal tetap tegas sesuai desain QuitNow.
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.ink,
                width: 1.5,
              ),
              borderRadius: BorderRadius.zero,
            ),

            // PERUBAHAN 15:
            // Border fokus dibuat lebih tebal untuk menunjukkan
            // field yang sedang aktif.
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorScheme.primary,
                width: 2.5,
              ),
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
      ],
    );
  }
}
