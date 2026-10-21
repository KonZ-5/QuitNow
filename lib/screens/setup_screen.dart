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

  @override
  void dispose() {
    _dateController.dispose();
    _dailyController.dispose();
    _priceController.dispose();
    _packController.dispose();
    super.dispose();
  }

  void _submit() {
    final daily = int.tryParse(_dailyController.text) ?? 0;
    final price = int.tryParse(_priceController.text) ?? 0;
    final pack = int.tryParse(_packController.text) ?? 0;

    if (_dateController.text.isEmpty || daily < 1 || price < 1000 || pack < 1) {
      setState(() => error = "Periksa kembali data yang belum lengkap.");
      return;
    }

    setState(() => error = "");
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    // MINGGU 4: Penggunaan ColorScheme & TextTheme Material 3 sebagai acuan utama.
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: SingleChildScrollView(
          // MINGGU 5: Padding luar membungkus seluruh elemen form.
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.onBack != null
                      ? Container(
                          width: 44,
                          height: 44,
                          decoration: NeoBoxDecoration(
                            color: AppColors.white,
                            shadowOffset: 3,
                          ),
                          // MINGGU 4: IconButton menggantikan GestureDetector standar.
                          child: IconButton(
                            onPressed: widget.onBack,
                            tooltip: 'Kembali',
                            padding: EdgeInsets.zero,
                            icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
                          ),
                        )
                      : Row(
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
                            Text(
                              "QuitNow",
                              // MINGGU 4: Nama aplikasi memakai titleLarge.
                              style: textTheme.titleLarge?.copyWith(
                                fontFamily: 'Space Grotesk',
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                  Container(
                    // MINGGU 5: Padding simetris untuk label status langkah.
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.yellow,
                      border: Border.all(color: AppColors.ink, width: 1.5),
                    ),
                    child: Text(
                      widget.compact ? "PENGATURAN" : "LANGKAH 1/1",
                      // MINGGU 4: Label langkah memakai labelSmall.
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
              Text(
                "MULAI DI SINI",
                // MINGGU 4: Label pengantar menggunakan labelSmall Material 3.
                style: textTheme.labelSmall?.copyWith(
                  fontFamily: 'Space Grotesk',
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                  letterSpacing: 1.1,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                widget.compact ? "Edit perjalananmu" : "Ceritakan kebiasaanmu",
                // MINGGU 4: Judul utama form memakai headlineMedium.
                style: textTheme.headlineMedium?.copyWith(
                  fontFamily: 'Space Grotesk',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.3,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                "Data ini membantu kami membuat estimasi progres yang lebih relevan untukmu.",
                style: TextStyle(color: AppColors.text2, fontSize: 15, height: 1.55),
              ),
              const SizedBox(height: 24),

              // Form Card Container
              Container(
                decoration: NeoBoxDecoration(color: AppColors.white, shadowOffset: 5),
                padding: const EdgeInsets.all(21),
                child: Column(
                  children: [
                    _buildField("Tanggal mulai berhenti", _dateController, TextInputType.datetime),
                    const SizedBox(height: 18),
                    _buildField("Rokok per hari", _dailyController, TextInputType.number, hint: "Rata-rata sebelum berhenti"),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(child: _buildField("Harga per bungkus", _priceController, TextInputType.number)),
                        const SizedBox(width: 12),
                        Expanded(child: _buildField("Batang per bungkus", _packController, TextInputType.number)),
                      ],
                    ),
                    if (error.isNotEmpty) ...[
                      const SizedBox(height: 18),
                      // MINGGU 4: Semantics untuk memberikan peran alert pada pesan error.
                      Semantics(
                        liveRegion: true,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.lightRed,
                            border: Border.all(color: AppColors.ink, width: 1.5),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.info_outline, size: 18, color: AppColors.ink),
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
              Row(
                children: [
                  const Icon(Icons.shield_outlined, size: 19, color: AppColors.text2),
                  const SizedBox(width: 9),
                  Flexible(
                    child: Text(
                      "Datamu disimpan hanya di perangkat ini.",
                      style: textTheme.bodySmall?.copyWith(fontSize: 12, color: AppColors.text2),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              NeoButton(
                text: widget.compact ? "Simpan perubahan" : "Mulai Perjalanan",
                icon: const Icon(Icons.arrow_forward, color: AppColors.ink),
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, TextInputType type, {String? hint}) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          // MINGGU 4: Label input mengacu pada titleSmall.
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
            // MINGGU 4: Hint style terhubung dengan bodySmall TextTheme.
            hintStyle: textTheme.bodySmall?.copyWith(color: AppColors.text2),
            // MINGGU 5: Padding dalam untuk mengatur posisi input teks.
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.ink, width: 1.5),
              borderRadius: BorderRadius.zero,
            ),
            // MINGGU 4: Visual indikator fokus menggunakan warna primary dari ColorScheme.
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorScheme.primary, width: 2.5),
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
      ],
    );
  }
}