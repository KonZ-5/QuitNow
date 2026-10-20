import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/neo_button.dart';

class SetupScreen extends StatefulWidget {
  final VoidCallback onComplete;
  final VoidCallback? onBack;
  final bool compact;

  // PERBAIKAN: Mengubah konstruktor lama menggunakan super.key yang lebih ringkas
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

    if (_dateController.text.isEmpty || daily < 1 || price < 1000 || pack < 1) {
      setState(() => error = "Periksa kembali data yang belum lengkap.");
      return;
    }
    setState(() => error = "");
    widget.onComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      ? GestureDetector(
                          onTap: widget.onBack,
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: NeoBoxDecoration(color: AppColors.white, shadowOffset: 3),
                            child: const Icon(Icons.arrow_back, color: AppColors.ink),
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
                            const Text("QuitNow", style: TextStyle(fontFamily: 'Space Grotesk', fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.yellow,
                      border: Border.all(color: AppColors.ink, width: 1.5),
                    ),
                    child: Text(
                      widget.compact ? "PENGATURAN" : "LANGKAH 1/1",
                      style: const TextStyle(fontFamily: 'Space Grotesk', fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36),

              // Intro
              const Text("MULAI DI SINI", style: TextStyle(fontFamily: 'Space Grotesk', fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 1.1)),
              const SizedBox(height: 7),
              Text(
                widget.compact ? "Edit perjalananmu" : "Ceritakan kebiasaanmu",
                style: const TextStyle(fontFamily: 'Space Grotesk', fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: -1.3),
              ),
              const SizedBox(height: 14),
              const Text(
                "Data ini membantu kami membuat estimasi progres yang lebih relevan untukmu.",
                style: TextStyle(color: AppColors.text2, fontSize: 15, height: 1.55),
              ),
              const SizedBox(height: 24),

              // Form Card
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
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.lightRed,
                          border: Border.all(color: AppColors.ink, width: 1.5),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.info_outline, size: 18, color: AppColors.ink),
                            const SizedBox(width: 7),
                            Expanded(child: Text(error, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                          ],
                        ),
                      ),
                    ]
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: const [
                  Icon(Icons.shield_outlined, size: 19, color: AppColors.text2),
                  SizedBox(width: 9),
                  Text("Datamu disimpan hanya di perangkat ini.", style: TextStyle(fontSize: 12, color: AppColors.text2)),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontFamily: 'Space Grotesk', fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 7),
        TextField(
          controller: controller,
          keyboardType: type,
          style: const TextStyle(fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.cream,
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
