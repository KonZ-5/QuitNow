import 'package:flutter/material.dart';

/// Kategori ukuran layar yang dipakai di seluruh aplikasi.
///
/// - [ultraNarrow] : lebar <= 300 dp (layar sangat sempit, mis. 220-300 px)
/// - [compact]     : 301 - 599 dp  (ponsel potret)
/// - [medium]      : 600 - 899 dp  (ponsel landscape / tablet kecil)
/// - [expanded]    : >= 900 dp     (tablet landscape / desktop / web)
enum ScreenSize { ultraNarrow, compact, medium, expanded }

/// =======================================================================
/// RESPONSIVE HELPER
/// =======================================================================
///
/// KONSEP CONSTRAINT DI FLUTTER (ringkas)
/// --------------------------------------
/// Flutter menentukan ukuran widget dengan aturan:
///
///   "Constraints turun, ukuran naik, parent menentukan posisi."
///
///   1. PARENT memberi CONSTRAINT (minWidth, maxWidth, minHeight, maxHeight)
///      kepada CHILD.
///   2. CHILD memilih ukurannya sendiri, tetapi HARUS berada di dalam
///      constraint tersebut, lalu melaporkan ukuran itu ke parent.
///   3. PARENT menempatkan CHILD (posisi x, y).
///
/// Karena itu, sebuah `Container(width: 430)` tidak selalu berukuran 430:
/// jika parent hanya mengizinkan maxWidth 300, ukuran dipaksa menjadi 300.
/// Widget yang tidak "peduli" pada constraint (mis. Text dalam Row tanpa
/// Expanded) akan overflow -> itulah penyebab garis kuning-hitam.
///
/// Solusi yang dipakai pada proyek ini:
///   - Expanded / Flexible   : child mengikuti sisa ruang dari parent.
///   - LayoutBuilder         : membaca constraint dari PARENT langsung
///                             (lebih akurat dari lebar layar penuh).
///   - FittedBox             : mengecilkan child agar muat di constraint.
///   - ConstrainedBox        : membatasi lebar maksimum konten (tablet/web).
///   - MediaQuery            : membaca ukuran layar, orientasi, safe area.
///
/// Kelas ini membungkus MediaQuery agar keputusan layout konsisten.
class Responsive {
  Responsive._(this.size);

  /// Ukuran area yang tersedia (sudah memperhitungkan override di main.dart).
  final Size size;

  // ---- Breakpoint (dp) ----------------------------------------------------
  static const double ultraNarrowMax = 300;
  /// Lebar <= 330 dp: susunan horizontal (Row) diubah menjadi 1 kolom (Column).
  static const double stackMax = 330;
  static const double mediumMin = 600;
  static const double expandedMin = 900;

  /// Lebar maksimum konten agar tidak terlalu melebar di tablet / web.
  static const double maxContentWidth = 840;

  /// Lebar maksimum "bingkai" aplikasi pada layar yang sangat lebar.
  static const double maxFrameWidth = 960;

  /// Ambil data responsif dari [context].
  factory Responsive.of(BuildContext context) =>
      Responsive._(MediaQuery.sizeOf(context));

  // ---- Ukuran layar -------------------------------------------------------
  double get width => size.width;
  double get height => size.height;

  ScreenSize get screenSize {
    if (width <= ultraNarrowMax) return ScreenSize.ultraNarrow;
    if (width < mediumMin) return ScreenSize.compact;
    if (width < expandedMin) return ScreenSize.medium;
    return ScreenSize.expanded;
  }

  /// True pada layar 220 - 330 dp: widget yang berdampingan ditumpuk vertikal.
  bool get isStacked => width <= stackMax;

  bool get isUltraNarrow => screenSize == ScreenSize.ultraNarrow;
  bool get isCompact => width < mediumMin; // termasuk ultraNarrow
  bool get isMedium => screenSize == ScreenSize.medium;
  bool get isExpanded => screenSize == ScreenSize.expanded;
  bool get isWide => width >= mediumMin;

  // ---- Orientasi ----------------------------------------------------------
  Orientation get orientation =>
      width > height ? Orientation.landscape : Orientation.portrait;
  bool get isLandscape => orientation == Orientation.landscape;
  bool get isPortrait => orientation == Orientation.portrait;

  /// Tinggi layar pendek (mis. ponsel landscape) -> hemat ruang vertikal.
  bool get isShort => height < 480;

  // ---- ADAPTIVE: pola navigasi -------------------------------------------
  /// Portrait ponsel  -> BottomNav.
  /// Landscape/tablet -> SideNav (menghemat tinggi layar yang terbatas).
  bool get useSideNav => (isLandscape || isWide) && width > ultraNarrowMax;

  // ---- Nilai berdasarkan ukuran layar ------------------------------------
  /// Memilih nilai sesuai kategori layar. Nilai yang tidak diisi akan
  /// memakai fallback: ultraNarrow -> compact, medium -> compact,
  /// expanded -> medium -> compact.
  T pick<T>({
    required T compact,
    T? ultraNarrow,
    T? medium,
    T? expanded,
  }) {
    switch (screenSize) {
      case ScreenSize.ultraNarrow:
        return ultraNarrow ?? compact;
      case ScreenSize.compact:
        return compact;
      case ScreenSize.medium:
        return medium ?? compact;
      case ScreenSize.expanded:
        return expanded ?? medium ?? compact;
    }
  }

  /// Padding horizontal halaman.
  double get pagePadding =>
      pick(ultraNarrow: 10.0, compact: 20.0, medium: 28.0, expanded: 40.0);

  /// Padding bawah halaman: ruang untuk BottomNav bila dipakai.
  double get pageBottomPadding => useSideNav ? 24.0 : 100.0;
}
