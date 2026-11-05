import 'package:flutter/material.dart';
import '../theme.dart';
import '../utils/responsive.dart';
import '../widgets/adaptive_layout.dart';
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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final r = Responsive.of(context);
    final double pad = r.pagePadding + (r.isUltraNarrow ? 2 : 4);

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        // MINGGU 6: ListView sebagai scroll utama halaman input form.
        child: ListView(
          padding: EdgeInsets.all(pad),
          children: [
            CenteredContent(
              maxWidth: Responsive.maxContentWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(r, textTheme, colorScheme),
                  SizedBox(height: r.isLandscape ? 20 : 36),

                  // MINGGU 7: AdaptiveColumns menyesuaikan tata letak form:
                  // - Portrait: 1 Kolom vertikal (intro di atas, form di bawah).
                  // - Landscape / Layar Lebar: 2 Kolom (intro di kiri, form di kanan).
                  AdaptiveColumns(
                    breakpoint: 600,
                    gap: 32,
                    primaryFlex: 5,
                    secondaryFlex: 6,
                    primary: [
                      _buildIntro(r, textTheme, colorScheme),
                    ],
                    secondary: [
                      _buildFormCard(r, textTheme),
                      const SizedBox(height: 20),
                      _buildPrivacyNote(textTheme),
                      const SizedBox(height: 24),
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
          ],
        ),
      ),
    );
  }

  // HEADER BRAND
  Widget _buildHeader(
      Responsive r, TextTheme textTheme, ColorScheme colorScheme) {
    return AdaptiveRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // MINGGU 7: Flexible menyusutkan area judul kiri agar label status di kanan tidak terdorong keluar.
        Flexible(
          child: widget.onBack != null
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: widget.onBack,
                    child: Container(
                      width: r.isUltraNarrow ? 38 : 44,
                      height: r.isUltraNarrow ? 38 : 44,
                      decoration: NeoBoxDecoration(
                        color: AppColors.white,
                        shadowOffset: 3,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        border: Border.all(color: AppColors.ink, width: 1.5),
                      ),
                      child: const Icon(
                        Icons.eco,
                        size: 20,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(width: 7),
                    Flexible(
                      child: Text(
                        "QuitNow",
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleLarge?.copyWith(
                          fontFamily: 'Space Grotesk',
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.yellow,
            border: Border.all(color: AppColors.ink, width: 1.5),
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
    );
  }

  // INTRO TEKS
  Widget _buildIntro(
      Responsive r, TextTheme textTheme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          widget.compact ? "Edit perjalananmu" : "Ceritakan kebiasaanmu",
          style: textTheme.headlineMedium?.copyWith(
            fontFamily: 'Space Grotesk',
            fontSize:
                r.pick(ultraNarrow: 22.0, compact: 32.0, medium: 34.0, expanded: 38.0),
            fontWeight: FontWeight.bold,
            letterSpacing: -1.3,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          "Data ini membantu kami membuat estimasi progres yang lebih relevan untukmu.",
          style: textTheme.bodyLarge?.copyWith(
            color: AppColors.text2,
            fontSize: r.isUltraNarrow ? 12 : 15,
            height: 1.55,
          ),
        ),
      ],
    );
  }

  // KARTU FORMULIR
  Widget _buildFormCard(Responsive r, TextTheme textTheme) {
    // MINGGU 5: Container & Padding pembungkus form.
    return Container(
      width: double.infinity,
      decoration: NeoBoxDecoration(
        color: AppColors.white,
        shadowOffset: 5,
      ),
      padding: EdgeInsets.all(r.isUltraNarrow ? 12 : 21),
      // MINGGU 6: Stack & Positioned menempatkan dekorasi bintang di atas sudut kartu.
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

              // MINGGU 7: LayoutBuilder membaca batasan lebar KARTU form.
              // - Lebar >= 260dp: Input harga & isi per bungkus disusun 2 kolom (Row + Expanded).
              // - Lebar < 260dp: Input disusun 1 kolom vertikal ke bawah agar tidak sempit.
              LayoutBuilder(
                builder: (context, constraints) {
                  final priceField = _buildField(
                    "Harga per bungkus",
                    _priceController,
                    TextInputType.number,
                  );
                  final packField = _buildField(
                    "Batang per bungkus",
                    _packController,
                    TextInputType.number,
                  );

                  if (r.isStacked || constraints.maxWidth < 260) {
                    return Column(
                      children: [
                        priceField,
                        const SizedBox(height: 18),
                        packField,
                      ],
                    );
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: priceField),
                      const SizedBox(width: 12),
                      Expanded(child: packField),
                    ],
                  );
                },
              ),

              if (error.isNotEmpty) ...[
                const SizedBox(height: 18),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.lightRed,
                    border: Border.all(color: AppColors.ink, width: 1.5),
                  ),
                  child: AdaptiveRow(
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
          const Positioned(
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
    );
  }

  // INFORMASI PRIVASI
  Widget _buildPrivacyNote(TextTheme textTheme) {
    return AdaptiveRow(
      children: [
        const Icon(
          Icons.shield_outlined,
          size: 19,
          color: AppColors.text2,
        ),
        const SizedBox(width: 9),
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
    );
  }

  // WIDGET FIELD INPUT TEKS
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
        // MINGGU 3 & MINGGU 4: TextField dengan dekorasi input Material 3.
        TextField(
          controller: controller,
          keyboardType: type,
          style: const TextStyle(fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.cream,
            hintText: hint,
            hintMaxLines: 2, // MINGGU 7: Teks petunjuk panjang diperbolehkan 2 baris saat layar sempit.
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.ink, width: 1.5),
              borderRadius: BorderRadius.circular(0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.ink, width: 2),
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        ),
      ],
    );
  }
}