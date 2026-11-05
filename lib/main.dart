import 'package:flutter/material.dart';
import 'theme.dart';
import 'utils/responsive.dart';
import 'screens/onboarding_screen.dart';
import 'screens/setup_screen.dart';
import 'screens/app_shell.dart';

void main() {
  runApp(const QuitNowApp());
}

class QuitNowApp extends StatelessWidget {
  const QuitNowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuitNow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Inter',
      ),
      // RESPONSIVE: builder berada di atas Navigator, sehingga berlaku untuk
      // semua halaman dan dialog. Skala teks sistem dibatasi (0.85x - 1.3x)
      // agar pengguna dengan font besar tidak membuat layout overflow,
      // tetapi aksesibilitas tetap terjaga.
      builder: (context, child) {
        final mq = MediaQuery.of(context);
        return MediaQuery(
          data: mq.copyWith(
            textScaler: mq.textScaler.clamp(
              minScaleFactor: 0.85,
              maxScaleFactor: 1.3,
            ),
          ),
          child: child!,
        );
      },
      home: const SiteShell(),
    );
  }
}

class SiteShell extends StatefulWidget {
  const SiteShell({super.key});

  @override
  State<SiteShell> createState() => _SiteShellState();
}

class _SiteShellState extends State<SiteShell> {
  String phase = 'onboarding'; // 'onboarding', 'setup', 'app'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // CONSTRAINT: sebelumnya lebar dikunci 430 (Container(width: 430)),
          // sehingga tidak fleksibel. Sekarang:
          //  - Ponsel/tablet kecil: aplikasi mengisi SELURUH layar (tanpa bingkai).
          //  - Layar sangat lebar (web/desktop): dibatasi maxFrameWidth,
          //    dipusatkan, dan diberi bingkai.
          final bool isFramed =
              constraints.maxWidth > Responsive.maxFrameWidth;
          final double frameWidth =
              isFramed ? Responsive.maxFrameWidth : constraints.maxWidth;
          final double borderInset = isFramed ? 6 : 0; // 2 x border 3px

          final mq = MediaQuery.of(context);

          return Center(
            child: Container(
              width: frameWidth,
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                color: AppColors.cream,
                border: isFramed
                    ? Border.all(color: AppColors.ink, width: 3)
                    : null,
                boxShadow: isFramed
                    ? const [
                        BoxShadow(
                          color: Color(0x16000000),
                          offset: Offset(0, 0),
                          blurRadius: 40,
                        )
                      ]
                    : null,
              ),
              // PARENT -> CHILD: child (seluruh halaman) diberi tahu ukuran
              // sebenarnya yang tersedia lewat MediaQuery, sehingga
              // Responsive.of(context) di halaman mana pun membaca lebar
              // bingkai, bukan lebar jendela browser.
              child: MediaQuery(
                data: mq.copyWith(
                  size: Size(
                    frameWidth - borderInset,
                    constraints.maxHeight - borderInset,
                  ),
                ),
                child: _buildCurrentPhase(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCurrentPhase() {
    switch (phase) {
      case 'onboarding':
        return OnboardingScreen(onFinish: () => setState(() => phase = 'setup'));
      case 'setup':
        return SetupScreen(onComplete: () => setState(() => phase = 'app'));
      case 'app':
      default:
        return const AppShell();
    }
  }
}
