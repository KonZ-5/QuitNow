
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

  // MATERI 6: dispose digunakan untuk membersihkan seluruh controller.
  @override
  void dispose() {
    _dateController.dispose();
    _dailyController.dispose();
    _priceController.dispose();
    _packController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // MINGGU 4: Mengakses tema Material 3.
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(

        // MATERI 6: ListView digunakan sebagai scroll utama halaman.
        // Menggantikan SingleChildScrollView.
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [

            // MATERI 6: Column menyusun konten secara vertikal.
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // HEADER BRAND
                // MATERI 6: Row menyusun header secara horizontal.
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.onBack != null
                        ? GestureDetector(
                            onTap: widget.onBack,
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: NeoBoxDecoration(
                                color: AppColors.white,
                                shadowOffset: 3,
                              ),
                              child: Icon(
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
                          letterSpacing: 0.7,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 36),

                // INTRO
                Text(
                  "MULAI DI SINI",
                  style: textTheme.labelSmall?.copyWith(
                    fontFamily: 'Space Grotesk',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.1,
                    color: colorScheme.onSurface,
                  ),
                ),

                const SizedBox(height: 7),

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

                Text(
                  "Data ini membantu kami membuat estimasi progres "
                  "yang lebih relevan untukmu.",
                  style: textTheme.bodyLarge?.copyWith(
                    color: AppColors.text2,
                    fontSize: 15,
                    height: 1.55,
                  ),
                ),

                const SizedBox(height: 24),

                // FORM CARD
                Container(
                  decoration: NeoBoxDecoration(
                    color: AppColors.white,
                    shadowOffset: 5,
                  ),
                  padding: const EdgeInsets.all(21),

                  // MATERI 6: Stack memungkinkan ikon dekorasi
                  // ditumpuk di atas area kartu form.
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
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

                          // MATERI 6: Row membagi input menjadi
                          // dua kolom secara horizontal.
                          Row(
                            children: [
                              // Expanded membagi ruang secara proporsional.
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

                          // Pesan validasi tetap dipertahankan.
                          if (error.isNotEmpty) ...[
                            const SizedBox(height: 18),

                            Container(
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
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),

                      // MATERI 6: Positioned menempatkan dekorasi
                      // pada sudut kanan atas kartu form.
                      Positioned(
                        top: -30,
                        right: -12,
                        child: IgnorePointer(
                          child: Icon(
                            Icons.auto_awesome,
                            size: 22,
                            color: AppColors.yellow,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // PRIVACY INFORMATION
                Row(
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      size: 19,
                      color: AppColors.text2,
                    ),
                    const SizedBox(width: 9),

                    // MATERI 6: Expanded mencegah teks
                    // mengalami overflow pada layar sempit.
                    Expanded(
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

                // TOMBOL SUBMIT
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
          ],
        ),
      ),
    );
  }

  // FIELD INPUT
  Widget _buildField(
    String label,
    TextEditingController controller,
    TextInputType type, {
    String? hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Space Grotesk',
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),

        const SizedBox(height: 7),

        TextField(
          controller: controller,
          keyboardType: type,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.cream,
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.ink,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.ink,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        ),
      ],
    );
  }
}
