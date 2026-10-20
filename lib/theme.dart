import 'package:flutter/material.dart';

class AppColors {
  static const Color green = Color(0xFF69D36E);
  static const Color darkGreen = Color(0xFF238636);
  static const Color mint = Color(0xFFDDF7DF);
  static const Color cream = Color(0xFFFFF9E9);
  static const Color yellow = Color(0xFFFFE66D);
  static const Color coral = Color(0xFFFF8A80);
  static const Color ink = Color(0xFF171717);
  static const Color white = Color(0xFFFFFFFF);
  static const Color text2 = Color(0xFF555555);
  static const Color muted = Color(0xFFEFEDE5);
  static const Color background = Color(0xFFE7E5DE);
  static const Color lightRed = Color(0xFFFFD2CE);
}

class NeoBoxDecoration extends BoxDecoration {
  NeoBoxDecoration({
    Color color = AppColors.white,
    Color borderColor = AppColors.ink,
    double borderWidth = 2.0,
    double shadowOffset = 4.0,
    Color shadowColor = AppColors.ink,
    BorderRadius? borderRadius,
  }) : super(
          color: color,
          border: Border.all(color: borderColor, width: borderWidth),
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: Offset(shadowOffset, shadowOffset),
              spreadRadius: 0,
              blurRadius: 0,
            ),
          ],
        );
}

class BadgeItem {
  final int days;
  final String name;
  final bool unlocked;
  final String color;

  BadgeItem({
    required this.days,
    required this.name,
    required this.unlocked,
    required this.color,
  });
}

class ArticleItem {
  final String id;
  final IconData icon;
  final String category;
  final String title;
  final String desc;
  final String time;
  final String tone;

  ArticleItem({
    required this.id,
    required this.icon,
    required this.category,
    required this.title,
    required this.desc,
    required this.time,
    required this.tone,
  });
}

final List<BadgeItem> globalBadges = [
  BadgeItem(days: 1, name: "Langkah Pertama", unlocked: true, color: "yellow"),
  BadgeItem(days: 3, name: "Awal yang Hebat", unlocked: true, color: "green"),
  BadgeItem(days: 7, name: "Pejuang Mingguan", unlocked: false, color: ""),
  BadgeItem(days: 14, name: "Dua Pekan Kuat", unlocked: false, color: ""),
  BadgeItem(days: 30, name: "Satu Bulan Baru", unlocked: false, color: ""),
  BadgeItem(days: 90, name: "Transformasi", unlocked: false, color: ""),
];

final List<ArticleItem> globalArticles = [
  ArticleItem(
    id: "health",
    icon: Icons.favorite,
    category: "KESEHATAN",
    title: "Tubuhmu mulai pulih sejak 20 menit pertama",
    desc: "Kenali perubahan positif yang terjadi setelah berhenti merokok.",
    time: "4 menit",
    tone: "mint",
  ),
  ArticleItem(
    id: "money",
    icon: Icons.account_balance_wallet,
    category: "KEUANGAN",
    title: "Ubah penghematan kecil jadi tujuan besar",
    desc: "Cara sederhana melihat estimasi uang yang tidak lagi dibelanjakan.",
    time: "3 menit",
    tone: "yellow",
  ),
  ArticleItem(
    id: "craving",
    icon: Icons.eco,
    category: "KEINGINAN MEROKOK",
    title: "Teknik 5D untuk melewati keinginan",
    desc: "Lima langkah praktis saat keinginan merokok datang.",
    time: "5 menit",
    tone: "white",
  ),
  ArticleItem(
    id: "habit",
    icon: Icons.auto_awesome,
    category: "KEBIASAAN SEHAT",
    title: "Bangun rutinitas pengganti yang bertahan",
    desc: "Mulai dari kebiasaan kecil yang terasa mudah dilakukan.",
    time: "4 menit",
    tone: "coral",
  ),
];