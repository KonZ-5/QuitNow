
import 'package:flutter/material.dart';
import '../theme.dart';
import '../utils/responsive.dart';
import '../widgets/adaptive_layout.dart';
import '../widgets/neo_button.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onFinish;

  const OnboardingScreen({super.key, required this.onFinish});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int step = 0;

  // MINGGU 6: PageController untuk mengontrol PageView.
  final PageController _pageController = PageController();

  // MINGGU 3: Struktur data konten onboarding.
  final List<Map<String, Object>> onboardingData = [
    {
      "title": "Mulai Perjalanan Bebas Rokok",
      "text":
          "Buat langkah pertamamu menuju hidup yang lebih sehat, satu hari pada satu waktu.",
      "color": AppColors.green,
      "art": "lungs",
    },
    {
      "title": "Pantau Progres Setiap Hari",
      "text":
          "Lihat waktu, rokok yang dihindari, dan estimasi uang yang berhasil kamu hemat.",
      "color": AppColors.yellow,
      "art": "chart",
    },
    {
      "title": "Rayakan Setiap Pencapaian",
      "text":
          "Setiap hari layak dirayakan. Buka lencana baru dan terus bertumbuh.",
      "color": AppColors.coral,
      "art": "badge",
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // MINGGU 4: Material Design 3.
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final r = Responsive.of(context);

    return Scaffold(
      backgroundColor: colorScheme.surface == Colors.white
          ? AppColors.cream
          : colorScheme.surface,
      body: SafeArea(
        // MINGGU 7: Menyesuaikan layout berdasarkan orientasi.
        child: OrientationBuilder(
          builder: (context, orientation) {
            final bool isLandscape =
                orientation == Orientation.landscape && !r.isStacked;

            return CenteredContent(
              maxWidth: Responsive.maxContentWidth,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: r.pagePadding + (r.isUltraNarrow ? 0 : 4),
                  vertical: isLandscape ? 8 : 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopBar(textTheme, colorScheme),
                    SizedBox(height: isLandscape ? 8 : 20),

                    // MINGGU 6: PageView sebagai carousel onboarding.
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: onboardingData.length,
                        onPageChanged: (index) {
                          setState(() {
                            step = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          final item = onboardingData[index];

                          return isLandscape
                              ? _buildLandscapePage(
                                  item,
                                  index,
                                  r,
                                  textTheme,
                                  colorScheme,
                                )
                              : _buildPortraitPage(
                                  item,
                                  index,
                                  r,
                                  textTheme,
                                  colorScheme,
                                );
                        },
                      ),
                    ),

                    SizedBox(height: isLandscape ? 8 : 16),
                    _buildActions(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // TOP BAR BRAND
  Widget _buildTopBar(
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    // MINGGU 6: AdaptiveRow menyusun elemen secara horizontal.
    return AdaptiveRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // MINGGU 3: Container ikon logo aplikasi.
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

        // MINGGU 4: Tombol Lewati.
        TextButton(
          onPressed: widget.onFinish,
          style: TextButton.styleFrom(
            foregroundColor: colorScheme.onSurface,
          ),
          child: const Text(
            "Lewati",
            style: TextStyle(
              color: AppColors.ink,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  // KOTAK GAMBAR (ART BOX)
  Widget _buildArtBox(
    Map<String, Object> item, {
    double? height,
  }) {
    // MINGGU 5: Container dan Padding dengan bayangan Neo-Brutalist.
    return Container(
      height: height,
      width: double.infinity,
      margin: const EdgeInsets.only(
        right: 7,
        bottom: 7,
      ),
      decoration: NeoBoxDecoration(
        color: item["color"] as Color,
        shadowOffset: 7,
        borderWidth: 3,
      ),

      // MINGGU 6: Stack dan Positioned untuk ikon dekorasi.
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            // MINGGU 7: FittedBox mencegah ikon meluber.
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _buildArt(item["art"] as String),
              ),
            ),
          ),
          Positioned(
            top: 14,
            right: 14,
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(
                  color: AppColors.ink,
                  width: 1.5,
                ),
              ),
              child: const Icon(
                Icons.auto_awesome,
                size: 19,
                color: AppColors.ink,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // BLOK TEKS KONTEN
  Widget _buildTextBlock(
    Map<String, Object> item,
    int index,
    Responsive r,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "0${index + 1} / 03",
          style: textTheme.labelSmall?.copyWith(
            fontFamily: 'Space Grotesk',
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          item["title"] as String,
          style: textTheme.headlineMedium?.copyWith(
            fontFamily: 'Space Grotesk',
            fontSize: r.pick(
              ultraNarrow: 22.0,
              compact: 32.0,
              medium: 34.0,
              expanded: 40.0,
            ),
            fontWeight: FontWeight.bold,
            height: 1.05,
            letterSpacing: -1.0,
            color: colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          item["text"] as String,
          style: textTheme.bodyLarge?.copyWith(
            color: AppColors.text2,
            fontSize: r.isUltraNarrow ? 12 : 15,
            height: 1.55,
          ),
        ),
      ],
    );
  }

  // PORTRAIT: Layout vertikal standar.
  Widget _buildPortraitPage(
    Map<String, Object> item,
    int index,
    Responsive r,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    // MINGGU 7: Tinggi gambar proporsional terhadap layar.
    final double artHeight =
        (r.height * 0.32).clamp(130.0, 300.0).toDouble();

    // MINGGU 6: ScrollView menghindari overflow vertikal.
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildArtBox(
            item,
            height: artHeight,
          ),
          const SizedBox(height: 17),
          _buildTextBlock(
            item,
            index,
            r,
            textTheme,
            colorScheme,
          ),
        ],
      ),
    );
  }

  // LANDSCAPE: Layout horizontal adaptif.
  Widget _buildLandscapePage(
    Map<String, Object> item,
    int index,
    Responsive r,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 4,
          child: _buildArtBox(item),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 6,
          child: SingleChildScrollView(
            child: _buildTextBlock(
              item,
              index,
              r,
              textTheme,
              colorScheme,
            ),
          ),
        ),
      ],
    );
  }

  // INDIKATOR HALAMAN DAN TOMBOL NAVIGASI.
  Widget _buildActions() {
    final int n = onboardingData.length;
    final double dotsWidth = 27 + 9.0 * (n - 1) + 6.0 * n + 2;

    return AdaptiveRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // MINGGU 6: ListView.builder untuk indikator halaman.
        SizedBox(
          width: dotsWidth,
          height: 15,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: n,
            itemBuilder: (context, i) {
              return Container(
                margin: const EdgeInsets.only(right: 6),
                width: i == step ? 27 : 9,
                height: 9,
                decoration: BoxDecoration(
                  color: i == step
                      ? AppColors.ink
                      : AppColors.white,
                  border: Border.all(
                    color: AppColors.ink,
                    width: 1.5,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 12),

        // MINGGU 7: Flexible menjaga tombol agar tidak overflow.
        Flexible(
          child: Align(
            alignment: Alignment.centerRight,
            child: NeoButton(
              fullWidth: false,
              text: step == 2 ? "Mulai" : "Lanjut",
              icon: const Icon(
                Icons.arrow_forward,
                color: AppColors.ink,
              ),
              onPressed: () {
                if (step < onboardingData.length - 1) {
                  _pageController.animateToPage(
                    step + 1,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                  );
                } else {
                  widget.onFinish();
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  // ILUSTRASI BERDASARKAN JENIS ART.
  Widget _buildArt(String artType) {
    if (artType == "lungs") {
      return const Icon(
        Icons.air,
        size: 90,
        color: AppColors.ink,
      );
    } else if (artType == "chart") {
      return const Icon(
        Icons.show_chart,
        size: 90,
        color: AppColors.ink,
      );
    } else {
      return const Icon(
        Icons.emoji_events,
        size: 90,
        color: AppColors.ink,
      );
    }
  }
}
