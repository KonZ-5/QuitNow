import 'package:flutter_test/flutter_test.dart';

import 'package:quit_now/main.dart'; // Sesuaikan import dengan nama package di pubspec.yaml

void main() {
  testWidgets('QuitNow smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const QuitNowApp());

    // Verifikasi bahwa aplikasi berjalan dan menampilkan elemen QuitNow.
    expect(find.text('QuitNow'), findsWidgets);
  });
}