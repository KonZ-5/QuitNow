import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/onboarding_screen.dart';
import 'screens/setup_screen.dart';
import 'screens/app_shell.dart';

void main() {
  runApp(const QuitNowApp());
}

class QuitNowApp extends StatelessWidget {
  // PERBAIKAN 1: Menggunakan super.key untuk menggantikan gaya penulisan konstruktor lama
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
      home: const SiteShell(),
    );
  }
}

class SiteShell extends StatefulWidget {
  // PERBAIKAN 2: Menggunakan super.key untuk konsistensi struktur kode modern
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
      body: Center(
        child: Container(
          width: 430,
          constraints: const BoxConstraints(maxWidth: 430, minHeight: double.infinity),
          decoration: BoxDecoration(
            color: AppColors.cream,
            border: Border.all(color: AppColors.ink, width: 3),
            boxShadow: const [
              BoxShadow(
                color: Color(0x16000000),
                offset: Offset(0, 0),
                blurRadius: 40,
              )
            ],
          ),
          child: _buildCurrentPhase(),
        ),
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
